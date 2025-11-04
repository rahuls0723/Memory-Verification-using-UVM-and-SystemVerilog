class Subscriber;
    Transaction tr;
    mailbox#(Transaction) mb_cov;
    covergroup cg;
        reset: coverpoint tr.Resetn{
            bins low={0};
            bins high={1};
            bins trans = (0=>1);
        }
        enable: coverpoint tr.Enable{
            bins low={0};
            bins high={1};
            bins trans= (0=>1);
            
        }
        Write_en: coverpoint tr.Write_en{
            bins read={0};
            bins write={1};
        }
        Data_in: coverpoint tr.Data_in{
            bins data0={[0:200]};
            bins data1={[201:400]};
            bins data2={[401:600]};
            bins data3={[601:800]};
            bins data4={[801:1000]};
            bins data5={[1000:$]};
        }
        Address: coverpoint tr.Address{
            bins address[]={[0:15]};
        }
        Data_out: coverpoint tr.Data_out{
          bins dataout0={[0:200]};
          bins dataout1={[201:400]};
          bins dataout2={[401:600]};
          bins dataout3={[601:800]};
          bins dataout4={[801:1000]};
          bins dataout5={[1000:$]};
        }
        Valid_out: coverpoint tr.Valid_out;
        cross1 :cross Address,Data_in;
           
    endgroup
    function new(mailbox#(Transaction) mb_cov);
        this.mb_cov=mb_cov;
        cg=new();
    endfunction:new
    task run();
    forever begin
        mb_cov.get(tr);
        cg.sample();
    end
    endtask:run
endclass:Subscriber