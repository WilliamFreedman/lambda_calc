(* Evaluation strategy that uses alpha substitution to avoid variable capture *)

open Util
open Generic_evaluator
let capture_avoiding_evaluation expr = generic_evaluate expr capture_avoiding_substitute
