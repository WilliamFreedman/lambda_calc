open Ast

let run_evaluation (eval_fn : expr -> expr) (expr : expr) : expr =
  eval_fn expr
