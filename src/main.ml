open Ast

let () =
  let lexbuf = Lexing.from_channel stdin in
  let result =
    try
      Parser.program Scanner.tokenize lexbuf
    with
      | Failure msg -> failwith ("Lexer error: " ^ msg)
      | Parsing.Parse_error -> failwith "Parse error"
  in
  print_expr result
