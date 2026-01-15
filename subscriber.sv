package subscriber_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_subscriber extends uvm_subscriber #(my_seq_item);

		my_seq_item seq_item;
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_subscriber);

		//step 2: default constructor
		function new (string name= "subscriber", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); 
            $display("subscriber build phase");
        endfunction

        //write function is defined as "pure virtual" so it has to be implemented
		virtual function void write(T t);

        endfunction

    endclass
endpackage
