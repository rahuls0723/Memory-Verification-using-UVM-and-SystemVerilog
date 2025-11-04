`timescale 1ns/1ps
`include "ram_ifc.sv"
`include "single_port_ram.sv"
import pack_ram:: *;
module Top_tb;
ram_ifc ifc();
single_port_ram dut(ifc.Clock,ifc.Resetn,ifc.Enable,ifc.Write_en,ifc.Address, ifc.Data_in,ifc.Data_out,ifc.Valid_out);
Environment env;
  initial begin
	ifc.Clock<=0;
	forever #5 ifc.Clock<=~ifc.Clock;
  end
  initial begin
      env=new(ifc);
      env.seq.num_trans=96;
	    env.run();
    
	end
  initial begin
    $dumpfile("Top_tb.vcd");
    $dumpvars;
  end
endmodule
/*
vlog Top_tb.sv +cover
vsim -batch Top_tb -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
*/