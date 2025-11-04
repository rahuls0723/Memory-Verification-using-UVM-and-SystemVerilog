class Environment;
virtual ram_ifc vif;
Sequencer seq;
Driver drv;
Monitor mon;
Scoreboard scb;
Subscriber cov;

  mailbox#(Transaction) mb_drv;
  mailbox#(Transaction) mb_cov;
  mailbox#(Transaction) mb_scb;
  
  
  function new(virtual ram_ifc vif);
    this.vif=vif;
    mb_drv=new(1);
    mb_scb=new(1);
    mb_cov=new(1);
    seq=new(mb_drv);
    drv=new(mb_drv,vif);
    mon=new(mb_scb,mb_cov,vif);
    scb=new(mb_scb);
    cov=new(mb_cov);

  endfunction:new
  task run;
    fork 
      seq.run();
      drv.run();
      mon.run();
      scb.run();
      cov.run();
    join_any
    wait(seq.finish_tr==10);
    $display(cov.cg.get_coverage);
    $stop;
  endtask
endclass:Environment