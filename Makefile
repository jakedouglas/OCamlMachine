all: clean example

example: om_eventable.ml om_misc.ml om_connection.ml om_reactor.ml example.ml
	ocamlopt unix.cmxa -o $@ $+

clean:
	rm -f example *.cmi *.cmx *.o *.out *.cmo