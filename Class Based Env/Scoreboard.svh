class Scoreboard;
    Transaction tr;
    mailbox#(Transaction) mb_scb;
    logic [31:0] exp_data;
    logic exp_valid;
    reg [31:0] mem[0:15];
    int  correct_data,incorrect_data;
    int correct_valid,incorrect_valid;
    function new(mailbox#(Transaction) mb_scb);
        this.mb_scb=mb_scb;
    endfunction:new
    task run();
    forever begin
        mb_scb.get(tr);
        if(!tr.Resetn)begin
            foreach(mem[i])
                mem[i]=0;
            exp_data = 32'h0;
            exp_valid= 0;
        end
        else if (tr.Enable && tr.Write_en)begin
            mem[tr.Address]=tr.Data_in;
            exp_valid= 0;
            if(tr.Valid_out == exp_valid)begin
            $display("valid_out is correct");
            correct_valid++;
            end
            else begin
            $display("valid_out is incorrect");
            incorrect_valid++;
            end
        end
        else if (tr.Enable && !tr.Write_en)begin
            exp_data=mem[tr.Address];
            exp_valid= 1;
            if(tr.Data_out == exp_data)begin
                $display("data_out is correct");
                correct_data++;
            end
            else begin
                $display("data_out is incorrect");
                incorrect_data++;
            end
            if(tr.Valid_out == exp_valid)begin
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
        $display("the number of correct valid_out tr=%0d",correct_valid);
        $display("the number of correct data_out tr=%0d",correct_data);
        $display("the number of wrong valid_out tr=%0d",incorrect_valid);
        $display("the number of wrong data_out tr=%0d",incorrect_data);
        end
    endtask:run

endclass:Scoreboard