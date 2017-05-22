open Printf;;
(*

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
(* printf "Applying a float: %d\n" (add3 3.141);; *)

(* Chapter 5: Recursive Functions *)
(* 5.1: Recursion *)
printf "\n5.1:\n";;

(* To define a recursive function, you have to say "let rec" *)
let rec countdown n =
    if n < 0
        then (
            printf "Blastoff!\n";
        )
        else (
            printf "%d\n" n;
            countdown (n - 1);
            () (* Why is this necessary? *)
        );;

countdown 9;;

(* 5.2: Infinite Recursion *)
printf "\n5.2:\n";;

(* 5.3: Mutually Recursive Functions *)
printf "\n5.3:\n";;

(* Use "and" to tell ocaml to compile both functions *)
(* Notice that the "let rec" applies to both functions *)
let
rec even x =
    printf "Checking evenness of %d\n" x;
    if x = 0
        then true
    else
        odd (x - 1)
and odd x =
    printf "Checking oddness of  %d\n" x;
    if x = 0
        then false
    else even (x - 1);;

even 5;;

(* 5.4: Tail-end Recursion *)
printf "\n5.4:\n";;

let rec rec_sum n =
    if n = 1
        then 1
    else n + (rec_sum (n - 1));;

(* Anything higher than 737963 stack overflows *)
(*
printf "sum from 1000000 to 1: %d\n" (rec_sum 1000000);;
*)

(* Same, done tail recursively *)
(* We define a helper function... *)
let rec sum_helper accum n =
    if n = 1
        then (accum + 1)
    else (sum_helper (accum + n) (n - 1));;

(* And a call function. *)
(* Note the currying: "sum_helper 0" is sum_helper with accum = 0 and the other
   argument open *)
let sum = sum_helper 0;;
printf "sum from 1000000 to 1: %d\n" (sum 1000000);;
(* I think, based on how this is done, that it just won't stack overflow *)

(* Chapter 6: Algorithms *)
(* 6.1: Square Roots *)
printf "\n6.1:\n";;

(* Chapter 7: Strings *)
(* 7.1: A string is a sequence *)
printf "\n7.1:\n";;

let fruit = "banana";;
let first_letter = fruit.[0];;
let second_letter = String.get fruit 1;;

printf "%c\n" first_letter;;
printf "%c\n" second_letter;;

(* Strings are mutable! *)
(* This is deprecated:
fruit.[1]<-'x';;
Instead use: *)
Bytes.set fruit 1 'x';;
printf "%s\n" fruit;;

(* 7.2: String.length *)
printf "\n7.2:\n";;

let len = String.length fruit;;
printf "%d\n" len;;
printf "%c\n" fruit.[(String.length fruit) - 1];;

(* 7.3: Substrings *)
printf "\n7.3:\n";;

let middle word =
    let len = String.length word - 2 in String.sub word 1 len

let a_word = "pumpernickel";;
printf "%s\n" a_word;;
printf "%s\n" (middle a_word);;

(* 7.4: String traversal *)
printf "\n7.4:\n";;

let rec traverse_print s =
    printf "%c\n" s.[0];
    let len = String.length s in
        if len = 1
            then ()
        else traverse_print (String.sub s 1 (len - 1));;

traverse_print "foobar";;

let prefixes = "ABCDEFGH";;
let suffix   = "ack";;

let rec ducklings prefixes suffix =
    printf "%s\n" ((String.sub prefixes 0 1) ^ suffix);
    let len = String.length prefixes in
    if len = 1 then ()
    else ducklings (String.sub prefixes 1 (len - 1)) suffix;;

ducklings prefixes suffix;;

let rec find_helper current sample letter =
    if sample.[current] = letter then current
    else if current = ((String.length sample) - 1) then -1
    else find_helper (current + 1) sample letter;;

let find = find_helper 0;;

printf "q in abc?: %d\n" (find "abc" 'q');;
printf "c in abc?: %d\n" (find "abc" 'c');;

(* 7.6: String comparison *)
printf "\n7.6:\n";;

let word = "banana";;
if word = "banana"
    then printf "All right, bananas.\n";;

let is_bananas word = print_string (
    match word with
        "bananas" -> "Your string is bananas!\n"
        | w when w < "bananas" -> "Your string is less than bananas!\n"
        | _ -> "Your string is more than bananas!\n");;

is_bananas "bananar";;
is_bananas "bananas";;
is_bananas "bananat";;

*)

(* Chapter 8: Lists *)
(* 8.1: A list is a sequence *)
printf "\n8.1:\n";;

let l1 = [10; 20; 30];;
let l2 = [l1; l1];;
let l3 = 'a'::'b'::'c'::[];;

(* The cons operator "::" prepends an element to a list *)
let rec listify_helper accumulator input =
    if (String.length input) = 0 then accumulator
    else
        let last = ((String.length input) - 1) in
        let accumulator = input.[last]::accumulator in
        let input = (String.sub input 0 last) in
        listify_helper accumulator input;;
let listify = (listify_helper []);;

let foo = "abcde";;
let foo_listified = listify foo;;

let () = List.iter (printf "%c\n") foo_listified;;

(* 8.2: List operations *)
printf "\n8.2:\n";;

(* "@" concatenates lists *)

let l4 = [1; 2];;
let l5 = [3; 4];;
let l4l5 = l4@l5;;

let () = List.iter (printf "%d\n") l4l5;;

(* 8.3: List iteration, mapping, and folding *)
printf "\n8.3:\n";;

let add3 e = e + 3 in List.map add3 forward;;


(* Chapter 9: (SKIPPED) *)
(* Chapter 10: (SKIPPED) *)
(* Chapter 11: Arrays *)
(* And that's probably enough for now. *)
