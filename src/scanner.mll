{ open Parser } 

let alphabet = ['a'-'z' 'A'-'Z' '_' '0'-'9']

rule tokenize = parse
 [' ' '\t'] { tokenize lexbuf }
| "/*"     { comment lexbuf }           (* Comments *)
| "*/" {tokenize lexbuf}
| "lambda" {LAMBDA}
| "." {DOT}
| "(" {LPAREN}
| ")" {RPAREN}
| alphabet+ as var_name { VARIABLE(var_name) }
| "\n" {EOF}
| eof { EOF }
| _ as c { failwith (Printf.sprintf "Unexpected character: %c" c) }

and comment = parse
| eof  { failwith "Unterminated comment" }
| "*/" {tokenize lexbuf}
| _ {comment lexbuf}