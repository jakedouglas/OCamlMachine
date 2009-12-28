class dumbhttpclient (host, port) =
  object(self)
  inherit Em_connection.connection (host, port)

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