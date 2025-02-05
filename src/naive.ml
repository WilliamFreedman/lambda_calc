(* Most basic implementation of a lambda calculus evaluator, no alpha conversion, probably not super performant
   Leftmost outermost strategy *)

open Ast

let rec naive_evaluation expr =
  match expr with
  | Var _ -> 
      expr
  | Lambda (x, body) -> 
      Lambda(x, naive_evaluation body)
  | Func_Apply (e1, e2) ->
      let e1' = naive_evaluation e1 in
      match e1' with
      | Lambda (x, body) ->
          let body' = substitute x e2 body in
            naive_evaluation body'
      | _ -> 
        let e2' = naive_evaluation e2 in
        Func_Apply (e1', e2')

and substitute x value expr = 
  match expr with
  | Var v -> 
      if v = x then value else Var v
  | Lambda (y, body) ->
      if y = x then Lambda (y, body)
      else Lambda (y, substitute x value body)
  | Func_Apply (e1, e2) ->
      Func_Apply (substitute x value e1, substitute x value e2)