ocamlyacc parser.mly
ocamllex scanner.mll
ocamlc -c ast.ml 
ocamlc -c parser.mli
ocamlc -c parser.ml
ocamlc -c scanner.ml
ocamlc -c main.ml
ocamlc -o main \
  ast.cmo parser.cmo scanner.cmo main.cmo

