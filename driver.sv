package driver_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_driver extends uvm_driver #(my_seq_item);

		my_seq_item seq_item;

		virtual intf driv_vif; 
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_driver);

		//step 2: default constructor 
		function new (string name= "driver", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); 

            //-------------- Virtual Interface --------------//
            if (!(uvm_config_db #(virtual intf)::get(this,"", "my_vif", driv_vif)))
                `uvm_info("my_driver", "Failed to get vif in driver", UVM_LOW); 
            $display("driver build phase");
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            $display("driver connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            forever begin
                seq_item_port.get_next_item(seq_item);
                
                seq_item_port.item_done(); 
            end

            $display("driver run phase");
        endtask
        
    endclass
endpackage

