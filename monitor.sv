package monitor_pkg;
	class my_monitor extends uvm_monitor;

		//default constructor
		function new (string name= "monitor", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
