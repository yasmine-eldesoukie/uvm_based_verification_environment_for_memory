package sequencer_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_sequencer extends uvm_sequencer #(my_seq_item);

		my_seq_item seq_item;
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_sequencer);

		//step 2: defualt constructor: for componenets, it creates a new comp. with ~name~ and as a child to ~parent~ 
        function new (string name= "sequencer", uvm_component parent= null); //my_sequencer will be inside the agnet, agent will be its runtime-parent but this infor will be defined in the agnet code, here leave parent as null
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); //object creation, needs no location
            $display("sequencer build phase");
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            $display("sequencer connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            $display("sequencer run phase");
        endtask

        function void extract_phase (uvm_phase phase);
            super.extract_phase(phase);
            $display("sequencer extract phase");
        endfunction

    endclass
endpackage
