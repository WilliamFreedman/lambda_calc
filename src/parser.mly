%{
    open Ast
%}

%token LAMBDA DOT LPAREN RPAREN EOF
%token <string> VARIABLE

%start program
%type <Ast.expr> program

%%

program: 
    expr EOF {$1}

expr:
    | LAMBDA VARIABLE DOT expr { Lambda($2, $4) }
    | application              { $1 }

application:
    application unit  { Func_Apply($1, $2) }
    | unit            { $1 }

unit:
    VARIABLE { Var($1) }
    | LPAREN expr RPAREN  { $2 }