module reg32_avalon_interface (clock, resetn, writedata, readdata, write, read,
                               byteenable, chipselect, Q_export);
										 
  input clock, resetn, read, write, chipselect; 
  input [3:0] byteenable;
  input [31:0] writedata; 
  output reg [31:0] readdata; 
  output [31:0] Q_export;
  reg [3:0] write_count = 0 ; 
  reg [3:0] read_count = 15 ;
  reg [5:0] count = 0 ;
  reg [31:0] from_cpu_mem [ 0:7 ] ; 
  reg [31:0] to_cpu_mem [ 0:4 ] ;
  wire [31:0] AES_data_out [ 0:3 ] ;
  localparam READ_REQ=0, WRITE_REQ=1 ;
  reg temp=0;
  reg prev_request = WRITE_REQ ;
  localparam [3:0] INVALID_READ_COUNT=15 ;
  localparam [3:0] MAX_WRITE_COUNT = 8 ;
  localparam [3:0] MAX_READ_COUNT = 5 ;
  localparam [5:0] MAX_COUNT = 35 ;
  
  always @( posedge clock ) begin
    if ( resetn==1'b0 ) begin write_count <= 0 ; 
      read_count <= INVALID_READ_COUNT ; 
      prev_request<=WRITE_REQ ;
		to_cpu_mem[0]<=0;
       count <= 0 ;
		 temp<=0;
    end else begin
      if ( chipselect && write ) begin prev_request <= WRITE_REQ ; 
        if ( write_count < MAX_WRITE_COUNT ) begin 
          write_count <= write_count + 1 ; from_cpu_mem [ write_count ] <= writedata ;
           count <= 0 ;to_cpu_mem[0]<=0;
        end 
      end else if ( chipselect && read && ( prev_request != WRITE_REQ ) ) begin
        prev_request <= READ_REQ ; count <= 0 ; 
      end else if ( chipselect && read && ( prev_request==WRITE_REQ ) ) begin
        prev_request <= READ_REQ ;
		  temp<=1;
        if ( (read_count == INVALID_READ_COUNT)&&(temp==1)) begin read_count <= 1 ; end 
        else if ( read_count < MAX_READ_COUNT  ) begin read_count <= read_count + 1 ; end
        else if ( read_count == MAX_READ_COUNT ) begin
          write_count <= 0 ;  
        end
      end else begin 
        if ( (write_count==MAX_WRITE_COUNT) && (count < MAX_COUNT )) begin
          count <= count + 1 ;
          to_cpu_mem[0]<=0;			 
        end else if ( (write_count==MAX_WRITE_COUNT) && (count == MAX_COUNT )) begin to_cpu_mem[0] <= 1 ; 
        end
      end 
    end
  end
  
  always @(*) begin
    if ( chipselect && read && (read_count != INVALID_READ_COUNT) ) begin 
      readdata <= to_cpu_mem[read_count] ;
    end else if ( chipselect && read ) begin readdata <= to_cpu_mem[0] ; 
    end else begin readdata <= 32'bz ; end
  end
 always @(posedge clock) begin
	 to_cpu_mem[1]<=AES_data_out[0];
    to_cpu_mem[2]<=AES_data_out[1];
	 to_cpu_mem[3]<=AES_data_out[2];
	 to_cpu_mem[4]<=AES_data_out[3];
  end
  Aes_encryption Component(.clk(clock),.data_in({from_cpu_mem[0],from_cpu_mem[1],from_cpu_mem[2],from_cpu_mem[3]}),
                                       .key({from_cpu_mem[4],from_cpu_mem[5],from_cpu_mem[6],from_cpu_mem[7]}),
													.data_out({AES_data_out[0],AES_data_out[1],AES_data_out[2],AES_data_out[3]}));		 
  assign Q_export =to_cpu_mem[0];
endmodule
