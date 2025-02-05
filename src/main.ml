open Ast
open Evaluate
open Naive
open Printf

let () =
  let lexbuf = Lexing.from_channel stdin in
  let result =
    try
      Parser.program Scanner.tokenize lexbuf
    with
    | Failure msg ->
        failwith ("Lexer error: " ^ msg)
    | Parsing.Parse_error ->
        failwith "Parse error!"
  in
  print_expr result;
  printf "%s\n" (string_of_ast (run_evaluation naive_evaluation result))

