#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

set -euo pipefail

verilator \
    -sv \
    --binary \
    --timing \
    --trace \
    --trace-max-array 0 \
    --trace-max-width 0 \
    -Wall \
    -Wno-fatal \
    -I"${CODE_HOME}/rtl-lab/rtl" \
    --top-module "tb_${SEL_TOP_LEVEL}" \
    -f "${CODE_HOME}/rtl-lab/scripts/sim/filelist.f" \
    -Mdir "${CODE_HOME}/rtl-lab/sim/${SEL_OUT_DIR}/build/obj_dir" \
    -o "${CODE_HOME}/rtl-lab/sim/${SEL_OUT_DIR}/build/simv" \
    | tee "${CODE_HOME}/rtl-lab/sim/${SEL_OUT_DIR}/output/compile.log"

exec "${CODE_HOME}/rtl-lab/sim/${SEL_OUT_DIR}/build/simv" "$@" \
    | tee "${CODE_HOME}/rtl-lab/sim/${SEL_OUT_DIR}/output/run.log"
