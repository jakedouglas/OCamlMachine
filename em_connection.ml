class virtual connection (host, port) =
  object(self)
  val fd = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0
  val bytes_per_tick = 10240
  val mutable connect_pending = false
  val mutable outbound_buffer = ""

  method get_fd = fd

  method select_for_read () =
    not connect_pending

  method select_for_write () =
    connect_pending || String.length outbound_buffer > 0

  initializer
    let sockaddr = Unix.ADDR_INET((Unix.gethostbyname host).Unix.h_addr_list.(0), port) in
    Unix.set_nonblock fd;
    try
      Unix.connect fd sockaddr;
      connect_pending <- false;
    with
      | Unix.Unix_error(Unix.EINPROGRESS,_,_) ->
        (connect_pending <- true);

  method handle_writeable () =
    if connect_pending then (
      connect_pending <- false;
      self#on_connected();
      );

    let out_len = String.length outbound_buffer in

    if out_len > 0 then (
      let bytes_written =
        try
          Unix.send fd outbound_buffer 0 out_len []
        with
          | Unix.Unix_error(Unix.EAGAIN,_,_)
          | Unix.Unix_error(Unix.EWOULDBLOCK,_,_)
          | Unix.Unix_error(Unix.EINTR,_,_) ->
            (0);
      in

      if bytes_written > 0 then
        outbound_buffer <- String.sub outbound_buffer bytes_written (out_len - bytes_written);
      );
    ();

  method handle_readable () =
    let buf = String.create bytes_per_tick in
    let len =
      try
        Unix.recv fd buf 0 bytes_per_tick [];
      with
        | Unix.Unix_error(Unix.EAGAIN,_,_)
        | Unix.Unix_error(Unix.EWOULDBLOCK,_,_)
        | Unix.Unix_error(Unix.EINTR,_,_) ->
          (0);
    in

    if len > 0 then (
      self#on_receive_data((String.sub buf 0 len));
      self#handle_readable();
      );

    ();

  method send_data data =
    outbound_buffer <- String.concat "" [outbound_buffer ; data];

  method close () =
    Unix.shutdown fd Unix.SHUTDOWN_ALL;
    Unix.close fd;

  method virtual on_connected : unit -> unit
  method virtual on_disconnected : unit -> unit
  method virtual on_receive_data : string -> unit
end;;