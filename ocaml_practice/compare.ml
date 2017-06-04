let rec compare' value1 value2 =
    if List.length value1 = 0 && List.length value2 = 0
    then 0
    else if List.length value1 = List.length value2 then
        if List.hd value1 = List.hd value2
            then compare' (List.tl value1) (List.tl value2)
        else if List.hd value1 > List.hd value2
            then 1
        else
            -1
    else if List.length value1 > List.length value2
        then 1
    else
        -1;;

let compare value1 value2 =
    compare' (List.rev value1) (List.rev value2);;

let smaller1 = 0::0::0::0::5::[];;
let bigger1  = 1::0::0::0::5::[];;

print_int (compare bigger1 smaller1);;
print_string "\n";;

print_int (compare smaller1 bigger1);;
print_string "\n";;


let smaller2 = 1::0::0::0::5::[];;
let bigger2  = 0::0::1::0::5::[];;

print_int (compare bigger2 smaller2);;
print_string "\n";;

print_int (compare smaller2 bigger2);;
print_string "\n";;


print_int (compare smaller1 smaller1);;
print_string "\n";;
