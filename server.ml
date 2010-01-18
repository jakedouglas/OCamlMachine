class serverhandler (reactor, host, port, existing_fd) =
  object(self)
  inherit Om_connection.connection (reactor, host, port, existing_fd)

  method on_connected () =
    print_string "Connected!\n";
    flush stdout;
    self#send_data("foooooo\n");
    self#close_after_writing();

  method on_disconnected (error) =
    print_string "Disconnected.\n";
    flush stdout;

  method on_receive_data (data) =
    print_string data;
    flush stdout;

end;;

let r = new Om_reactor.reactor() in

let on_start (reactor : Om_reactor.reactor) =
  print_string "Reactor started!\n";
  flush stdout;
  let handler r fd =
    let _ = new serverhandler (r, "", 0, fd) in
    ();
  in
  let _ = new Om_server.server (reactor, "127.0.0.1", 12345, handler) in
  ();
in

let on_stop (reactor : Om_reactor.reactor) =
  print_string "Reactor stopped.\n";
  flush stdout;
in

r#run(on_start, on_stop);
