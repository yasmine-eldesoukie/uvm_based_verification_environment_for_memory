package sequence_pkg;
	`include "uvm_macros.svh"
    import uvm_pkg::*;

	import seq_item_pkg::*;
	class my_sequence extends uvm_sequence #(my_seq_item); //uvm_sequence is parameterized with the seq_item class it operates on
		
		my_seq_item reset_pkt, write_pkt, read_pkt;
		randc logic [3:0] local_addr; //will be used inside loops to cyclic-randomize the address , because a new packet with each iteration contradicts "randc" in seq_item 

		/* step 1: registeration in the factory */
        `uvm_object_utils(my_sequence);

		// step 2: default constructor
		function new (string name= "sequence"); //my_sequence is an object
            super.new(name);
        endfunction

        task body();
        	//------------- Reset -------------//
        	reset_pkt=my_seq_item::type_id::create("reset_pkt");
        	
        	start_item(reset_pkt);
	        	reset_pkt.rst= 1'b0;
	        	reset_pkt.en= 1'b0;
	        	reset_pkt.re= 1'b0;
	        	reset_pkt.data_in= 'b0;
	        	reset_pkt.addr= 'b0;
        	finish_item(reset_pkt);
        	#50ns

            //------------- Write -------------//
        	
        	repeat (16) begin
        		write_pkt=my_seq_item::type_id::create("write_pkt");
	        	start_item(write_pkt);
	        		//this randomizes rand variables in the my_seq_item class
	        		if ( !write_pkt.randomize() ) 
		        		`uvm_fatal("RAND_FAILED", "write_pkt randomization failed" );
		        	//this randomizes the rand varibales in this class
		        	if ( !this.randomize() ) 
		        		`uvm_fatal("RAND_FAILED", "local_addr randomization failed" );
		        	write_pkt.rst= 1'b1;
		        	write_pkt.en=  1'b1;
		        	write_pkt.re=  1'b0;
		        	write_pkt.addr= local_addr;
	        	finish_item(write_pkt);
            end

            //------------- Read -------------//
  
        	repeat (16) begin
        		read_pkt=my_seq_item::type_id::create("read_pkt");
	        	start_item(read_pkt);
	        		if ( !read_pkt.randomize() ) 
		        		`uvm_fatal("RAND_FAILED", "read_pkt randomization failed" );
		        	if ( !this.randomize() ) 
		        		`uvm_fatal("RAND_FAILED", "local_addr randomization failed" );
		        	read_pkt.rst= 1'b1;
		        	read_pkt.en=  1'b0;
		        	read_pkt.re=  1'b1;
		        	read_pkt.addr= local_addr;
	        	finish_item(read_pkt);
            end
        endtask

    endclass
endpackage
