(* $Id: bigint.ml,v 1.5 2014-11-11 15:06:24-08 - - $ *)

open Printf

module Bigint = struct

    type sign     = Pos | Neg
    type bigint   = Bigint of sign * int list
    let  radix    = 10
    let  radixlen =  1

    let car       = List.hd
    let cdr       = List.tl
    let map       = List.map
    let reverse   = List.rev
    let strcat    = String.concat
    let strlen    = String.length
    let strsub    = String.sub
    let zero      = Bigint (Pos, [])

    let charlist_of_string str = 
        let last = strlen str - 1
        in  let rec charlist pos result =
            if pos < 0
            then result
            else charlist (pos - 1) (str.[pos] :: result)
        in  charlist last []

    let bigint_of_string str =
        let len = strlen str
        in  let to_intlist first =
                let substr = strsub str first (len - first) in
                let digit char = int_of_char char - int_of_char '0' in
                map digit (reverse (charlist_of_string substr))
            in  if   len = 0
                then zero
                else if   str.[0] = '_'
                     then Bigint (Neg, to_intlist 1)
                     else Bigint (Pos, to_intlist 0)

    let string_of_bigint (Bigint (sign, value)) =
        match value with
        | []    -> "0"
        | value -> let reversed = reverse value
                   in  strcat ""
                       ((if sign = Pos then "" else "-") ::
                        (map string_of_int reversed))

    let rec add' list1 list2 carry = match (list1, list2, carry) with
        | list1, [], 0       -> list1
        | [], list2, 0       -> list2
        | list1, [], carry   -> add' list1 [carry] 0
        | [], list2, carry   -> add' [carry] list2 0
        | car1::cdr1, car2::cdr2, carry ->
          let sum = car1 + car2 + carry
          in  sum mod radix :: add' cdr1 cdr2 (sum / radix)

(* Begin my code for test2 *)
    let rec sub' list1 list2 carry = match (list1, list2, carry) with
        | list1, [], 0       -> list1
        | [], list2, 0       -> list2
        | list1, [], carry   -> sub' list1 [carry] 0
        | [], list2, carry   -> sub' [carry] list2 0
        | car1::cdr1, car2::cdr2, carry ->
          if car1 < car2
          then let dif = (car1 + 10) - (car2 + carry)
          in dif :: sub' cdr1 cdr2 1
          else let dif = car1 - (car2 + carry)
          in dif :: sub' cdr1 cdr2 0

    let rec bigint_compare' value1 value2 =
        if List.length value1 = 0 && List.length value2 = 0
        then 0
        else if List.length value1 = List.length value2 then
            if List.hd value1 = List.hd value2
                then bigint_compare' (List.tl value1) (List.tl value2)
            else if List.hd value1 > List.hd value2
                then 1
            else
                -1
        else if List.length value1 > List.length value2
            then 1
        else
            -1

    let bigint_compare value1 value2 =
        bigint_compare' (List.rev value1) (List.rev value2)

    let sub (Bigint (neg1, value1)) (Bigint (neg2, value2)) =
        if neg1 = neg2 && neg1 = Pos
            then if (bigint_compare value1 value2) > 0
                then Bigint (Pos, sub' value1 value2 0)
            else if (bigint_compare value1 value2) < 0
                then Bigint (Neg, sub' value2 value1 0)
            else zero
        else if neg1 = neg2 && neg1 = Neg
            then if (bigint_compare value1 value2) > 0
                then Bigint (Neg, sub' value1 value2 0)
            else if (bigint_compare value1 value2) < 0
                then Bigint (Pos, sub' value2 value1 0)
            else zero
        else Bigint (neg1, add' value1 value2 0)

    let add (Bigint (neg1, value1)) (Bigint (neg2, value2)) =
        if neg1 = neg2
        then Bigint (neg1, add' value1 value2 0)
        (* else zero *)
        else if neg1 = Pos
        then sub (Bigint (neg1, value1)) (Bigint (Pos, value2))
        else sub (Bigint (neg2, value2)) (Bigint (Pos, value1))

    (* let sub = add *)


(* End my code for test2 *)
    let mul = add

    let div = add

    let rem = add

    let pow = add

end

