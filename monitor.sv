package monitor_pkg;
	class my_monitor extends uvm_monitor;

		my_seq_item seq_item;

		virtual intf monitor_vif; 
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_monitor);

		//step 2: default constructor
		function new (string name= "monitor", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item");

            //-------------- Virtual Interface --------------//
            if (!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", mon_vif)))
                `uvm_info("my_monitor", "Failed to get vif in monitor", UVM_LOW); 
            $display("monitor build phase");
        endfunction
        endfunction

    endclass
endpackage
