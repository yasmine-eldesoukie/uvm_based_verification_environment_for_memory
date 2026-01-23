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

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            $display("test connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            $display("test run phase");
            //this line is to set a time so that the test doesn't end before the last packet is proccessed
            phase.get_objection().set_drain_time(this, 50ns);

            phase.raise_objection(this);
            seq.start(env.agnt.seqr);
            phase.drop_objection(this);
        endtask

        function void extract_phase (uvm_phase phase);
            super.extract_phase(phase);
            $display("test extract phase");
        endfunction

    endclass
endpackage
