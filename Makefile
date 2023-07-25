OCAML_SRC = src/todo.ml src/file_io.ml src/user_input.ml src/interactive_cli.ml src/config.ml src/main.ml
OUTPUT = todo_manager
OCAML_COMPILER = ocamlc
OCAML_FLAGS = -o $(OUTPUT)

all:
\t$(OCAML_COMPILER) $(OCAML_FLAGS) $(OCAML_SRC)

clean:
\trm -f $(OUTPUT) *.cmi *.cmo

.PHONY: all clean
