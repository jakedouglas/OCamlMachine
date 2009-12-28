class reactor () =
  object(self)
    val mutable running = false
    val mutable should_stop = false
    val mutable conns = Hashtbl.create 100
    val mutable conns_to_delete = []
    val mutable sighandler = (fun _ -> ())

    initializer
      sighandler <- (fun _ -> should_stop <- true);
      Sys.set_signal Sys.sigint (Sys.Signal_handle sighandler);

    method run ((on_start : reactor -> unit), (on_stop : reactor -> unit)) =
      should_stop <- false;
      running <- true;
      on_start(self :> reactor);
      while should_stop == false do
        self#tick();
      done;
      running <- false;
      on_stop(self :> reactor);
      ();

    method tick () =
      let read_fds = Hashtbl.fold
        (fun fd conn l -> if conn#select_for_read() then fd :: l else l)
        conns
        []
      in
      let write_fds = Hashtbl.fold
        (fun fd conn l -> if conn#select_for_write() then fd :: l else l)
        conns
        []
      in

      let readable, writeable, _ = Om_misc.restart (Unix.select read_fds write_fds []) 0.01 in

      Hashtbl.iter
        (fun fd conn ->
          if List.mem fd readable then
            conn#handle_readable();
          if List.mem fd writeable then
            conn#handle_writeable();
          )
        conns;

      (* remove any connections that closed themselves during the tick *)
      List.iter (fun fd -> Hashtbl.remove conns fd) conns_to_delete;

      ();

    method add (conn : Om_connection.connection) =
      Hashtbl.add conns conn#get_fd conn;

    method remove (conn : Om_connection.connection) =
      conns_to_delete <- conn#get_fd :: conns_to_delete;

    method stop () =
      should_stop <- true;
  end;;