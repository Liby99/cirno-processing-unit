vlog -reportprogress 300 -work work ../../../src/cirno/test_bench/prog123_tb.sv
cp -r ../../../src/cirno/programs .
vsim -i -l msim_transcript work.prog123_tb
