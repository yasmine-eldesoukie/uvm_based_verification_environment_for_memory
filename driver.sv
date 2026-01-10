package driver_pkg;
	class my_driver extends uvm_driver #(my_seq_item);

		//default constructor 
		function new (string name= "driver", uvm_component parent= null); 
            super.new(name,parent);
        endfunction
        
    endclass
endpackage

