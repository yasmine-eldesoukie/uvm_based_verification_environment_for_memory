package agent_pkg;
	class my_agent extends uvm_agent;

		//default constructor
		function new (string name= "agent", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
