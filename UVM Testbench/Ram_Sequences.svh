class Ram_Sequence extends uvm_sequence#(Ram_Sequence_item);
    `uvm_object_utils(Ram_Sequence)
    Ram_Sequence_item item;
    int num_transactions;
    virtual task do_item();
        item=Ram_Sequence_item::type_id::create("item");
        start_item(item);
        assert (item.randomize())
        else 
            $error("randomiztion failed");
        finish_item(item);
    endtask
    
    virtual task body();
        repeat(num_transactions)
            do_item();
    endtask
    function new (string name="Ram_Sequence");
        super.new(name);
    endfunction
endclass:Ram_Sequence
class Reset_Sequence extends Ram_Sequence;
    `uvm_object_utils(Reset_Sequence)
    Ram_Sequence_item item1;
    task do_item();
        item1=Ram_Sequence_item::type_id::create("item1");
        start_item(item1);
        assert (item1.randomize()with{Resetn==0;Write_en ==0;})
        else 
            $error("randomiztion failed");
        finish_item(item1);
    endtask
    
    virtual task body();
        repeat(num_transactions)
            do_item();
    endtask
    function new (string name="Reset_Sequence");
        super.new(name);
    endfunction
endclass:Reset_Sequence
class Write_Sequence extends Ram_Sequence;
    `uvm_object_utils(Write_Sequence)
    Ram_Sequence_item item;
    task do_item();
        item=Ram_Sequence_item::type_id::create("item");
        start_item(item);
        assert (item.randomize()with{Resetn==1;Write_en ==0;
        Enable==1;})
        else 
            $error("randomiztion failed");
        finish_item(item);
    endtask
    virtual task body();
        repeat(num_transactions)
            do_item();
    endtask
    function new (string name="Write_Sequence");
        super.new(name);
    endfunction
endclass:Write_Sequence
class Read_Sequence extends Ram_Sequence;
    `uvm_object_utils(Read_Sequence)
    Ram_Sequence_item item;
    task do_item();
        item=Ram_Sequence_item::type_id::create("item");
        start_item(item);
        assert (item.randomize()with{Resetn==1;Write_en ==1;
        Enable==1;})
        else 
            $error("randomiztion failed");
        finish_item(item);
    endtask
    virtual task body();
        repeat(num_transactions)
            do_item();
    endtask
    function new (string name="Read_Sequence");
        super.new(name);
    endfunction
endclass:Read_Sequence