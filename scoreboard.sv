package scoreboard_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_scoreboard extends uvm_scoreboard;

		my_seq_item seq_item;
		
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
            $display("scoreboard build phase");
        endfunction

    endclass
endpackage
