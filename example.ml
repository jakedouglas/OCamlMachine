class dumbhttpclient (host, port) =
  object(self)
  inherit Om_connection.connection (host, port)

  method on_connected () =
    print_string "Connected!\n";
    flush stdout;
    self#send_data("GET / HTTP/1.1\r\n\r\n");

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
  let c = new dumbhttpclient ("google.com", 80) in
  reactor#add(c);
in

let on_stop (reactor : Om_reactor.reactor) =
  print_string "Reactor stopped.\n";
  flush stdout;
in

r#run(on_start, on_stop);
