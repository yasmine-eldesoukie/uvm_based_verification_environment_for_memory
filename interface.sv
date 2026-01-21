interface intf( input clk);
    logic rst;
    logic re;
    logic en;
    logic [3:0] addr;
    logic [31:0] data_in;
    logic [31:0] data_out;
    logic valid_out;

    clocking driv_cb @(posedge clk);
    	default output #1ns;
    	output rst, re, en, addr, data_in;
    endclocking

    clocking mon_cb @(posedge clk);
    	default input #1ns;
    	input rst, re, en, addr, data_in, data_out, valid_out;
    endclocking

endinterface 