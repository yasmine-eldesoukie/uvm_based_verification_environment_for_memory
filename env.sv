package env_pkg;
	class my_env extends uvm_env;

		my_agent agnt;
        my_scoreboard scr;
        my_subscriber sub;

        /* step 1: registeration in the factory */
        `uvm_component_utils(my_env);

		//step 2: default constructor
		function new (string name= "env", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            agnt= my_agent::type_id::create("agnt",this); 
            scr= my_scoreboard::type_id::create("scr",this); 
            sub= my_subscriber::type_id::create("sub",this); 

            $display("env build phase");
        endfunction

    endclass
endpackage
