.PHONY: clean

all: request.cmo response.cmo

request.cmo: request.ml
	ocamlc -o request.cma str.cma request.ml

response.cmo: response.ml
	ocamlc -o response.cma str.cma response.ml

clean:
	-rm request.cm* request.mli response.cm* response.mli
