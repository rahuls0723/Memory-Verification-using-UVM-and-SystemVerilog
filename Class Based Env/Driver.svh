class Driver;

    Transaction tr;
    mailbox#(Transaction) mb_drv;
    virtual ram_ifc vif;

    function new(mailbox#(Transaction) mb_drv,virtual ram_ifc vif);
        this.mb_drv=mb_drv;
        this.vif=vif;
    endfunction:new
    task run();
    forever begin

        mb_drv.get(tr);

        @(posedge vif.Clock);
        tr.print_tr("Driver");
        vif.Resetn <= tr.Resetn;
        vif.Enable <= tr.Enable;
        vif.Write_en <=tr.Write_en;
        vif.Address <= tr.Address;
        vif.Data_in <= tr.Data_in;
        @(posedge vif.Clock);
        
        
    end
    endtask:run
endclass:Driver


