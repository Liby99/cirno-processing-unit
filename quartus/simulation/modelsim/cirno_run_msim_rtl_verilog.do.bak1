transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/register.sv}
vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/memory.sv}
vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/decoder.sv}
vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/alu.sv}
vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/fetch_unit.sv}
vlog -sv -work work +incdir+/home/tedi2/playground/cirno-processing-unit/src/cirno {/home/tedi2/playground/cirno-processing-unit/src/cirno/top_level.sv}

