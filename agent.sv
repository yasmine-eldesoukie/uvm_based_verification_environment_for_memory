package agent_pkg;
	class my_agent extends uvm_agent;

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_agent);

		//step 2: default constructor
		function new (string name= "agent", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
