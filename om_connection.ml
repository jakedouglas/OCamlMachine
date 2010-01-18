class virtual connection (reactor, host, port, existing_fd) =
  object(self)
  inherit Om_eventable.eventable (reactor)
  val bytes_per_read = 16384
  val mutable connected = false
  val mutable connect_pending = false
  val mutable outbound_buffer = ""
  val mutable shutdown_after_writing = false

  initializer
    (match existing_fd with
    | Some descr -> (
      fd <- Some descr;
      Unix.set_nonblock (self#get_fd());
      Unix.setsockopt (self#get_fd()) Unix.SO_REUSEADDR true;
      connected <- true;
      self#on_connected();
      );

    | None -> (
      fd <- Some (Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0);
      Unix.set_nonblock (self#get_fd());
      Unix.setsockopt (self#get_fd()) Unix.SO_REUSEADDR true;
      (* try to parse as an IP address before we use gethostbyname *)
      let addr =
        try
          Unix.inet_addr_of_string(host)
        with
        | Failure _ ->
          (Unix.gethostbyname host).Unix.h_addr_list.(0);
      in
      let sockaddr = Unix.ADDR_INET(addr, port) in
      try
        Unix.connect (self#get_fd()) sockaddr;
        connect_pending <- false;
      with
        | Unix.Unix_error(Unix.EINPROGRESS,_,_) ->
          (connect_pending <- true);
      );
    );

    reactor#add(self :> Om_eventable.eventable);

  method select_for_read () =
    not connect_pending

  method select_for_write () =
    connect_pending || String.length outbound_buffer > 0

  method handle_writeable () =
    if connect_pending then (
      match Unix.getsockopt_error (self#get_fd()) with
      | None ->
        connect_pending <- false;
        connected <- true;
        self#on_connected();
      | Some error ->
        self#close();
        self#on_disconnected(Some error);
      );

    let out_len = String.length outbound_buffer in

    if connected && out_len > 0 then (
      let bytes_written =
        try
          Unix.send (self#get_fd()) outbound_buffer 0 out_len []
        with
          | Unix.Unix_error(Unix.EAGAIN,_,_)
          | Unix.Unix_error(Unix.EWOULDBLOCK,_,_)
          | Unix.Unix_error(Unix.EINTR,_,_) ->
            (0);
      in

      if bytes_written > 0 then
        outbound_buffer <- String.sub outbound_buffer bytes_written (out_len - bytes_written);
      );

    if shutdown_after_writing && (String.length outbound_buffer) == 0 then (self#close());
    ();

  method handle_readable () =
    let buf = String.create bytes_per_read in
    let len =
      try
        Unix.recv (self#get_fd()) buf 0 bytes_per_read [];
      with
        | Unix.Unix_error(Unix.EAGAIN,_,_)
        | Unix.Unix_error(Unix.EWOULDBLOCK,_,_)
        | Unix.Unix_error(Unix.EINTR,_,_) ->
          (-1);
    in

    if len > 0 then (
      self#on_receive_data((String.sub buf 0 len));
      self#handle_readable();
      );

    (* if we read 0 bytes then the peer closed gracefully *)
    if len == 0 then (
      self#close();
      self#on_disconnected(None);
      );

    ();

  method send_data data =
    outbound_buffer <- String.concat "" [outbound_buffer ; data];

  method close () =
    try
      Unix.shutdown (self#get_fd()) Unix.SHUTDOWN_ALL;
    with
    | exc -> ();

    Unix.close (self#get_fd());
    connected <- false;
    reactor#remove(self :> Om_eventable.eventable);

  method close_after_writing () =
    shutdown_after_writing <- true;

  method virtual on_connected : unit -> unit
  method virtual on_disconnected : Unix.error option -> unit
  method virtual on_receive_data : string -> unit
end;;