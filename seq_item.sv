package seq_item_pkg;
    class my_seq_item extends uvm_sequence_item;

        //defualt constructor, arguments of ~new~ can be found in the uvm_sequence_item source code
        function new (string name= "seq_item"); //seq_item is an object, it has no runtime-parent
            super.new(name); //super points to the parent class "uvm_sequence_item" to call its constructor, or else it won't be called
        endfunction

    endclass
endpackage
