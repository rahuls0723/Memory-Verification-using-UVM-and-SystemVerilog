interface ram_ifc();
    logic Clock;
    logic Resetn;
    logic Enable;
    logic Write_en;
    logic [3:0] Address;
    logic [31:0] Data_in;
    logic [31:0] Data_out;
    logic Valid_out;
endinterface