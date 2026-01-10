package driver_pkg;
	class my_driver extends uvm_driver #(my_seq_item);

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_driver);

		//step 2: default constructor 
		function new (string name= "driver", uvm_component parent= null); 
            super.new(name,parent);
        endfunction
        
    endclass
endpackage

