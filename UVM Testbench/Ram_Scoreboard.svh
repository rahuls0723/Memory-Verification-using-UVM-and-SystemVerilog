class Ram_Scoreboard extends uvm_scoreboard;
    `uvm_component_utils(Ram_Scoreboard)
    Ram_Sequence_item item;
    uvm_analysis_imp#(Ram_Sequence_item,Ram_Scoreboard) scb_imp;
    logic [31:0] exp_data;
    logic exp_valid;
    reg [31:0] mem[0:15];
    int  correct_data,incorrect_data;
    int correct_valid,incorrect_valid;
    function new (string name="Ram_Scoreboard", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Ram_Scoreboard : build_phase");
        scb_imp=new("scb_imp",this);
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Scoreboard :connect_phase");
    endfunction
    function void write(input Ram_Sequence_item item);
        if(!item.Resetn)begin
            foreach(mem[i])
                mem[i]=0;
            exp_data = 32'h0;
            exp_valid= 0;
        end
        else if (item.Enable && item.Write_en)begin
            mem[item.Address]=item.Data_in;
            exp_valid= 0;
            if(item.Valid_out == exp_valid)begin
            $display("valid_out is correct");
            correct_valid++;
            end
            else begin
            $display("valid_out is incorrect");
            incorrect_valid++;
            end
        end
        else if (item.Enable && !item.Write_en)begin
            exp_data=mem[item.Address];
            exp_valid= 1;
            if(item.Data_out == exp_data)begin
                $display("data_out is correct");
                correct_data++;
            end
            else begin
                $display("data_out is incorrect");
                incorrect_data++;
            end
            if(item.Valid_out == exp_valid)begin
            $display("valid_out is correct");
            correct_valid++;
            end
            else begin
            $display("valid_out is incorrect");
            incorrect_valid++;
            end
        end
        $display("%0t %0p",$time,mem);
        $display("%0t exp_data=%0d ep exp_valid=%0d",$time,exp_data,exp_valid);
        $display("no of correct valid_out item=%0d",correct_valid);
        $display("no of correct data_out item=%0d",correct_data);
        $display("no of wrong valid_out item=%0d",incorrect_valid);
        $display("no of wrong data_out item=%0d",incorrect_data);
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Scoreboard :run_phase");
    endtask
endclass:Ram_Scoreboard