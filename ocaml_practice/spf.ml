#!/bin/env/ ocaml

open Printf;;

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
