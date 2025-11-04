class Ram_Driver extends uvm_driver#(Ram_Sequence_item);
    `uvm_component_utils(Ram_Driver)
    Ram_Sequence_item item;
    virtual Ram_IF vif;

    function new (string name="Ram_Driver", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("Ram_Driver : build_phase");
        if(!uvm_config_db#(virtual Ram_IF)::get(this,"","vif",vif))
            `uvm_error("Ram_Driver","Can't get vif from the config db")
        item=Ram_Sequence_item::type_id::create("item");

    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        $display("Ram_Driver :connect_phase");
    endfunction
    task drive_item(input Ram_Sequence_item item);
        @(posedge vif.Clock);
        vif.Resetn <= item.Resetn;
        vif.Enable <= item.Enable;
        vif.Write_en <=item.Write_en;
        vif.Address <= item.Address;
        vif.Data_in <= item.Data_in;
        @(posedge vif.Clock);
    endtask:drive_item
    task run_phase(uvm_phase phase);
        forever begin
        $display("Ram_Driver :run_phase");
        seq_item_port.get_next_item(item);
        drive_item(item);
        seq_item_port.item_done();
        end
    endtask
endclass:Ram_Driver