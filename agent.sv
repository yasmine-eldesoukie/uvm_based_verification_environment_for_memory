package agent_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import driver_pkg::*;
    import monitor_pkg::*;
    import sequencer_pkg::*;
	class my_agent extends uvm_agent;

		my_driver driv;
        my_monitor mon;
        my_sequencer seqr;

        virtual intf agent_vif; 

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

            //-------------- Virtual Interface --------------//
            if(!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", agent_vif)))
                `uvm_info("my_agent", "Failed to get vif in agent", UVM_LOW);
            uvm_config_db #(virtual intf)::set(this,"driv", "my_vif", agent_vif);
            uvm_config_db #(virtual intf)::set(this,"mon", "my_vif", agent_vif);

            $display("agent build phase");
        endfunction

    endclass
endpackage
