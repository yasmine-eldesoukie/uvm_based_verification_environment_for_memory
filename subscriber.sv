package subscriber_pkg;
	class my_subscriber extends uvm_subscriber #(my_seq_item);

		//default constructor
		function new (string name= "subscriber", uvm_component parent= null); 
            super.new(name,parent);
        endfunction

        //write function is defined as "pure virtual" so it has to be implemented
		virtual function void write(T t);

        endfunction

    endclass
endpackage
