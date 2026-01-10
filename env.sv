package env_pkg;
	class my_env extends uvm_env;

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_env);

		//step 2: default constructor
		function new (string name= "env", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
