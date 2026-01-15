package test_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import env_pkg::*;
    import sequence_pkg::*;
	class my_test extends uvm_test;

		my_env env;
        my_sequence seq;
        // a- create an instance of the virtual interface to store the handle passed down from tb_top module
        virtual intf test_vif;

        /* step 1: registeration in the factory */
        `uvm_component_utils(my_test);

		//step 2: default constructor
		function new (string name= "test", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq= my_sequence::type_id::create("seq"); //object creation, needs no location
            env= my_env::type_id::create("env",this); //component creation, "this" points to where the comp. will be created

            //-------------- Virtual Interface --------------//
            // b- get the virtual handle 
            if(!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", test_vif))) //written this way because "get" return is not void, if it fails it returns 0 --> error message will show
                `uvm_info("my_test", "Failed to get vif in test", UVM_LOW);
            //c- set it to env, just like you did in tb_top
            uvm_config_db #(virtual intf)::set(this,"env", "my_vif", test_vif);
            
            $display("test build phase");
        endfunction

    endclass
endpackage
