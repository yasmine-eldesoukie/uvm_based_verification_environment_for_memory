package agent_pkg;
	class my_agent extends uvm_agent;

		my_driver driv;
        my_monitor mon;
        my_sequencer seqr;

        /* step 1: registeration in the factory */
        `uvm_component_utils(my_agent);

		//step 2: default constructor
		function new (string name= "agent", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            driv= my_driver::type_id::create("driv",this); //component creation, "this" points to where the comp. will be created
            mon= my_monitor::type_id::create("mon",this); 
            seqr= my_sequencer::type_id::create("seqr",this);

            $display("agent build phase");
        endfunction

    endclass
endpackage
