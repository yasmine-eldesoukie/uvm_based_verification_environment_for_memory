package sequencer_pkg;
	class my_sequencer extends uvm_sequencer #(my_seq_item);

		/* step 1: registeration in the factory */
        `uvm_component_utils(my_sequencer);

		//step 2: defualt constructor: for componenets, it creates a new comp. with ~name~ and as a child to ~parent~ 
        function new (string name= "sequencer", uvm_component parent= null); //my_sequencer will be inside the agnet, agent will be its runtime-parent but this infor will be defined in the agnet code, here leave parent as null
            super.new(name,parent);
        endfunction

    endclass
endpackage
