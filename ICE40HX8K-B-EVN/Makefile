PROJ = top
PIN_DEF = board.pcf
DEVICE = hx8k
PACKAGE = ct256
VERILOGS = top.v spimaster.v

all: $(PROJ).rpt $(PROJ).bin

$(PROJ).blif: $(VERILOGS)
	yosys -p 'synth_ice40 -top top -abc2 -blif $@' $(VERILOGS)
	yosys -V > .version-yosys.txt


%.asc: $(PIN_DEF) %.blif
	arachne-pnr -d $(subst hx,,$(subst lp,,$(DEVICE))) -P $(PACKAGE) -o $@ -p $^
	arachne-pnr -v > .version-arachne-pnr.txt


%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin .version-*.txt 

.SECONDARY:
.PHONY: all prog clean
