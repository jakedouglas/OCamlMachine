class virtual eventable (reactor) =
  object(self)
  val mutable fd = (None : Unix.file_descr option)
  val mutable reactor = reactor

  method get_fd () = match fd with | Some descr -> descr | None -> assert false

  method virtual select_for_read : unit -> bool
  method virtual select_for_write : unit -> bool
  method virtual handle_writeable : unit -> unit
  method virtual handle_readable : unit -> unit
  method virtual close : unit -> unit

end;;