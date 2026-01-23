package scoreboard_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
    class my_scoreboard extends uvm_scoreboard;

        my_seq_item seq_item;

        uvm_tlm_analysis_fifo #(my_seq_item) scr_fifo;
        uvm_analysis_export #(my_seq_item) scr_ax;

        logic [31:0] shadow_mem [int]; //this is a dynamic array that grows as you write in it
        
        /* since the dut takes 1 clk cyle to process a read order and output, scoreboard will postbone the checking of read data_out till next call
           this will be acheived with a flag and a variable storing the addr of the stored data.
           note: this is the same for the rst, because it's syncronous, it will be proccessed and evaluted in the next cycle
        */


        bit check_read_data; //this is a flag to control if scoreboard checks read data_out in the next call
        bit check_reset; //flag to check the reset output in the next call
        logic [3:0] read_addr; //to store the addr with the read order for next cycle when comapring
        
        /* step 1: registeration in the factory */
        `uvm_component_utils(my_scoreboard);

        //step 2: default constructor
        function new (string name= "scoreboard", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); 

            //---------- port ----------//
            scr_fifo = new("scr_fifo", this);
            scr_ax = new("scr_ax", this);

            $display("scoreboard build phase");
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            scr_ax.connect(scr_fifo.analysis_export);

            $display("scoreboard connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            $display("scoreboard run phase");

            forever begin
                scr_fifo.get_peek_export.get(seq_item);
                //-------------- Process Previous command --------------//
                if (check_reset) begin
                    shadow_mem.delete();
                    if (seq_item.data_out !== 'b0 || seq_item.valid_out !== 'b0) 
                        `uvm_error("Data_Mismatch", $sformatf("data_out = %0h | valid_out= %0b", seq_item.data_out, seq_item.valid_out));
                    //turn off the flag
                    check_reset= 1'b0;
                end
                else if (check_read_data) begin
                    if (seq_item.valid_out !== 'b1) 
                        `uvm_error("Data_Mismatch", $sformatf("valid_out= %0b", seq_item.valid_out));
                    if (seq_item.data_out !== shadow_mem[read_addr]) 
                        `uvm_error("Data_Mismatch", $sformatf("data_out = %0h, expected data_out= %0h, at addr= %0d", seq_item.data_out, shadow_mem[read_addr], read_addr)); 
                    //turn down the flag 
                    check_read_data= 1'b0;
                end

                //-------------- Process Current command --------------//
                if (!seq_item.rst) begin
                    check_reset= 1'b1;
                end
                else if (seq_item.en) begin
                    shadow_mem[seq_item.addr] = seq_item.data_in;
                    //$display("shadow_mem= %0p", shadow_mem);
                end
                else if (seq_item.re) begin
                    read_addr= seq_item.addr;
                    check_read_data= 1'b1;
                end
            end
        endtask

    endclass
endpackage
