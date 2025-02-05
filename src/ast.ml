type expr = 
  | Var of string
  | Lambda of string * expr
  | Func_Apply of expr * expr

  open Printf

  let rec print_expr_tree (e : expr) (prefix : string) (is_last : bool) : unit =
    let branch = if is_last then "└── " else "├── " in
  
    match e with
    | Var x ->
        printf "%s%sVar %s\n" prefix branch x
  
    | Lambda (x, body) ->
        printf "%s%sLambda %s\n" prefix branch x;
        let next_prefix =
          if is_last then prefix ^ "    "
          else prefix ^ "│   "
        in
        print_expr_tree body next_prefix true
  
    | Func_Apply (left_expr, right_expr) ->
        printf "%s%sApply\n" prefix branch;
  
        let next_prefix =
          if is_last then prefix ^ "    "
          else prefix ^ "│   "
        in
        print_expr_tree left_expr next_prefix false;
        print_expr_tree right_expr next_prefix true

let print_expr (e : expr) : unit =
  print_expr_tree e "" true

let rec string_of_ast expr =
  match expr with
  | Var s ->
      s
  | Lambda (v, body) ->
      "(\\" ^ v ^ ". " ^ string_of_ast body ^ ")"
  | Func_Apply (e1, e2) ->
      "(" ^ string_of_ast e1 ^ " " ^ string_of_ast e2 ^ ")"