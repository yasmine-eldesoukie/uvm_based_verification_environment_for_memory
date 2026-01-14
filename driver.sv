package driver_pkg;
	class my_driver extends uvm_driver #(my_seq_item);

		my_seq_item seq_item;

		virtual intf driv_vif; 
		
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

            //-------------- Virtual Interface --------------//
            if (!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", driv_vif)))
                `uvm_info("my_driver", "Failed to get vif in driver", UVM_LOW); 
            $display("driver build phase");
        endfunction
        
    endclass
endpackage

