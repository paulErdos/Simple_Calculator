#!/bin/env ocaml

(*
* Example of how to run ocaml as a script.
*
* Normally, one could just name the executable (ocaml) to be used
* as the interpreter, since ocaml ignores the first line if it
* begins with a hashbang.  However, since ocaml is itself an
* executable
* /afs/cats.ucsc.edu/courses/cmps112-wm/usr/ocaml/bin/ocamlrun
* script, we can not hashbang a hashbanged script.  So we run
* /bin/env instead, which in turn just runs its single argument.
*)

open Printf;;

let rcsid = "$Id: hashbang.ml,v 361.2 2006-02-17 13:30:32-08 - - $";;

printf "rcsid = %s\n" rcsid;;
printf "interactive = %b\n" !Sys.interactive;;
printf "word_size = %d\n" Sys.word_size;;
printf "max_int = %d\n" max_int;;
printf "max_string_length = %d = 0x%08X\n"
       Sys.max_string_length Sys.max_string_length;;
printf "max_array_length = %d = 0x%08X\n"
       Sys.max_array_length Sys.max_array_length;;
printf "getcwd () = %s\n" (Sys.getcwd ());;
printf "os_type = %s\n" Sys.os_type;;

printf "executable_name = %s\n" Sys.executable_name;;
Array.iteri (fun i s -> printf "argv.(%d) = %s\n" i s) Sys.argv;;

