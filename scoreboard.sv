package scoreboard_pkg;
	class my_scoreboard extends uvm_scoreboard #(my_seq_item);

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_scoreboard);

		//step 2: default constructor
		function new (string name= "scoreboard", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
