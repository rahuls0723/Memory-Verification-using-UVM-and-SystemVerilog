class Sequencer;
    Transaction tr;
    mailbox#(Transaction) mb_drv;
    int finish_tr;
    int num_trans;
    function new(mailbox#(Transaction) mb_drv);
        this.mb_drv=mb_drv;
        tr=new();
    endfunction:new
    task run();
        repeat(num_trans)begin
        assert(tr.randomize()with{Resetn==0;}) else $error("Randomization failed");
        tr.print_tr("Sequencer");
        mb_drv.put(tr);
        end
        repeat(num_trans)begin
        assert(tr.randomize()with{Resetn==1;Write_en ==0;
        Enable==1;}) else $error("Randomization failed");
        tr.print_tr("Sequencer");
        mb_drv.put(tr);
        end
    repeat(num_trans)begin
        assert(tr.randomize()with{ Resetn==1 ; Write_en ==1;
        Enable==1;}) else $error("Randomization failed");
        tr.print_tr("Sequencer");
        mb_drv.put(tr);
    end
    repeat(num_trans)begin
        assert(tr.randomize()with{Resetn==1 ; Write_en ==0;
        Enable==1;}) else $error("Randomization failed");
        tr.print_tr("Sequencer");
        mb_drv.put(tr);
    end
    finish_tr=10;
    endtask:run

endclass:Sequencer