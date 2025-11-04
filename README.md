# Memory-Verification-using-UVM-and-SystemVerilog
This project focuses on The Verification of a single port ram Using Class Based Environment and UVM. 

<img width="817" height="316" alt="sram" src="https://github.com/user-attachments/assets/2e4c5ff9-1856-4593-9199-7faef4bb5b35" />

 
<img width="919" height="429" alt="2" src="https://github.com/user-attachments/assets/75c0ecbe-8bcd-4681-835b-e2496f2548d3" />


## UVM Architecture

<img width="4355" height="3171" alt="3" src="https://github.com/user-attachments/assets/2c112ae6-9ab4-4360-aa5d-b33f68df8e75" />


## Class Based Env

<img width="3763" height="2565" alt="4" src="https://github.com/user-attachments/assets/2acb9ab2-f7d4-4ea2-badd-b61fb9a5df53" />


## Compilation and Simulation Steps

To compile the design and testbench, use the following command:

```bash
vlog pack1.sv top.sv +cover
```
To simulate and run test with coverage analysis, use the following command:

```bash
vsim -batch top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
```
