package sequence_pkg;
	`include "uvm_macros.svh"
    import uvm_pkg::*;

	import seq_item_pkg::*;
	class my_sequence extends uvm_sequence #(my_seq_item); //uvm_sequence is parameterized with the seq_item class it operates on
		
		/* step 1: registeration in the factory */
        `uvm_object_utils(my_sequence);

		// step 2: default constructor
		function new (string name= "sequence"); //my_sequence is an object
            super.new(name);
        endfunction

    endclass
endpackage
