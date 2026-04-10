# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Environment Setup

Source `sourceme.sh` before running any commands. It sets `CODE_HOME`, `VERILATOR_HOME`, and other tool paths:

```bash
source sourceme.sh
```

## Simulation

Run a simulation for a specific module (Verilator-based):

```bash
make sim TOP_LEVEL=<module_name> OUT_DIR=<out_dir>
```

- `TOP_LEVEL` is the RTL module name without the `tb_` prefix (e.g., `booth_r4`, `cpr_tree`)
- `OUT_DIR` is the output directory name under `sim/`
- Outputs go to `sim/<OUT_DIR>/output/` (compile.log, run.log, activity.vcd)
- Build artifacts go to `sim/<OUT_DIR>/build/`

Example — simulate the Booth Radix-4 multiplier:

```bash
make sim TOP_LEVEL=booth_r4 OUT_DIR=booth_r4
```

Clean a specific simulation output: `make clean-sim OUT_DIR=<out_dir>`  
Clean all simulation output: `make clean-all`

## Synthesis

Run synthesis for a specific module (Yosys-based, targeting ASAP7):

```bash
make syn TOP_LEVEL=<module_name> OUT_DIR=<out_dir>
```

- `TOP_LEVEL` is the RTL module name (e.g., `alu`, `booth_r4`)
- `OUT_DIR` is the output directory name under `imp/`
- `PARAMS` (optional) passes top-level generics as `KEY=VALUE` pairs (space-separated)
- Outputs go to `imp/<OUT_DIR>/output/` (yosys.log, netlist.v)
- Reports go to `imp/<OUT_DIR>/report/` (area.rpt)

Example — synthesize the ALU:

```bash
make syn TOP_LEVEL=alu OUT_DIR=alu
```

The synthesis flow (`scripts/syn/run.tcl`) reads all `rtl/*.sv` files via the Yosys Slang plugin, maps to ASAP7 RVT standard cells, and writes a flattened Verilog netlist.

Clean a specific implementation output: `make clean-imp OUT_DIR=<out_dir>`  
Clean all output (sim + imp): `make clean-all`

## Structure

This repo contains multiple independent RTL architectures, each built and tested in isolation. All RTL is written in SystemVerilog. Each module in `rtl/` has a corresponding testbench in `tb/tb_<module>.sv`.

The simulation flow (`scripts/sim/run.sh`) compiles only the testbench via `filelist.f`; Verilator resolves RTL dependencies from the `rtl/` include path (`-I rtl`).

The synthesis flow (`scripts/syn/run.tcl`) reads all `rtl/*.sv` files directly and selects the top module via `--top`.
