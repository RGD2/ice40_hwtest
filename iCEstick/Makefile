

upload: top.bin
	sudo iceprog top.bin 

top.bin: top.asc
	icepack top.txt top.bin 

top.asc: top.blif
	arachne-pnr -d 1k -p board.pcf -o top.asc top.blif 

top.blif: top.v
	yosys -p "read_verilog top.v; synth_ice40 -blif top.blif"

clean:
	rm -f top.bin top.asc top.blif

PHONY: clean upload
