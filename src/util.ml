open Ast 

let rec naive_substitute x value expr = 
  match expr with
  | Var v -> 
      if v = x then value else Var v
  | Lambda (y, body) ->
      if y = x then Lambda (y, body)
      else Lambda (y, naive_substitute x value body)
  | Func_Apply (e1, e2) ->
      Func_Apply (naive_substitute x value e1, naive_substitute x value e2)

let rec free_vars expr =
  match expr with
  | Var v -> [v]
  | Lambda (v, body) -> List.filter (fun x -> x <> v) (free_vars body)
  | Func_Apply (e1, e2) -> free_vars e1 @ free_vars e2

let fresh_var =
  let counter = ref 0 in
  fun () ->
    let v = "v" ^ string_of_int !counter in
    counter := !counter + 1;
    v

let rec capture_avoiding_substitute x value expr =
  match expr with
  | Var v ->
      if v = x then value else Var v
  | Lambda (y, body) ->
      if y = x then 
        Lambda (y, body)
      else if List.mem y (free_vars value) then
          let z = fresh_var () in
          let body' = capture_avoiding_substitute y (Var z) body in
          Lambda (z, capture_avoiding_substitute x value body')
      else 
          Lambda (y, capture_avoiding_substitute x value body)
  | Func_Apply (e1, e2) ->
      Func_Apply (capture_avoiding_substitute x value e1, capture_avoiding_substitute x value e2)
