# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

#!/usr/bin/env bash
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
    -I"${CODE_HOME}/21-days-of-rtl/rtl" \
    --top-module "tb_${SEL_TOP_LEVEL}" \
    -f "${CODE_HOME}/21-days-of-rtl/scripts/sim/filelist.f" \
       "${CODE_HOME}/21-days-of-rtl/tb/tb_${SEL_TOP_LEVEL}.sv" \
    -Mdir "${CODE_HOME}/21-days-of-rtl/sim/${SEL_OUT_DIR}/build/obj_dir" \
    -o "${CODE_HOME}/21-days-of-rtl/sim/${SEL_OUT_DIR}/build/simv" \
    | tee "${CODE_HOME}/21-days-of-rtl/sim/${SEL_OUT_DIR}/output/compile.log"

exec "${CODE_HOME}/21-days-of-rtl/sim/${SEL_OUT_DIR}/build/simv" "$@" \
    | tee "${CODE_HOME}/21-days-of-rtl/sim/${SEL_OUT_DIR}/output/run.log"
