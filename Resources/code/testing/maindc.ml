(* $Id: maindc.ml,v 1.5 2017-04-07 13:24:41-07 - - $ *)

include Scanner
include Bigint

open Bigint
open Printf
open Scanner

type stack_t = Bigint.bigint Stack.t
let push = Stack.push
let pop = Stack.pop

let ord thechar = int_of_char thechar
type binop_t = bigint -> bigint -> bigint

(* begin my code for test0 *)
let rec print_correctly_helper line_limit counter line =
    if (String.length line) = 1 then (
        printf "%s\n%!" line;
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

(*
let print_number number = printf "%s\n%!" (string_of_bigint number)
*)
let print_number number = print_correctly (string_of_bigint number)

(* end my code for test0 *)

(* Begin my code for test5 *)
(*let print_stackempty () = printf "stack empty\n%!"*)
let print_stackempty () = printf "dc: stack empty\n%!"
(* End my code for test5 *)

(* Begin my code for test6 *)

let symbol_table = Array.make 256 (false, Bigint.zero)
let aget = Array.get
let aset = Array.set
let amake = Array.make
let ord = Char.code
(*
let do_command = function
    | 'l' sym -> (
         let entry = aget symbol_table (ord sym)
         in match entry with
            | false, _ -> printf "register '%c' is empty\n%!" sym
            | true, value -> printf "%c = %g\n%!" sym value
      )
    | 's' (sym, value) -> (
         aset symbol_table (ord sym) (true, value);
         printf "%c := %g\n%!" sym value
      )
*)

let load reg thestack =
    let entry = aget symbol_table reg
    in match entry with
       | false, _ -> printf "register 0%o is empty\n%!" reg
       | true, value -> (*printf "%c = %g\n%!" sym value*)
                        push value thestack

let store reg thestack =
    aset symbol_table reg (true, (pop thestack))
    (*printf "%c := %g\n%!" sym value*)


let executereg (thestack: stack_t) (oper: char) (reg: int) =
    try match oper with
        | 'l' -> load reg thestack
        | 's' -> store reg thestack
        | _   -> printf "0%o 0%o is unimplemented\n%!" (ord oper) reg
    with Stack.Empty -> print_stackempty()

(* End my code for test6 *)

let executebinop (thestack: stack_t) (oper: binop_t) =
    try let right = pop thestack
        in  try let left = pop thestack
                in  push (oper left right) thestack
            with Stack.Empty -> (print_stackempty ();
                                 push right thestack)
    with Stack.Empty -> print_stackempty ()

let execute (thestack: stack_t) (oper: char) =
    try match oper with
        | '+'  -> executebinop thestack Bigint.add
        | '-'  -> executebinop thestack Bigint.sub
        | '*'  -> executebinop thestack Bigint.mul
        | '/'  -> executebinop thestack Bigint.div
        | '%'  -> executebinop thestack Bigint.rem
        | '^'  -> executebinop thestack Bigint.pow
        | 'c'  -> Stack.clear thestack
        | 'd'  -> push (Stack.top thestack) thestack
        | 'f'  -> Stack.iter print_number thestack
        | 'l'  -> failwith "operator l scanned with no register"
        | 'p'  -> print_number (Stack.top thestack)
        | 'q'  -> raise End_of_file
        | 's'  -> failwith "operator s scanned with no register"
        | '\n' -> ()
        | ' '  -> ()
        | _    -> printf "0%o is unimplemented\n%!" (ord oper)
    with Stack.Empty -> print_stackempty()

let toploop (thestack: stack_t) inputchannel =
    let scanbuf = Lexing.from_channel inputchannel in
    let rec toploop () = 
        try  let nexttoken = Scanner.scanner scanbuf
             in  (match nexttoken with
                 | Number number       -> push number thestack
                 | Regoper (oper, reg) -> executereg thestack oper reg
                 | Operator oper       -> execute thestack oper
                 );
             toploop ()
        (* begin my code for test0 *)
        (* with End_of_file -> printf "End_of_file\n%!"; *)
        with End_of_file -> printf "%!";
        (* end my code for test0 *)
    in  toploop ()

let readfiles () =
    let thestack : bigint Stack.t = Stack.create ()
    in  ((if Array.length Sys.argv > 1 
         then try  let thefile = open_in Sys.argv.(1)
                   in  toploop thestack thefile
              with Sys_error message -> (
                   printf "%s: %s\n%!" Sys.argv.(0) message;
                   exit 1));
        toploop thestack stdin)

let interact () =
    let thestack : bigint Stack.t = Stack.create ()
    in  toploop thestack stdin

let _ = if not !Sys.interactive then readfiles ()

