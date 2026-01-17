package monitor_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_monitor extends uvm_monitor;

		my_seq_item seq_item;

		virtual intf mon_vif;

        uvm_analysis_port #(my_seq_item) mon_ap;
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_monitor);

		//step 2: default constructor
		function new (string name= "monitor", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item");

            //-------------- Virtual Interface --------------//
            if (!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", mon_vif)))
                `uvm_info("my_monitor", "Failed to get vif in monitor", UVM_LOW); 

            //-------------- port --------------//
            mon_ap= new("mon_ap", this);

            $display("monitor build phase");
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            $display("monitor connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            mon_ap.write(seq_item);

            $display("monitor connect phase");
        endtask
    endclass
endpackage
