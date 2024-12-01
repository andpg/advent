let read_file file =
  let ic = open_in file in
  try
    String.trim (In_channel.input_all ic)
  with e ->
    close_in_noerr ic; raise e;;

exception Non_parsable

let get_lists () = 
  (* Assumes you're running in the project's root directory *)
  let text = read_file "./ocaml/01/input" in
  let lines = Str.split (Str.regexp "\n") text in
  let into_numbers line =
    match Str.split (Str.regexp " +") line with
    | x::y::[] -> (int_of_string x, int_of_string y)
    | _ -> raise Non_parsable in
  let unzip (ll, rl) (x, y) = (x::ll, y::rl) in
  List.map into_numbers lines
    |> List.fold_left unzip ([], []);;

exception Different_lengths

let part1 () =
  let (left_list, right_list) = get_lists () in
  let sort l = List.sort compare l in
  let rec distance paired_lists =
    match paired_lists with
    | [], [] -> 0
    | x::ll, y::rl -> Int.abs (x-y) + distance (ll, rl)
    | _ -> raise Different_lengths in
  distance (sort left_list, sort right_list);;

let part2 () = 
  let (left_list, right_list) = get_lists () in
  let score elem = right_list
    |> List.filter (fun x -> x = elem)
    |> List.length
    |> ( * ) elem in
  List.map score left_list
    |> List.fold_left (+) 0;;

print_int (part1 ());
print_endline "";
print_int (part2 ());;
