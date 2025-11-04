class Ram_Sequencer extends uvm_sequencer#(Ram_Sequence_item);
    `uvm_component_utils(Ram_Sequencer)
    function new (string name="Ram_Sequencer", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("sequencer : build_phase");
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("sequencer :connect_phase");
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        $display("sequencer :run_phase");
    endtask
endclass:Ram_Sequencer