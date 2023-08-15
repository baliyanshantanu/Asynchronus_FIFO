module read_to_write_sync#(parameter ADDR_SIZE=4)(read_ptr,write_clk,write_reset,read_sync_ptr);

input[ADDR_SIZE:0] read_ptr;
input write_clk,write_reset;
output reg[ADDR_SIZE:0] read_sync_ptr;

reg[ADDR_SIZE:0]ptr_1;

always@(posedge write_clk or negedge write_reset)
	if(!write_reset)
		{read_sync_ptr,ptr_1}<=0;
	else	
		{read_sync_ptr,ptr_1}<={ptr_1,read_ptr};
	
endmodule