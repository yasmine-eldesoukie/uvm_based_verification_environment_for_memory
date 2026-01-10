package env_pkg;
	class my_env extends uvm_env;

		//default constructor
		function new (string name= "env", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
