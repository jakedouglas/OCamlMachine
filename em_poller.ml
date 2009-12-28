class poller () =
  object(self)
  method poll read_fds write_fds err_fds =
    Unix.select read_fds write_fds err_fds 1.0;
end;;