package scoreborad_pkg;
	class my_scoreborad extends uvm_scoreborad #(my_seq_item);

		//default constructor
		function new (string name= "scoreborad", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
