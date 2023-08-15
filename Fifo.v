module Fifo#(parameter DATA_SIZE=8,parameter ADDR_SIZE=4)(write_clk,read_clk,write_data,read_data,write_inc,read_inc,write_reset,read_reset,full,empty);

input write_clk,read_clk,write_inc,read_inc,write_reset,read_reset;
input[DATA_SIZE-1:0] write_data;
output empty,full;
output[DATA_SIZE-1:0] read_data;

wire fifo_empty,fifo_full;
wire[ADDR_SIZE-1:0] write_addr,read_addr;

wire[ADDR_SIZE:0] r2wr_ptr,r2wr_ptr_sync,wr2r_ptr,wr2r_ptr_sync;


fifo_mem  #(DATA_SIZE,ADDR_SIZE) mem(.write_addr(write_addr),.write_data(write_data),.read_data(read_data),.read_addr(read_addr),.write_clk(write_clk),.write_clk_en(write_inc),.write_full(fifo_full));


write_full  #(ADDR_SIZE) writer(.write_addr(write_addr),.write_ptr(wr2r_ptr),.full(fifo_full),.write_clk(write_clk),.write_reset(write_reset),.write_inc(write_inc),.read_ptr_sync(r2wr_ptr_sync));


read_empty  #(ADDR_SIZE) reader(.read_reset(read_reset),.read_clk(read_clk),.read_inc(read_inc),.write_ptr_sync(wr2r_ptr_sync),.read_addr(read_addr),.read_ptr(r2wr_ptr),.empty(fifo_empty));


read_to_write_sync  #(ADDR_SIZE) writer_clk_domain(.read_ptr(r2wr_ptr),.write_clk(write_clk),.write_reset(write_reset),.read_sync_ptr(r2wr_ptr_sync));

write_to_read_sync  #(ADDR_SIZE) reader_clk_domain(.write_ptr(wr2r_ptr),.read_clk(read_clk),.read_reset(read_reset),.write_sync_ptr(wr2r_ptr_sync));


assign empty = fifo_empty;

assign full = fifo_full;

endmodule