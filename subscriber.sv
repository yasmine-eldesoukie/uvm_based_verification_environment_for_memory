package subscriber_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import seq_item_pkg::*;
	class my_subscriber extends uvm_subscriber #(my_seq_item);

		my_seq_item seq_item;
        logic [3:0] prev_addr; //needed for cross coverage between prev and current addr
		
		/* step 1: registeration in the factory */
        `uvm_component_utils(my_subscriber);

        covergroup cg;
            cp_data_in: coverpoint seq_item.data_in{
                bins all_zeros ={'b0};
                bins all_ones  ={'hffffffff};
                bins toggle    ={'h55555555, 'haaaaaaaa};
            }
            cp_op: coverpoint {seq_item.en, seq_item.re} {
                bins write = {2'b10};
                bins read = {2'b01};
                ignore_bins idle = {2'b00};
                bins wr_rd = {2'b11};
            }
            cp_curr_addr: coverpoint seq_item.addr{
                bins range[] = {[15:0]}; //all addr values are hit
                //bins transitions[] = ([15:0] => [15:0]); //all transitions are hit
                bins toggle = (15 => 0), (0 => 15); //transition from all ones to all zeros and vice versa
            }
            cp_prev_addr: coverpoint prev_addr;

            cross_walk: cross cp_curr_addr, cp_prev_addr {
                bins incr = cross_walk with (cp_curr_addr == cp_prev_addr + 1); //checks if 1=>2 and if  2=>3 , 3=>4 and so on
                bins decr = cross_walk with (cp_curr_addr == cp_prev_addr - 1); //checks if 2=>1 , 3=>2 and so on
                ignore_bins others = cross_walk with (!(cp_curr_addr == cp_prev_addr + 1) || !(cp_curr_addr == cp_prev_addr - 1));
            }

            cross_addr_op: cross cp_curr_addr, cp_op { //checks if each addr had write, read and wr_rd commands
                //ignore_bins ignore_idle = binsof (cp_op.idle);
                ignore_bins ignore_toggle = binsof (cp_curr_addr.toggle);
            }
        endgroup 

		//step 2: default constructor
		function new (string name= "subscriber", uvm_component parent= null); 
            super.new(name,parent);
            cg= new();
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            //step 3: creation
            seq_item= my_seq_item::type_id::create("seq_item"); 
            $display("subscriber build phase");
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            $display("subscriber connect phase");
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);

            $display("subscriber run phase");
        endtask

        //write function is defined as "pure virtual" so it has to be implemented
		virtual function void write(my_seq_item t);
            seq_item= t;
            if (t.rst) begin
                cg.sample();
                prev_addr= t.addr;
            end
        endfunction

        function void extract_phase (uvm_phase phase);
            super.extract_phase(phase);
            $display("subscriber extract phase");
        endfunction

    endclass
endpackage
