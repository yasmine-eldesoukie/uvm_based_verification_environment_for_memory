module tb_top();
    import mem_pkg::*;
    
    logic clk;
    intf my_intf(clk);

    memory_16x32 dut(
        .clk(clk),
        .rst(my_intf.rst),
        .en(my_intf.en),
        .re(my_intf.re),
        .addr(my_intf.addr),
        .data_in(my_intf.data_in),
        .data_out(my_intf.data_out),
        .valid_out(my_intf.valid_out)
    );

    initial begin
        clk=1'b0;
        always #5 clk=~clk;
    end

    initial begin
        /*uvm_config_db #(data_type)::set(context, instance_path , field_name, value);
          --> context: start of the path, "null" for modules and "this" for classes
          --> instance_path: string representing where to set the item in, "name_of_component_inside_this_path" , ex: "uvm_test_top" means the item of data_type will be set in uvm_test_top
          --> field_name: string label given to match data later
          --> value: the actual data to store.
        */

        /*uvm_config_db #(data_type)::get(context, instance_path , field_name, value);
          --> context: start of the path, "this" for classes. Ex: in agent it will be equivlant to uvm_test_top.my_env.my_agent
          --> instance_path: string representing where to get the item, "name_of_component_inside_this_path", so it will be just "" because the path is "this"
          --> field_name: string label must match that in "set" 
          --> value: the actual data to store = created instance of the data in the target file, Ex: i will call the virt. intf. handle in test "test_vif"
        */
        uvm_config_db #(virtual intf)::set(null,"uvm_test_top", "my_vif", my_intf); //for learning purposes, i will change the value argument depending on the file, just to observe the difference
        run_test("my_test"); 
        //this run_test task is global in src/base/globals.svh
        //it finishes simulation as well , don't put commands afterwards
    end
endmodule
