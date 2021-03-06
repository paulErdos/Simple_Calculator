(* $Id: bigint.ml,v 2.5 2014-11-11 15:06:24-08 - - $ *)

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
          else if car1 = car2 && carry != 0
          then let dif = (car1 + 10) - (car2 + carry)
          in dif :: sub' cdr1 cdr2 carry
          else let dif = car1 - (car2 + carry)
          in dif :: sub' cdr1 cdr2 0

    let rec value_compare' value1 value2 =
        if List.length value1 = 0 && List.length value2 = 0
        then 0
        else if List.length value1 = List.length value2 then
            if List.hd value1 = List.hd value2
                then value_compare' (List.tl value1) (List.tl value2)
            else if List.hd value1 > List.hd value2
                then 1
            else
                -1
        else if List.length value1 > List.length value2
            then 1
        else
            -1

    let value_compare value1 value2 =
        value_compare' (List.rev value1) (List.rev value2)

    let rec canonicalize (Bigint (neg, value)) =
(*        let value = List.rev value in *)
        if (List.hd (List.rev value)) = 0
            then canonicalize 
                (Bigint (neg, (List.rev (List.tl (List.rev value)))))
        else Bigint(neg, value)

    let sub (Bigint (neg1, value1)) (Bigint (neg2, value2)) =
        if neg1 = neg2 && neg1 = Pos
            then if (value_compare value1 value2) > 0
                then canonicalize (Bigint (Pos, sub' value1 value2 0))
            else if (value_compare value1 value2) < 0
                then canonicalize (Bigint (Neg, sub' value2 value1 0))
            else zero
        else if neg1 = neg2 && neg1 = Neg
            then if (value_compare value1 value2) > 0
                then canonicalize (Bigint (Neg, sub' value1 value2 0))
            else if (value_compare value1 value2) < 0
                then canonicalize (Bigint (Pos, sub' value2 value1 0))
            else zero
        else canonicalize (Bigint (neg1, add' value1 value2 0))

    let add (Bigint (neg1, value1)) (Bigint (neg2, value2)) =
        if neg1 = neg2
        then Bigint (neg1, add' value1 value2 0)
        (* else zero *)
        else if neg1 = Pos
        then sub (Bigint (neg1, value1)) (Bigint (Pos, value2))
        else sub (Bigint (neg2, value2)) (Bigint (Pos, value1))

    (* let sub = add *)
(* End my code for test2 *)

(* Begin my code for test3 *)
    let double number = add number number

    let rec mul' (multiplier, powerof2, multiplicand') =
        if (value_compare powerof2 multiplier) > 0
        then multiplier, [0]
        else
            let Bigint(neg_pow, double_powerof2) =
                double (Bigint (Pos, powerof2))
            in let Bigint(neg_mul, double_multiplicand') =
                double (Bigint (Pos, multiplicand'))
            in let remainder, product =
                 mul' 
                    (multiplier, double_powerof2, double_multiplicand')
            in if (value_compare remainder powerof2) < 0
                 then remainder, product
                 else
                    let Bigint (neg_dif, val_dif) =
                        sub (Bigint (Pos, remainder))
                            (Bigint (Pos, powerof2))
                    in let Bigint (neg_sum, val_sum) =
                        add (Bigint (Pos, product)) 
                            (Bigint (Pos, multiplicand'))
                    in
                        val_dif, val_sum

    let mul (Bigint (neg1, multiplier)) (Bigint (neg2, multiplicand)) =
        if neg1 = neg2
        then let remainder, product =
            mul' (multiplier, [1], multiplicand)
        in Bigint (Pos, product)
        else let remainder, product =
            mul' (multiplier, [1], multiplicand)
        in Bigint (Neg, product)

    let rec divrem' (dividend, powerof2, divisor') =
        if (value_compare divisor' dividend) > 0
        then [0], dividend
        else
            let Bigint (neg_pow, double_powerof2) =
                double (Bigint (Pos, powerof2))
            in let Bigint (neg_divisor', double_divisor') =
                double (Bigint (Pos, divisor'))
            in let quotient, remainder =
                 divrem' (dividend, double_powerof2, double_divisor')
            in
                if (value_compare remainder divisor') < 0
                 then quotient, remainder
                 else
                    let Bigint(neg_sum, val_sum) =
                    add (Bigint (Pos, quotient))
                        (Bigint (Pos, powerof2))
                    in let Bigint (neg_dif, val_dif) =
                    sub (Bigint (Pos, remainder))
                        (Bigint (Pos, divisor'))
                    in val_sum, val_dif

    let divrem (dividend, divisor') = divrem' (dividend, [1], divisor')

    let div (Bigint (neg_dividend, val_dividend))
            (Bigint (neg_divisor, val_divisor)) =
        if neg_dividend = neg_divisor
        then let quotient, remainder =
            divrem (val_dividend, val_divisor)
        in Bigint (Pos, quotient)
        else let quotient, remainder =
            divrem (val_dividend, val_divisor)
        in Bigint (Neg, quotient)

    let rem (Bigint (neg_dividend, val_dividend))
            (Bigint (neg_divisor, val_divisor)) =
        let quotient, remainder = divrem (val_dividend, val_divisor)
        in 
(*
        printf "rem: ";
        List.iter (printf "%d") remainder;
        printf "\n";
*)
        if neg_dividend = neg_divisor 
        then Bigint (Pos, remainder)
        else Bigint (Neg, remainder)
        

(*
    let mul = add
    let div = add
    let rem = add
*)
(* End my code for test3 *)

(* Begin my code for test4 *)
(*    let pow = add*)
    
(*
    let even number = number mod 2 = 0
*)

    let even number =
        rem (Bigint (Pos, number)) (Bigint (Pos, [2])) = zero

    let rec power' (base, expt, result) = match expt with
        | [0]                   -> result
        | expt when even expt   -> 
            let Bigint (neg_mul, val_mul) =
                (mul (Bigint (Pos, base)) (Bigint (Pos, base)))
            in let
            Bigint (neg_div, val_div) =
                div (Bigint (Pos, expt)) (Bigint (Pos, [2]))
            in power' (val_mul, val_div, result)
        | expt                  -> 
            let Bigint (neg_sub, val_sub) =
                sub (Bigint (Pos, expt)) (Bigint (Pos, [1]))
            in let
            Bigint (neg_mul, val_mul) =
                mul (Bigint (Pos, base)) (Bigint (Pos, result))
            in power' (base, val_sub, val_mul)

    let pow (Bigint (neg_base, val_base)) 
        (Bigint (neg_expt, val_expt)) =
        if neg_expt = Neg then zero
        else Bigint (neg_base, power' (val_base, val_expt, [1]))



(* End my code for test4 *)
end

