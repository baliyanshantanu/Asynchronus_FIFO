module fifo_mem#(parameter DATA_SIZE=8,parameter ADDR_SIZE=4)(write_addr,write_data,read_data,read_addr,write_clk,write_clk_en,write_full);

parameter DEPTH=1<<ADDR_SIZE;

input[DATA_SIZE-1:0] write_data;
input[ADDR_SIZE-1:0] write_addr,read_addr;
output[DATA_SIZE-1:0] read_data;
input write_clk,write_clk_en,write_full;

reg[DATA_SIZE-1:0] mem[0:DEPTH-1];


always@(posedge write_clk)
	if(write_clk_en && ~write_full)
		mem[write_addr]<=write_data;
		
assign read_data = mem[read_addr];

endmodule
