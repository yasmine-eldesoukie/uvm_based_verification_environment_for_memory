package scoreboard_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_scoreboard extends uvm_scoreboard;

		my_seq_item seq_item;

        uvm_tlm_analysis_fifo #(my_seq_item) scr_fifo;
        uvm_analysis_export #(my_seq_item) scr_ax;
		
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
            scr_fifo.get_peek_export.get(seq_item);

            $display("scoreboard run phase");
        endtask

    endclass
endpackage
