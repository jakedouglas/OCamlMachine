all: clean example server

server: om_eventable.ml om_misc.ml om_connection.ml om_server.ml om_reactor.ml server.ml
	ocamlopt unix.cmxa -o $@ $+

example: om_eventable.ml om_misc.ml om_connection.ml om_server.ml om_reactor.ml example.ml
	ocamlopt unix.cmxa -o $@ $+

clean:
	rm -f example server *.cmi *.cmx *.o *.out *.cmo