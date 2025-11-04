`timescale 1ns/1ps
`include "Ram_IF.sv"
`include "single_port_ram.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"
import pack1::*;
module top;
    Ram_IF ifc();
    single_port_ram dut(ifc.Clock,ifc.Resetn,ifc.Enable,ifc.Write_en,ifc.Address, ifc.Data_in,ifc.Data_out,ifc.Valid_out);
  initial begin
	ifc.Clock<=0;
	forever #5 ifc.Clock<=~ifc.Clock;
  end
    initial begin
        uvm_config_db#(virtual Ram_IF)::set(null,"uvm_test_top","vif",ifc);
        run_test("Ram_Test");
    end

endmodule
/*
vlog pack1.sv top.sv +cover
vsim -batch top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
*/