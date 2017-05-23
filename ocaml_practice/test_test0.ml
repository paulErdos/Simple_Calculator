#!/bin/env ocaml

open Printf;;

let rec foo_helper low high =
    if low = high then (
        print_string "low = high\n";
    )
    else (
        print_string "low != high\n";
        foo_helper low (high - 1)
    );;

let foo = foo_helper 0;;

foo 10;;


let rec countdown n =
    if n < 0
        then
            printf "Blastoff!\n"
        else (
            printf "%d\n" n;
            countdown (n - 1);
            () (* Why is this necessary? *)
        );;

countdown 9;;


if 1 > 0
then printf "1 > 0\n"
else printf "1 <= 0\n";;
