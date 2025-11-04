# Memory-Verification-using-UVM-and-SystemVerilog
This project focuses on The Verification of a single port ram Using Class Based Environment and UVM. 

 ![image](https://github.com/OmniaMohamed12/Memory-Verification-using-UVM-and-SystemVerilog/assets/110364388/9b1a5413-118e-4978-92cc-35d3aea4f398)
 
![image](https://github.com/OmniaMohamed12/Memory-Verification-using-UVM-and-SystemVerilog/assets/110364388/5cc65d3c-a69a-431b-9480-e7ba23fe2edf)

## UVM Architecture

![ram uvm env - Page 1 (2)](https://github.com/OmniaMohamed12/Memory-Verification-using-UVM-and-SystemVerilog/assets/110364388/36022ee0-4c20-4a52-96ef-6084bae4fa8d)

## Class Based Env

![memory class based env](https://github.com/OmniaMohamed12/Memory-Verification-using-UVM-and-SystemVerilog/assets/110364388/31e663db-3744-4bd8-b9bd-325c94029327)

## Compilation and Simulation Steps

To compile the design and testbench, use the following command:

```bash
vlog pack1.sv top.sv +cover
```
To simulate and run test with coverage analysis, use the following command:

```bash
vsim -batch top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
```
