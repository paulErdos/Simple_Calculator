#!/bin/env ocaml

open Printf;;

(* Not sure what this unit is for. *)
(* The unit as a sole argument in a function definition says that this function
   takes no arguments, and this is specified by stating that the function takes
   a unit as its sole argument.
   Then, for this function to be called properly, we must call it with a unit.
*)
(*
let foo () = print_string "Hello, world!\n";;

(* So execution begins here. *)
let _ = if not !Sys.interactive then
    print_string "Execution is in that weird function.\n";
    (* Not sure why we're passing a unit here. *)
    (* See above multiline comment *)
    foo ();;
*)
let long_stringy_integer =
    "111111111111111111111111111111111111111111111111111111111111111111110"^
    "211111111111111111111111111111111111111111111111111111111111111111110"^
    "311111111111111111111111111111111111111111111111111111111111111111110"^
    "411111111111111111111111111111111111111111111111111111111111111111110";;

(**)
let rec print_correctly_helper line_limit counter line =
    if (String.length line) = 1 then (
        printf "%s\n" line;
    )
    (* If the counter isn't over the line limit, AND
       if we still have stuff to print *)
    else if counter < (line_limit - 1) then (
        (* Print the letter at the front of the string *)
        print_char line.[0];
        (* Then print the rest! *)
        let length = ((String.length line) - 1) in
        let line' = (String.sub line 1 length) in
            print_correctly_helper line_limit (counter + 1) line';
    )
    (* Else, we are at the line limit so *)
    else (
        (* Print a delimiter and a newline *)
        print_string "\\\n";
        (* Reset the counter *)
        (* Then print the rest! *)
        print_correctly_helper line_limit 0 line;
    );;
let print_correctly = (print_correctly_helper 70 0);;

print_correctly long_stringy_integer;;
(**)
(*
let rec fill_stack_helper thestack input =
    if (String.length input) != 0 then (
        Stack.push input.[0] thestack;
        let length = ((String.length input) - 1) in
        let input' = (String.sub input 1 length) in
            fill_stack_helper thestack input';
    ) else thestack;;
let string_to_stack = (fill_stack_helper (Stack.create ()));;

let thestack = string_to_stack long_stringy_integer;;

Stack.iter (printf "%c") thestack;;
printf "\n\n";;
*)
(*
let rec print_stack_correctly_helper line_limit counter thestack =
    if (Stack.is_empty thestack) then ( printf "\n"; )
    (* If the counter isn't at the limit *)
    else if counter < (line_limit - 1) then (
        (* Print the letter on the top. *)
        printf "%c" (Stack.pop thestack);
        (* Then print the rest. *)
        print_stack_correctly_helper line_limit (counter + 1) thestack;
    )
    (* Else we're at the line limit *)
    else (
        (* Print a delimiter and a newline *)
        printf "\\\n";
        (* Reset the counter and print the rest *)
        print_stack_correctly_helper line_limit 0 thestack;
    );;
let print_stack_correctly = (print_stack_correctly_helper 70 0);;

print_stack_correctly thestack;;
*)

(*
let thestack = Stack.create ();
let int1 =
999999999999999999999999999999999999999999999999999999999999999999999999999999;;

Stack.push int1 thestack;
Stack.push int1 thestack;
Stack.push int1 thestack;
Stack.push int1 thestack;

let rec print_number_correctly line_limit counter thenumber =
    if thenumber != 0 then (
        print_int 
    )
*)
