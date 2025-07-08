VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage


# Generate C++ in executable form
VERILATOR_FLAGS += -cc --exe
# build the verilator model
VERILATOR_FLAGS += --binary
# Make waveforms
VERILATOR_FLAGS += --trace
# Check SystemVerilog assertions
VERILATOR_FLAGS += --assert
# Generate coverage analysis
VERILATOR_FLAGS += --coverage-line
# ignore some warnings
VERILATOR_FLAGS += -Wno-SIDEEFFECT -Wno-CASEOVERLAP -Wno-LATCH -Wno-UNOPTFLAT -Wno-MULTIDRIVEN -Wno-WIDTHEXPAND -Wno-ASCRANGE -Wno-COMBDLY -Wno-IMPLICIT -Wno-CASEINCOMPLETE -Wno-PINMISSING -Wno-WIDTHTRUNC -Wno-TIMESCALEMOD -Wno-INITIALDLY -Wno-EOFNEWLINE -Wno-DECLFILENAME -Wno-CASEINCOMPLETE 
# multi-threaded build
VERILATOR_FLAGS += -j 4
# enable timing 
VERILATOR_FLAGS += --timing
# bug fix
VERILATOR_FLAGS += -fno-table
# set top module
VERILATOR_FLAGS += --top tb


# Input files for Verilator
VERILATOR_INPUT = *v


######################################################################
default: compile

compile:
	@echo
	@echo "-- COMPILE ----------------"
	$(VERILATOR) $(VERILATOR_FLAGS) $(VERILATOR_INPUT)


run:
	@echo
	@echo "-- RUN ---------------------"
	@rm -rf logs
	@mkdir -p logs
	obj_dir/Vtb
	@mv coverage.dat wave.vcd logs/

analyze:
	@echo
	@echo "-- COVERAGE ----------------"
	$(VERILATOR_COVERAGE) logs/coverage.dat --annotate-all --annotate ./logs

all:
	@echo
	@echo "-- ALL ---------------------"
	$(MAKE) compile
	$(MAKE) run
	$(MAKE) analyze

maintainer-copy::
clean::
	-rm -rf obj_dir logs
