module write_full#(parameter ADDR_SIZE = 4)(write_addr,write_ptr,full,write_clk,write_reset,write_inc,read_ptr_sync);

input write_clk,write_reset,write_inc;
output full;
input[ADDR_SIZE:0] read_ptr_sync;
output[ADDR_SIZE-1:0] write_addr;
output[ADDR_SIZE:0] write_ptr;


reg[ADDR_SIZE:0] present_bin,present_gray;
reg present_full;
wire[ADDR_SIZE:0] next_bin,next_gray;
wire next_full;

always@(posedge write_clk or negedge write_reset)
 if(!write_reset)
	begin
		present_bin<=0;
		present_gray<=0;
		present_full<=1'b0;
	end
 else
   begin
		present_bin<=next_bin;
		present_gray<=next_gray;
		present_full<=next_full;
	end	
	
assign next_bin = present_bin + (write_inc & ~present_full);

assign next_gray = (next_bin>>1) ^ next_bin;

assign next_full = ((read_ptr_sync[ADDR_SIZE-1]!=present_gray[ADDR_SIZE-1]) && (read_ptr_sync[ADDR_SIZE-2]!=present_gray[ADDR_SIZE-2]) && (read_ptr_sync[ADDR_SIZE-3:0]==present_gray[ADDR_SIZE-3:0]));

assign write_addr = present_bin[ADDR_SIZE-1:0];

assign write_ptr = present_gray;

assign full = present_full;

endmodule