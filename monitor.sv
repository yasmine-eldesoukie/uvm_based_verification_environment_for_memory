package monitor_pkg;
	class my_monitor extends uvm_monitor;

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_monitor);

		//step 2: default constructor
		function new (string name= "monitor", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
