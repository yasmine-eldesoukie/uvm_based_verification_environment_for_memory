package monitor_pkg;
	class my_monitor extends uvm_monitor;

		my_seq_item seq_item;
		
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
            $display("monitor build phase");
        endfunction
        endfunction

    endclass
endpackage
