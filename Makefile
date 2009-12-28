all: clean example

example: om_misc.ml om_connection.ml om_reactor.ml om_dumb_http_client.ml example.ml
	ocamlopt unix.cmxa -o $@ $+

clean:
	rm -f example *.cmi *.cmx *.o *.out *.cmo