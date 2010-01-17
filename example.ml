class dumbhttpclient (reactor, host, port) =
  object(self)
  inherit Om_connection.connection (reactor, host, port)

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
  let _ = new dumbhttpclient (reactor, "google.com", 80) in
  reactor#add_timer(2.5, 
    (fun _ -> 
      print_string "Hopefully downloaded some data.\n";
      flush stdout;
      )
    );
  reactor#add_timer(3.0, (fun _ -> reactor#stop()));
  ();
in

let on_stop (reactor : Om_reactor.reactor) =
  print_string "Reactor stopped.\n";
  flush stdout;
in

r#run(on_start, on_stop);
