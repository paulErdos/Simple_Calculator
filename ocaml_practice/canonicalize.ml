open Printf;;

let l = 0::0::0::0::5::[];;

let rec canonicalize value =
    if (List.hd value) = 0
        then canonicalize (List.tl value)
    else value;;

List.iter (printf "%d") (canonicalize l);;
