class Transaction ;
    rand logic Resetn;
    rand logic Enable;
    randc logic Write_en;
    randc logic [3:0] Address;
    rand logic [31:0] Data_in;
    logic [31:0] Data_out;
    logic Valid_out;
    constraint reset_c{
        if(!Resetn){
            Enable ==0;
            Write_en == 0;
            Address == 4'h0;
            Data_in == 0;
        }
        Resetn dist {0:=10 ,1:=90};
    }
    constraint data_c{
        Data_in dist {[0:200]:/30 ,[201:400]:/30,[401:600]:/30,[601:800]:/30,[801:1000]:/30,[1000:$]:/20};
    }
    constraint Write_en_c{
        Write_en dist {0:=50,1:=50};
    }
    constraint en_c{
        Enable dist {0:=10,1:=90};
    }
    task print_tr(input string class_name);
        $display("%0s :%0t inputs:Resetn=%0d Enable=%0d Write_en=%0d Address=%0d Data_in=%0d",class_name,$time,Resetn,Enable,Write_en,Address,Data_in);
        if(class_name !="Driver" && class_name !="Sequencer")
            $display("%0s :%0t outputs:Data_out=%0d Valid_out=%0d",class_name,$time,Data_out,Valid_out);

    endtask
    
endclass:Transaction