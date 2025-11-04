class Ram_Monitor extends uvm_monitor;
    `uvm_component_utils(Ram_Monitor)
    uvm_analysis_port#(Ram_Sequence_item) mon_ap;
    Ram_Sequence_item item;
    virtual Ram_IF vif;
    function new (string name="Ram_Monitor", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Ram_Monitor : build_phase");
        if(!uvm_config_db#(virtual Ram_IF)::get(this,"","vif",vif))
            `uvm_error("Ram_Monitor","Can't get vif from the config db")
        item=Ram_Sequence_item::type_id::create("item");
        mon_ap=new("mon_ap",this);

    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Monitor :connect_phase");
    endfunction
    task run_phase(uvm_phase phase);
        forever begin
        $display("Ram_Monitor :run_phase");
        repeat (2)
            @(posedge vif.Clock);
        @(negedge vif.Clock);
        item.Resetn<=vif.Resetn;
        item.Enable<=vif.Enable;
        item.Write_en<=vif.Write_en;
        item.Address<=vif.Address ;
        item.Data_in<=vif.Data_in;
        item.Data_out<=vif.Data_out;
        item.Valid_out<=vif.Valid_out;
        #1step;
        mon_ap.write(item);
        item.print_tr("Monitor");
        end
    endtask
endclass:Ram_Monitor