# ice40 Hardware test

This is a simple project depending on <http://www.clifford.at/icestorm/> 
The idea is to have accessible IO's toggle like 'christmas lights' so that a board can be verified to have working IO pins without bridges. 

Ideally, this testing should be done with one logic probes, which may be as simplke as an LED in series with a resistor.

The idea is to not only verify that the FPGA can toggle each pin, but also verify that adjacent pins are not bridged together. (especially critical with fine TQFP's but also possible with BGA's).
For this purpose, two alternating signals will be used on TQFP's, and a one-hot pattern on BGA's.

There will be a subdirectory for each supported board, with a Makefile therein to run the test.

This may also test the icestorm tools themselves against regressions.


