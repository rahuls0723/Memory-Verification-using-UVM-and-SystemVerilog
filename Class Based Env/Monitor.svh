class Monitor;
    Transaction tr;
    mailbox#(Transaction) mb_scb;
    mailbox#(Transaction) mb_cov;
    virtual ram_ifc vif;

    function new(mailbox#(Transaction) mb_scb,mailbox#(Transaction) mb_cov,virtual ram_ifc vif);
        this.mb_scb=mb_scb;
        this.mb_cov=mb_cov;
        this.vif=vif;
        tr=new();
    endfunction:new
    
    task run();
    forever begin
        repeat (2)
            @(posedge vif.Clock);
        @(negedge vif.Clock);
        tr.Resetn<=vif.Resetn;
        tr.Enable<=vif.Enable;
        tr.Write_en<=vif.Write_en;
        tr.Address<=vif.Address ;
        tr.Data_in<=vif.Data_in;
        tr.Data_out<=vif.Data_out;
        tr.Valid_out<=vif.Valid_out;
        #1step;
        mb_scb.put(tr);
        mb_cov.put(tr);
        tr.print_tr("Monitor");
        
    end
    endtask:run
endclass:Monitor