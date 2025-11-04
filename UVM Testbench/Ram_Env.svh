class Ram_Env extends uvm_env;
    `uvm_component_utils(Ram_Env)
    Ram_Agent agent;
    Ram_Subscriber cov;
    Ram_Scoreboard scb;
    virtual Ram_IF vif;
   function new (string name="Ram_Env", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual Ram_IF)::get(this,"","vif",vif))
            `uvm_error("Ram_Env","Can't get vif from the config db")
        uvm_config_db#(virtual Ram_IF)::set(this,"agent","vif",vif);
        agent=Ram_Agent::type_id::create("agent",this);
        scb=Ram_Scoreboard::type_id::create("scb",this);
        cov=Ram_Subscriber::type_id::create("cov",this);
        $display("Ram_Env : build_phase");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Env :connect_phase");
        agent.agent_ap.connect(scb.scb_imp);
        agent.agent_ap.connect(cov.sub_imp);
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Env :run_phase");
    endtask
endclass:Ram_Env