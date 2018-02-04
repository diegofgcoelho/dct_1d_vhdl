# dct_1d_vhdl

This project is a hardware description in VHDL of a 1D DCT core using algebraic integer based representation.

The files are organized in three different folders, design source, simulation sources (test benches), and constraint sources (master file for a Xilinx FPGA).

The project was synthetized for a Xilinx FPGA, achieving maximum operating frequency around 178 MHz.

Use the mylib.vhd file as library. It contains ROM memories used for testing the architecture with the input and expected output (verified in matlab). The signal serr in the top architecture in the simulation indicate if the actual DCT output is equivalent to expected values in the memory. If it is 0, they match, otherwise, it is 1.