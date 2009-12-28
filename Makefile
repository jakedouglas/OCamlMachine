all: clean example

example: em_misc.ml em_connection.ml em_poller.ml em_reactor.ml em_dumb_http_client.ml example.ml
	ocamlopt unix.cmxa -o $@ $+

clean:
	rm -f example *.cmi *.cmx *.o *.out *.cmo