module read_empty#(parameter ADDR_SIZE = 4)(read_reset,read_clk,read_inc,write_ptr_sync,read_addr,read_ptr,empty);

input read_clk,read_reset,read_inc;
input[ADDR_SIZE:0]write_ptr_sync;
output empty;
output[ADDR_SIZE-1:0] read_addr;
output[ADDR_SIZE:0] read_ptr;


reg[ADDR_SIZE:0] present_bin,present_gray;
reg present_empty;
wire[ADDR_SIZE:0] next_bin,next_gray;
wire next_empty;


always@(posedge read_clk or negedge read_reset)
 if(!read_reset)
	begin
		{present_bin,present_gray}<=0;
		present_empty<=1'b1;
	end
 else
	begin
		{present_bin,present_gray}<={next_bin,next_gray};
		present_empty<=next_empty;
	end	
	
	
assign next_bin = present_bin + (read_inc & ~present_empty);

assign next_gray = next_bin ^ (next_bin>>1);

assign read_addr = present_bin[ADDR_SIZE-1:0];

assign read_ptr = present_gray;

assign next_empty = (next_gray==write_ptr_sync);

assign empty = present_empty;

endmodule