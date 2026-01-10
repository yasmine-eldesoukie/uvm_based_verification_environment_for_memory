package test_pkg;
	class my_test extends uvm_test;

		//default constructor
		function new (string name= "test", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

    endclass
endpackage
