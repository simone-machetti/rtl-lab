#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

set -uo pipefail

# shellcheck disable=SC1091
source "$(dirname "$0")/sourceme.sh"

PASS=0
FAIL=0
RESULTS=()

run() {
    local desc="$1"
    shift
    if make "$@" > /dev/null 2>&1; then
        RESULTS+=("  PASS  $desc")
        ((PASS++))
    else
        RESULTS+=("  FAIL  $desc")
        ((FAIL++))
    fi
}

# -----------------------------------------------------------------------------
# alu
# -----------------------------------------------------------------------------
run "sim  alu"       sim  TOP_LEVEL=alu       OUT_DIR=reg_alu
run "syn  alu"       syn  TOP_LEVEL=alu       OUT_DIR=reg_alu

# -----------------------------------------------------------------------------
# booth_r4
# -----------------------------------------------------------------------------
run "sim  booth_r4"  sim  TOP_LEVEL=booth_r4  OUT_DIR=reg_booth_r4
run "syn  booth_r4"  syn  TOP_LEVEL=booth_r4  OUT_DIR=reg_booth_r4

# -----------------------------------------------------------------------------
# booth_r8
# -----------------------------------------------------------------------------
run "sim  booth_r8"  sim  TOP_LEVEL=booth_r8  OUT_DIR=reg_booth_r8
run "syn  booth_r8"  syn  TOP_LEVEL=booth_r8  OUT_DIR=reg_booth_r8

# -----------------------------------------------------------------------------
# cpr_n_2
# -----------------------------------------------------------------------------
run "sim  cpr_n_2"   sim  TOP_LEVEL=cpr_n_2   OUT_DIR=reg_cpr_n_2
run "syn  cpr_n_2"   syn  TOP_LEVEL=cpr_n_2   OUT_DIR=reg_cpr_n_2

# -----------------------------------------------------------------------------
# d_ff
# -----------------------------------------------------------------------------
run "sim  d_ff"      sim  TOP_LEVEL=d_ff      OUT_DIR=reg_d_ff
run "syn  d_ff"      syn  TOP_LEVEL=d_ff      OUT_DIR=reg_d_ff

# -----------------------------------------------------------------------------
# edge_det
# -----------------------------------------------------------------------------
run "sim  edge_det"  sim  TOP_LEVEL=edge_det  OUT_DIR=reg_edge_det
run "syn  edge_det"  syn  TOP_LEVEL=edge_det  OUT_DIR=reg_edge_det

# -----------------------------------------------------------------------------
# mux
# -----------------------------------------------------------------------------
run "sim  mux"       sim  TOP_LEVEL=mux       OUT_DIR=reg_mux
run "syn  mux"       syn  TOP_LEVEL=mux       OUT_DIR=reg_mux

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------
echo ""
echo "Regression results:"
echo "-------------------"
for r in "${RESULTS[@]}"; do
    echo "$r"
done
echo "-------------------"
echo "PASS: $PASS  FAIL: $FAIL  TOTAL: $((PASS + FAIL))"
echo ""

[ $FAIL -eq 0 ]
