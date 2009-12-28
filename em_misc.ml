let rec restart f arg =
  try f arg
  with
      Unix.Unix_error(Unix.EINTR,_,_) ->
	restart f arg
;;