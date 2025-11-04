class Ram_Subscriber extends uvm_subscriber#(Ram_Sequence_item);
    `uvm_component_utils(Ram_Subscriber)
    Ram_Sequence_item item;
    uvm_analysis_imp#(Ram_Sequence_item,Ram_Subscriber) sub_imp;
    covergroup cg;
        reset: coverpoint item.Resetn{
            bins low={0};
            bins high={1};
            bins lowtohigh = (0=>1);
        }
        enable: coverpoint item.Enable{
            bins low={0};
            bins high={1};
            bins lowtohigh= (0=>1);
            
        }
        Write_en: coverpoint item.Write_en{
            bins read={0};
            bins write={1};
        }
        Data_in: coverpoint item.Data_in{
            bins data0={[0:200]};
            bins data1={[201:400]};
            bins data2={[401:600]};
            bins data3={[601:800]};
            bins data4={[801:1000]};
            bins data5={[1000:$]};
        }
        Address: coverpoint item.Address{
            bins address[]={[0:15]};
        }
        Data_out: coverpoint item.Data_out{
          bins dataout0={[0:200]};
          bins dataout1={[201:400]};
          bins dataout2={[401:600]};
          bins dataout3={[601:800]};
          bins dataout4={[801:1000]};
          bins dataout5={[1000:$]};
        }
        Valid_out: coverpoint item.Valid_out;
        cross1 :cross Address,Data_in;
           
    endgroup
    function new (string name="Ram_Subscriber", uvm_component parent =null);
        super.new(name,parent);
        cg=new();
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Ram_Subscriber : build_phase");
        sub_imp=new("sub_imp",this);
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Subscriber :connect_phase");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Subscriber :run_phase");
    endtask
    virtual function void write(Ram_Sequence_item t);
        item=t;
        cg.sample();
    endfunction
    function void report_phase (uvm_phase phase);
    `uvm_info("Ram_Subscriber", $sformatf("coverage =%0d", cg.get_coverage), UVM_NONE);
    endfunction
endclass:Ram_Subscriber