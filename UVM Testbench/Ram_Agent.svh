class Ram_Agent extends uvm_agent;
    `uvm_component_utils(Ram_Agent)
    Ram_Sequencer sqr;
    Ram_Driver drv;
    Ram_Monitor mon;
    uvm_analysis_port#(Ram_Sequence_item) agent_ap;
    virtual Ram_IF vif;
    function new (string name="Ram_Agent", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual Ram_IF)::get(this,"","vif",vif))
            `uvm_error("Ram_Agent","Can't get vif from the config db")
        uvm_config_db#(virtual Ram_IF)::set(this,"drv","vif",vif);
        uvm_config_db#(virtual Ram_IF)::set(this,"mon","vif",vif);
        sqr=Ram_Sequencer::type_id::create("sqr",this);
        drv=Ram_Driver::type_id::create("drv",this);
        mon=Ram_Monitor::type_id::create("mon",this);
        agent_ap=new("agent_ap",this);
        $display("Ram_Agent : build_phase");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Agent :connect_phase");
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(this.agent_ap);
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Agent :run_phase");
    endtask
endclass:Ram_Agent