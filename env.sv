package env_pkg;
	class my_env extends uvm_env;

		my_agent agnt;
        my_scoreboard scr;
        my_subscriber sub;

        virtual intf env_vif;

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

            //-------------- Virtual Interface --------------//
            if(!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", env_vif)))
                `uvm_info("my_env", "Failed to get vif in env", UVM_LOW);
            uvm_config_db #(virtual intf)::set(this,"agnt", "my_vif", env_vif);

            $display("env build phase");
        endfunction

    endclass
endpackage
