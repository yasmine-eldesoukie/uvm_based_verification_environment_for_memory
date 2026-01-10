package subscriber_pkg;
	class my_subscriber extends uvm_subscriber #(my_seq_item);

		virtual function void write(T t);

        endfunction

    endclass
endpackage
