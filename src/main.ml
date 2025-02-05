open Ast
open Evaluate
open Naive_evaluator
open Capture_avoiding_evaluator
open Printf

let () =
  if( Array.length Sys.argv) <2 then failwith ("Please select an evaluation strategy") else
  let evaluator_func = 
    let evaluator = Sys.argv.(1) in
    match evaluator with
  | "naive" ->  naive_evaluation
  | "capture_avoiding" -> capture_avoiding_evaluation
  | _ -> failwith ("Unknown evaluator selected: " ^ evaluator) in

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
  printf "%s\n" (string_of_ast (run_evaluation evaluator_func result))