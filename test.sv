package test_pkg;
	class my_test extends uvm_test;

		my_env env;
        my_sequence seq;

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
            
            $display("test build phase");
        endfunction

    endclass
endpackage
