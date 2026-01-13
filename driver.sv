package driver_pkg;
	class my_driver extends uvm_driver #(my_seq_item);

		my_seq_item seq_item;
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_driver);

		//step 2: default constructor 
		function new (string name= "driver", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); 
            $display("driver build phase");
        endfunction
        
    endclass
endpackage

