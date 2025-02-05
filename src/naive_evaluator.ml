(* Most basic implementation of a lambda calculus evaluator, no alpha conversion, probably not super performant
   Leftmost outermost strategy *)

open Util
open Generic_evaluator

let naive_evaluation expr = generic_evaluate expr naive_substitute
