.PHONY: clean

all: Mongrel2Request.cmo Mongrel2Response.cmo HTTPResponse.cmo

Mongrel2Request.cmo: Mongrel2Request.ml
	ocamlc -o Mongrel2Request.cmo -c str.cma Mongrel2Request.ml

Mongrel2Response.cmo: Mongrel2Response.ml
	ocamlc -o Mongrel2Response.cmo -c str.cma Mongrel2Response.ml

HTTPResponse.cmo: HTTPResponse.ml Mongrel2Response.cmo
	ocamlc -o HTTPResponse.cma -c Mongrel2Response.cmo HTTPResponse.ml

clean:
	-rm *.cm*
