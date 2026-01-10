package sequence_pkg;
	class my_sequence extends uvm_sequence #(my_seq_item); //uvm_sequence is parameterized with the seq_item class it operates on
		
		//default constructor
		function new (string name= "sequence"); //my_sequence is an object
            super.new(name);
        endfunction

    endclass
endpackage
