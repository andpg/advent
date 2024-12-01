let read_file file =
  let ic = open_in file in
  try
    let text = In_channel.input_all ic in
    String.trim text
  with e ->
    close_in_noerr ic;
    raise e

(* Assumes you're running in the project's root directory *)
let () = print_endline (read_file "./ocaml/01/input")
