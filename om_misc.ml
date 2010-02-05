type unix_error_descr = {name:string; description:string;}
let unix_error_descr_table = Hashtbl.create 70;;

Hashtbl.add unix_error_descr_table Unix.E2BIG           { name = "E2BIG";           description = "Argument list too long"                          };;
Hashtbl.add unix_error_descr_table Unix.EACCES          { name = "EACCES";          description = "Permission denied"                               };;
Hashtbl.add unix_error_descr_table Unix.EAGAIN          { name = "EAGAIN";          description = "Resource temporarily unavailable; try again"     };;
Hashtbl.add unix_error_descr_table Unix.EBADF           { name = "EBADF";           description = "Bad file descriptor"                             };;
Hashtbl.add unix_error_descr_table Unix.EBUSY           { name = "EBUSY";           description = "Resource unavailable"                            };;
Hashtbl.add unix_error_descr_table Unix.ECHILD          { name = "ECHILD";          description = "No child process"                                };;
Hashtbl.add unix_error_descr_table Unix.EDEADLK         { name = "EDEADLK";         description = "Resource deadlock would occur"                   };;
Hashtbl.add unix_error_descr_table Unix.EDOM            { name = "EDOM";            description = "Domain error for math functions, etc."           };;
Hashtbl.add unix_error_descr_table Unix.EEXIST          { name = "EEXIST";          description = "File exists"                                     };;
Hashtbl.add unix_error_descr_table Unix.EFAULT          { name = "EFAULT";          description = "Bad address"                                     };;
Hashtbl.add unix_error_descr_table Unix.EFBIG           { name = "EFBIG";           description = "File too large"                                  };;
Hashtbl.add unix_error_descr_table Unix.EINTR           { name = "EINTR";           description = "Function interrupted by signal"                  };;
Hashtbl.add unix_error_descr_table Unix.EINVAL          { name = "EINVAL";          description = "Invalid argument"                                };;
Hashtbl.add unix_error_descr_table Unix.EIO             { name = "EIO";             description = "Hardware I/O error"                              };;
Hashtbl.add unix_error_descr_table Unix.EISDIR          { name = "EISDIR";          description = "Is a directory"                                  };;
Hashtbl.add unix_error_descr_table Unix.EMFILE          { name = "EMFILE";          description = "Too many open files by the process"              };;
Hashtbl.add unix_error_descr_table Unix.EMLINK          { name = "EMLINK";          description = "Too many links"                                  };;
Hashtbl.add unix_error_descr_table Unix.ENAMETOOLONG    { name = "ENAMETOOLONG";    description = "Filename too long"                               };;
Hashtbl.add unix_error_descr_table Unix.ENFILE          { name = "ENFILE";          description = "Too many open files in the system"               };;
Hashtbl.add unix_error_descr_table Unix.ENODEV          { name = "ENODEV";          description = "No such device"                                  };;
Hashtbl.add unix_error_descr_table Unix.ENOENT          { name = "ENOENT";          description = "No such file or directory"                       };;
Hashtbl.add unix_error_descr_table Unix.ENOEXEC         { name = "ENOEXEC";         description = "Not an executable file"                          };;
Hashtbl.add unix_error_descr_table Unix.ENOLCK          { name = "ENOLCK";          description = "No locks available"                              };;
Hashtbl.add unix_error_descr_table Unix.ENOMEM          { name = "ENOMEM";          description = "Not enough memory"                               };;
Hashtbl.add unix_error_descr_table Unix.ENOSPC          { name = "ENOSPC";          description = "No space left on device"                         };;
Hashtbl.add unix_error_descr_table Unix.ENOSYS          { name = "ENOSYS";          description = "Function not supported"                          };;
Hashtbl.add unix_error_descr_table Unix.ENOTDIR         { name = "ENOTDIR";         description = "Not a directory"                                 };;
Hashtbl.add unix_error_descr_table Unix.ENOTEMPTY       { name = "ENOTEMPTY";       description = "Directory not empty"                             };;
Hashtbl.add unix_error_descr_table Unix.ENOTTY          { name = "ENOTTY";          description = "Inappropriate I/O control operation"             };;
Hashtbl.add unix_error_descr_table Unix.ENXIO           { name = "ENXIO";           description = "No such device or address"                       };;
Hashtbl.add unix_error_descr_table Unix.EPERM           { name = "EPERM";           description = "Operation not permitted"                         };;
Hashtbl.add unix_error_descr_table Unix.EPIPE           { name = "EPIPE";           description = "Broken pipe"                                     };;
Hashtbl.add unix_error_descr_table Unix.ERANGE          { name = "ERANGE";          description = "Result too large"                                };;
Hashtbl.add unix_error_descr_table Unix.EROFS           { name = "EROFS";           description = "Read-only file system"                           };;
Hashtbl.add unix_error_descr_table Unix.ESPIPE          { name = "ESPIPE";          description = "Invalid seek e.g. on a pipe"                     };;
Hashtbl.add unix_error_descr_table Unix.ESRCH           { name = "ESRCH";           description = "No such process"                                 };;
Hashtbl.add unix_error_descr_table Unix.EXDEV           { name = "EXDEV";           description = "Invalid link"                                    };;
Hashtbl.add unix_error_descr_table Unix.EWOULDBLOCK     { name = "EWOULDBLOCK";     description = "Operation would block"                           };;
Hashtbl.add unix_error_descr_table Unix.EINPROGRESS     { name = "EINPROGRESS";     description = "Operation now in progress"                       };;
Hashtbl.add unix_error_descr_table Unix.EALREADY        { name = "EALREADY";        description = "Operation already in progress"                   };;
Hashtbl.add unix_error_descr_table Unix.ENOTSOCK        { name = "ENOTSOCK";        description = "Socket operation on non-socket"                  };;
Hashtbl.add unix_error_descr_table Unix.EDESTADDRREQ    { name = "EDESTADDRREQ";    description = "Destination address required"                    };;
Hashtbl.add unix_error_descr_table Unix.EMSGSIZE        { name = "EMSGSIZE";        description = "Message too long"                                };;
Hashtbl.add unix_error_descr_table Unix.EPROTOTYPE      { name = "EPROTOTYPE";      description = "Protocol wrong type for socket"                  };;
Hashtbl.add unix_error_descr_table Unix.ENOPROTOOPT     { name = "ENOPROTOOPT";     description = "Protocol not available"                          };;
Hashtbl.add unix_error_descr_table Unix.EPROTONOSUPPORT { name = "EPROTONOSUPPORT"; description = "Protocol not supported"                          };;
Hashtbl.add unix_error_descr_table Unix.ESOCKTNOSUPPORT { name = "ESOCKTNOSUPPORT"; description = "Socket type not supported"                       };;
Hashtbl.add unix_error_descr_table Unix.EOPNOTSUPP      { name = "EOPNOTSUPP";      description = "Operation not supported on socket"               };;
Hashtbl.add unix_error_descr_table Unix.EPFNOSUPPORT    { name = "EPFNOSUPPORT";    description = "Protocol family not supported"                   };;
Hashtbl.add unix_error_descr_table Unix.EAFNOSUPPORT    { name = "EAFNOSUPPORT";    description = "Address family not supported by protocol family" };;
Hashtbl.add unix_error_descr_table Unix.EADDRINUSE      { name = "EADDRINUSE";      description = "Address already in use"                          };;
Hashtbl.add unix_error_descr_table Unix.EADDRNOTAVAIL   { name = "EADDRNOTAVAIL";   description = "Can't assign requested address"                  };;
Hashtbl.add unix_error_descr_table Unix.ENETDOWN        { name = "ENETDOWN";        description = "Network is down"                                 };;
Hashtbl.add unix_error_descr_table Unix.ENETUNREACH     { name = "ENETUNREACH";     description = "Network is unreachable"                          };;
Hashtbl.add unix_error_descr_table Unix.ENETRESET       { name = "ENETRESET";       description = "Network dropped connection on reset"             };;
Hashtbl.add unix_error_descr_table Unix.ECONNABORTED    { name = "ECONNABORTED";    description = "Software caused connection abort"                };;
Hashtbl.add unix_error_descr_table Unix.ECONNRESET      { name = "ECONNRESET";      description = "Connection reset by peer"                        };;
Hashtbl.add unix_error_descr_table Unix.ENOBUFS         { name = "ENOBUFS";         description = "No buffer space available"                       };;
Hashtbl.add unix_error_descr_table Unix.EISCONN         { name = "EISCONN";         description = "Socket is already connected"                     };;
Hashtbl.add unix_error_descr_table Unix.ENOTCONN        { name = "ENOTCONN";        description = "Socket is not connected"                         };;
Hashtbl.add unix_error_descr_table Unix.ESHUTDOWN       { name = "ESHUTDOWN";       description = "Can't send after socket shutdown"                };;
Hashtbl.add unix_error_descr_table Unix.ETOOMANYREFS    { name = "ETOOMANYREFS";    description = "Too many references: can't splice"               };;
Hashtbl.add unix_error_descr_table Unix.ETIMEDOUT       { name = "ETIMEDOUT";       description = "Connection timed out"                            };;
Hashtbl.add unix_error_descr_table Unix.ECONNREFUSED    { name = "ECONNREFUSED";    description = "Connection refused"                              };;
Hashtbl.add unix_error_descr_table Unix.EHOSTDOWN       { name = "EHOSTDOWN";       description = "Host is down"                                    };;
Hashtbl.add unix_error_descr_table Unix.EHOSTUNREACH    { name = "EHOSTUNREACH";    description = "No route to host"                                };;
Hashtbl.add unix_error_descr_table Unix.ELOOP           { name = "ELOOP" ;          description = "Too many levels of symbolic links"               };;
Hashtbl.add unix_error_descr_table Unix.EOVERFLOW       { name = "EOVERFLOW";       description = "File size or position not representable"         };;

let unix_error_lookup err =
  Hashtbl.find unix_error_descr_table err
;;

let backtrace_and_fail () =
  prerr_string "Backtrace: \n";
  Printexc.print_backtrace stderr;
  assert false
;;

let handle_uncaught_exception exc =
  prerr_string "\n\nUncaught exception: ";
  prerr_string (Printexc.to_string exc);
  prerr_string "\n\n";

  backtrace_and_fail();
;;

let handle_uncaught_unix_error err =
  prerr_string "\n\nUncaught Unix_error: ";

  match err with
  | Unix.EUNKNOWNERR e ->
    (
      prerr_string "unknown Unix_error - error number: ";
      prerr_string (string_of_int e);
    );
  | _ ->
    (
      let descr = unix_error_lookup err in
      prerr_string descr.name;
      prerr_string ": ";
      prerr_string descr.description;
    );
  
  backtrace_and_fail();
;;

Printexc.record_backtrace true;;

let rec restart f arg =
  try f arg
  with
      Unix.Unix_error(Unix.EINTR,_,_) ->
	restart f arg
;;
