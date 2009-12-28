let r = new Em_reactor.reactor() in

let on_start (reactor : Em_reactor.reactor) =
  print_string "Reactor started!\n";
  flush stdout;
  let c = new Em_dumb_http_client.dumbhttpclient ("google.com", 80) in
  reactor#add(c);
in

let on_stop (reactor : Em_reactor.reactor) =
  print_string "Reactor stopped.\n";
  flush stdout;
in

r#run(on_start, on_stop);
