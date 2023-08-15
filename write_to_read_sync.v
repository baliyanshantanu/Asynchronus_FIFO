module write_to_read_sync#(parameter ADDR_SIZE=4)(write_ptr,read_clk,read_reset,write_sync_ptr);

input[ADDR_SIZE:0] write_ptr;
input read_clk,read_reset;
output reg[ADDR_SIZE:0] write_sync_ptr;

reg[ADDR_SIZE:0]ptr_1;

always@(posedge read_clk or negedge read_reset)
	if(!read_reset)
		{write_sync_ptr,ptr_1}<=0;
	else	
		{write_sync_ptr,ptr_1}<={ptr_1,write_ptr};
	
endmodule