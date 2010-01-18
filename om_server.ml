class server (reactor, host, port, handler) =
  object(self)
  inherit Om_eventable.eventable (reactor)
  val handler = handler

  initializer
    fd <- Some (Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0);
    let addr =
      try
        Unix.inet_addr_of_string(host)
      with
      | Failure _ ->
        (Unix.gethostbyname host).Unix.h_addr_list.(0);
    in
    let sockaddr = Unix.ADDR_INET(addr, port) in
    Unix.set_nonblock (self#get_fd());
    Unix.setsockopt (self#get_fd()) Unix.SO_REUSEADDR true;
    Unix.bind (self#get_fd()) sockaddr;
    Unix.listen (self#get_fd()) 100;
    reactor#add(self :> Om_eventable.eventable);

  method select_for_read () = true;
  method select_for_write () = false;

  method handle_readable () =
    let new_fd, sockaddr = Unix.accept (self#get_fd()) in
    let _ = (handler reactor (Some new_fd)) in
    ();

  (* we should never select writeable *)
  method handle_writeable () = assert false;

  method close () =
    try
      Unix.shutdown (self#get_fd()) Unix.SHUTDOWN_ALL;
    with
    | exc -> ();

    Unix.close (self#get_fd());
    reactor#remove(self :> Om_eventable.eventable);

end;;
