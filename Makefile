# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

TOP_LEVEL ?= tmp
OUT_DIR   ?= tmp

export SEL_TOP_LEVEL := $(TOP_LEVEL)
export SEL_OUT_DIR   := $(OUT_DIR)

.PHONY: init

init:
	mkdir -p $(CODE_HOME)/rtl-lab/sim

sim: clean-sim
	cd $(CODE_HOME)/rtl-lab/scripts/sim && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR) && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/build && \
	mkdir -p $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/output && \
	./run.sh && \
	if [ -f $(CODE_HOME)/rtl-lab/scripts/sim/activity.vcd ]; then \
	mv $(CODE_HOME)/rtl-lab/scripts/sim/activity.vcd $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)/output; \
	fi

clean-all:
	rm -rf $(CODE_HOME)/rtl-lab/sim

clean-sim:
	rm -rf $(CODE_HOME)/rtl-lab/sim/$(OUT_DIR)
