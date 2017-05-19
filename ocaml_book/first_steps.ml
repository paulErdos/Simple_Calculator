(* Chapter 1: Way of the Program *)
(* 1.6: First program *)
print_int 4;;
print_string "\n";;

(* Chapter 2: Variables and Expressions *)
(* 2.1: Values and Types *)

(* Int *)
let a = 1;;

(* String *)
let foo = "Hello, world!\n";;

(* Char *)
let bar = 'a';;

(* 2.2: Variables *)
let message = "Don't forget to buy milk.\n";;

(* 2.3: Variable names and keywords *)
let variable_names_can_be_arbitrarily_long = 1;;
let variables_begin_with_lowercase_letters = 1;;
let identifiers_can_contain_apostrophes' = 1;;
let or_many_ap'o'st'rophes''''''' = 1;;
let a''' = 1;;

(* 2.4: Operators and operands *)
print_string "(4 + 200): ";;
print_int (4 + 200);;
print_char '\n';;

print_string "(4 - 200): ";;
print_int (4 - 200);;
print_char '\n';;

print_string "(4 * 200): ";;
print_int (4 * 200);;
print_char '\n';;

print_string "(4 / 200): ";;
print_int (4 / 200);;
print_char '\n';;

(* Concatenation of strings *)
let hello = "Hello, "^"world!"^"\n";;
print_string hello;;

let initial = "Conca";;
let medial = "tena";;
let final = "tion!\n";;
print_string (initial^medial^final);;

(* Type conversion *)
(* This converts a char to integer ASCII value *)
let char_4 = '4';;
let ascii_value_of_char_4  = int_of_char char_4;;
print_int ascii_value_of_char_4;;
print_string "\n";;

(* This converts a char to an int via ASCII *)
let char_8 = '8';;
let int_8  = int_of_char char_8 - int_of_char '0';;
print_int int_8;;
print_string "\n";;

(* 2.5: Expressions *)
let expression_definition = "\n2.5:\n"^
                            "An expression is a combination of values, "^
                            "variables, operators, and functions that "^
                            "returns a particular value.\n";;
print_string expression_definition;;

(* 2.6: Variables as expressions, and references *)
let what's_really_going_on =
    "\n2.6:\n"^
    "\"let x = 3;;\" means that the expression \'3\' is represented by \'x\'."^
    "\'x\' becomes a shorthand for \'3\'. You can't change the value of a "^
    "variable.\n";;
print_string what's_really_going_on;;

(* 2.7: Scope *)
(* let-in-binding:
    the value assigned by let only exists in the expression after 'in' *)
print_string "\n2.7:\n";;
let x = 0;;
open Printf;;

printf "x: %d\n" x;;
let x = 9999 in x + 1;;
printf "x: %d\n" x;;

(* 2.8: Order of Operations *)
printf "\n2.8:\n";;
(* Operators with the same precedence are evaluated from left to right *)
let foo = 1;;
let bar = 3;;
let r1 = foo / 2 * bar;; (* (deg/2)*bar; Division, then multiplication *)
(* To divide by 2bar *)
let r2 = foo / 2 / bar;; (* deg / (2bar); *)

(* 2.9: String Operations *)
printf "\n2.9:\n";;
(* You can't do operations on strings, and there is no operator overloading. *)

(* 2.10: Comments *)
printf "\n2.10\n";;
printf (* Hi, mom! *) "You can put comments anywhere.\n";;

(* 2.11: Debugging *)
printf "\n2.11:\n";;

(* Chapter 3: Functions *)
(* 3.1: Function Calls *)
printf "\n3.1:\n";;
printf "Here's the result of a call we've seen: %d\n" (int_of_char '0');;

(* 3.2: Math Functions *)
printf "\n3.2:\n";;
printf "pi = 4 atan 1: %f\n" (4. *. atan 1.0);;

(* 3.3: Composition *)
printf "\n3.3:\n";;

(* 3.4: Adding new functions *)
printf "\n3.4:\n";;

(* A single semicolon ends a line in a function definition, while a double
   semicolon ends the function definition. *)
let print_lyrics () =
    print_string "I'm a lumberjack and I'm okay\n";
    print_string "I sleep all night and I work all day.\n";;

let repeat_lyrics () =
    print_lyrics();
    print_lyrics();;

repeat_lyrics();;

(* 3.5: Definitions and Uses *)
printf "\n3.5:\n";;

(* 3.6: Flow of execution *)
printf "\n3.6:\n";;

(* 3.7: Parameters and arguments *)
printf "\n3.7:\n";;

let print_twice bruce =
print_int bruce;
print_string " ";
print_int bruce;
print_string "\n";;

print_twice 0;;
print_twice (3*4);;

(* Functions can take other functions as arguments. Such functions are called
   "higher-order functions", sometimes abbreviated "HOF". *)

(* 3.8: Functions are just renamed expressions *)
printf "\n3.8:\n";;

(* Using let inside a function requires the in keyword *)
let cat_twice part1 part2 =
    let cat = part1^part2^"\n" in cat^cat;;
(* The in is there so that the definition doesn't return anything. *)
printf "%s" (cat_twice "foo" "bar");;

(* 3.9: Scope and Functions *)
printf "\n3.9:\n";;

let line1 = "Bing tiddle ";;
let line2 = "tiddle bang.";;
printf "%s\n" (cat_twice line1 line2);;

(* 3.10: Stack diagrams *)
printf "\n3.10:\n";;

(* 3.11: Currying functions *)
printf "\n3.11:\n";;

let add a b = a + b;;
let add3 = add 3;;
let add4 b = add 4 b;;
(* "add 3" is a function, even though we're only giving it one argument.
   add a b is the function add a applied to b, which is the function
   add applied to a, and the result of that applied to b. *)
printf "%d\n" (add3 2);;
printf "%d\n" ((add 10) 100);;

(* Chapter 4: Program Flow *)
(* 4.1: Modulus Operator *)
printf "\n4.1:\n";;

printf "quotient: %d\n" (7 / 3);;
printf "remainder: %d\n" (7 mod 3);;

let last_two_digits arg =
    arg mod 100;;

printf "last two digits of 12345: %d\n" (last_two_digits 12345);;

(* 4.2: Boolean expressions *)
printf "\n4.2:\n";;
printf "true not equal true: %b\n" (5 <> 5);;

(* 4.3: Logical operations *)
printf "\n4.3:\n";;
printf "15 is divisible by 3 or 2: %b\n" (15 mod 3 = 0 || 15 mod 2 = 0);;

(* 4.4: Conditional execution *)
printf "\n4.4:\n";;

if 1 > 0
then printf "1 > 0\n"
else printf "1 <= 0\n";;

if -1 < 0
then begin
        printf "Use begin and end to do multiple things ";
        printf "in a branch of a conditional statement!\n";
     end
else printf "foo\n";;

(* 4.5: Chained conditionals *)
printf "\n4.5:\n";;

let choice = 'c';;

if choice = 'a'
    then printf "foo\n"
else if choice = 'b'
    then printf "bar\n"
else if choice = 'c'
    then printf "baz\n"
else printf "boof\n";;

(* 4.6: Keyboard input *)
printf "\n4.6:\n";;

(*
printf "Please input some text:\n";;
let input = read_line();;
printf "You said: %s\n\n" input;;

printf "Please input an integer:\n";;
let input = read_int();;
printf "You entered: %d\n\n" input;;

printf "Please enter a float:\n";;
let input = read_float();;
printf "You entered: %f\n\n" input;;
*)

(* 4.7: Pattern Matching *)
printf "\n4.7:\n";;

(* Not just text but literally any object. *)

(* Match different integers to get sign *)
let sign i = match i with
x when x < 0 -> -1
| 0 -> 0
| x -> 1;;

(* Negatives must be enclosed in parens... *)
printf "Sign of -200: %d\n" (sign (-200));;
(* Or must use the unary minus "~-". *)
printf "Sign of -100: %d\n\n" (sign ~-100);;

(* You can also tell ocaml to match anything by using an "_", and "as" can be
   used to rename a pattern so that it can be called in the result side. *)
let add3 i = match i with
(_ as x) -> x + 3;;

printf "Matching for an integer in an integer expression:\n";;
printf "Applying an integer: %d\n" (add3 0);;
printf "Applying a float: %d\n" (add3 3.141);;

(* Chapter 5: Recursive Functions *)
(* 5.1: Recursion *)
printf "\n5.1:\n";;


