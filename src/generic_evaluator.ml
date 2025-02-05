open Ast

let rec generic_evaluate expr substitutor =
  match expr with
  | Var _ -> 
      expr
  | Lambda (x, body) -> 
      Lambda(x, generic_evaluate body substitutor)
  | Func_Apply (e1, e2) ->
      let e1' = generic_evaluate e1 substitutor in
      match e1' with
      | Lambda (x, body) ->
          let body' = substitutor x e2 body in
          generic_evaluate body' substitutor
      | _ -> 
        let e2' = generic_evaluate e2 substitutor in
        Func_Apply (e1', e2')