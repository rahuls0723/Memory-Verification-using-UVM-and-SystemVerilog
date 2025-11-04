class Ram_Test extends uvm_test;
    `uvm_component_utils(Ram_Test)
    Ram_Env env;
    Ram_Sequence base_seq;
    Reset_Sequence rst_seq;
    Read_Sequence read_seq;
    Write_Sequence write_seq;
    virtual Ram_IF vif;
    function new (string name="Ram_Test", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual Ram_IF)::get(this,"","vif",vif))
            `uvm_error("Ram_Test","Can't get vif from the config db")
        uvm_config_db#(virtual Ram_IF)::set(this,"env","vif",vif);
        env=Ram_Env::type_id::create("env",this);
        base_seq=Ram_Sequence::type_id::create("base_seq");
        base_seq.num_transactions=96;
        rst_seq=Reset_Sequence::type_id::create("rst_seq");
        rst_seq.num_transactions=96;
        read_seq=Read_Sequence::type_id::create("read_seq");
        read_seq.num_transactions=96;
        write_seq=Write_Sequence::type_id::create("write_seq");
        write_seq.num_transactions=96;
        $display("Ram_Test : build_phase");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Test :connect_phase");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("Ram_Test :run_phase");
        phase.raise_objection(this);
        rst_seq.start(env.agent.sqr);
        #150;
        read_seq.start(env.agent.sqr);
        #150;
        write_seq.start(env.agent.sqr);
        #150;
        read_seq.start(env.agent.sqr);
        #150;
        base_seq.start(env.agent.sqr);
        #150;
        phase.drop_objection(this);
    endtask
endclass:Ram_Test