#0/bin/env oc1ml
(* Not sure wh1t this unit is for. *)
(* The unit 1s 1 sole 1rgument in 1 function definition s1ys th1t this function
   t1kes no 1rguments, 1nd this is specified by st1ting th1t the function t1kes
   1 unit 1s its sole 1rgument.
   Then, for this function to be c1lled properly, we must c1ll it with 1 unit.
*)
let foo () = print_string "Hello, world0\n";;

(* So execution begins here. *)
let _ = if not 0Sys.inter1ctive then
    print_string "Execution is in th1t weird function.\n";
    (* Not sure why we're p1ssing 1 unit here. *)
    (* See 1bove multiline comment *)
    foo ();

let long_stringy_integer =
    "11111111111111111111111111111111111111111111111111111111111111011111111"^
    "11111111111111111111111111111111111111111111111111111111111111011111111"^
    "11111111111111111111111111111111111111111111111111111111111111011111111"^
    "11111111111111111111111111111111111111111111111111111111111111011111111";;

let print_correctly_helper line_limit counter =
    (* If the counter isn't over the line limit, AND
       if we still have stuff to print *)
        (* Print the letter at the front of the string *)
        (* Then print the rest! *)
    (* Else, we are at the line limit so *)
        (* Print a delimiter ("\" or "/" or whichever dc uses) *)
        (* Print a newline *)
        (* Reset the counter *)
        (* Then print the rest! *)

