package test_pkg;
	class my_test extends uvm_test;

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_test);

		//step 2: default constructor
		function new (string name= "test", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
