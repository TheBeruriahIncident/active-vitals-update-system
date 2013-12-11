// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/13.0sp1/ip/merlin/altera_tristate_conduit_bridge/altera_tristate_conduit_bridge.sv.terp#1 $
// $Revision: #1 $
// $Date: 2013/03/07 $
// $Author: swbranch $

//Defined Terp Parameters


			    

`timescale 1 ns / 1 ns
  				      
module DE270_tristate_bridge_bridge_0 (
     input  logic clk
    ,input  logic reset
    ,input  logic request
    ,output logic grant
    ,input  logic[ 0 :0 ] tcs_bwe_n_to_the_ssram
    ,output  wire [ 0 :0 ] bwe_n_to_the_ssram
    ,input  logic[ 0 :0 ] tcs_reset_n_to_the_ssram
    ,output  wire [ 0 :0 ] reset_n_to_the_ssram
    ,input  logic[ 0 :0 ] tcs_chipenable1_n_to_the_ssram
    ,output  wire [ 0 :0 ] chipenable1_n_to_the_ssram
    ,input  logic[ 3 :0 ] tcs_bw_n_to_the_ssram
    ,output  wire [ 3 :0 ] bw_n_to_the_ssram
    ,input  logic[ 0 :0 ] tcs_outputenable_n_to_the_ssram
    ,output  wire [ 0 :0 ] outputenable_n_to_the_ssram
    ,input  logic[ 0 :0 ] tcs_adsc_n_to_the_ssram
    ,output  wire [ 0 :0 ] adsc_n_to_the_ssram
    ,input  logic[ 20 :0 ] tcs_address_to_the_ssram
    ,output  wire [ 20 :0 ] address_to_the_ssram
    ,output logic[ 31 :0 ] tcs_data_to_and_from_the_ssram_in
    ,input  logic[ 31 :0 ] tcs_data_to_and_from_the_ssram
    ,input  logic tcs_data_to_and_from_the_ssram_outen
    ,inout  wire [ 31 :0 ]  data_to_and_from_the_ssram
		     
   );
   reg grant_reg;
   assign grant = grant_reg;
   
   always@(posedge clk) begin
      if(reset)
	grant_reg <= 0;
      else
	grant_reg <= request;      
   end
   


 // ** Output Pin bwe_n_to_the_ssram 
 
    reg                       bwe_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   bwe_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   bwe_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] bwe_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 bwe_n_to_the_ssram_reg   <= tcs_bwe_n_to_the_ssram[ 0 : 0 ];
      end
          
 
    assign 	bwe_n_to_the_ssram[ 0 : 0 ] = bwe_n_to_the_ssramen_reg ? bwe_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin reset_n_to_the_ssram 
 
    reg                       reset_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   reset_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   reset_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] reset_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 reset_n_to_the_ssram_reg   <= tcs_reset_n_to_the_ssram[ 0 : 0 ];
      end
          
 
    assign 	reset_n_to_the_ssram[ 0 : 0 ] = reset_n_to_the_ssramen_reg ? reset_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin chipenable1_n_to_the_ssram 
 
    reg                       chipenable1_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   chipenable1_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   chipenable1_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] chipenable1_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 chipenable1_n_to_the_ssram_reg   <= tcs_chipenable1_n_to_the_ssram[ 0 : 0 ];
      end
          
 
    assign 	chipenable1_n_to_the_ssram[ 0 : 0 ] = chipenable1_n_to_the_ssramen_reg ? chipenable1_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin bw_n_to_the_ssram 
 
    reg                       bw_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   bw_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   bw_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 3 : 0 ] bw_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 bw_n_to_the_ssram_reg   <= tcs_bw_n_to_the_ssram[ 3 : 0 ];
      end
          
 
    assign 	bw_n_to_the_ssram[ 3 : 0 ] = bw_n_to_the_ssramen_reg ? bw_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin outputenable_n_to_the_ssram 
 
    reg                       outputenable_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   outputenable_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   outputenable_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] outputenable_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 outputenable_n_to_the_ssram_reg   <= tcs_outputenable_n_to_the_ssram[ 0 : 0 ];
      end
          
 
    assign 	outputenable_n_to_the_ssram[ 0 : 0 ] = outputenable_n_to_the_ssramen_reg ? outputenable_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin adsc_n_to_the_ssram 
 
    reg                       adsc_n_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   adsc_n_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   adsc_n_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] adsc_n_to_the_ssram_reg;   

     always@(posedge clk) begin
	 adsc_n_to_the_ssram_reg   <= tcs_adsc_n_to_the_ssram[ 0 : 0 ];
      end
          
 
    assign 	adsc_n_to_the_ssram[ 0 : 0 ] = adsc_n_to_the_ssramen_reg ? adsc_n_to_the_ssram_reg : 'z ;
        


 // ** Output Pin address_to_the_ssram 
 
    reg                       address_to_the_ssramen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   address_to_the_ssramen_reg <= 'b0;
	 end
	 else begin
	   address_to_the_ssramen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 20 : 0 ] address_to_the_ssram_reg;   

     always@(posedge clk) begin
	 address_to_the_ssram_reg   <= tcs_address_to_the_ssram[ 20 : 0 ];
      end
          
 
    assign 	address_to_the_ssram[ 20 : 0 ] = address_to_the_ssramen_reg ? address_to_the_ssram_reg : 'z ;
        


 // ** Bidirectional Pin data_to_and_from_the_ssram 
   
    reg                       data_to_and_from_the_ssram_outen_reg;
  
    always@(posedge clk) begin
	 data_to_and_from_the_ssram_outen_reg <= tcs_data_to_and_from_the_ssram_outen;
     end
  
  
    reg [ 31 : 0 ] data_to_and_from_the_ssram_reg;   

     always@(posedge clk) begin
	 data_to_and_from_the_ssram_reg   <= tcs_data_to_and_from_the_ssram[ 31 : 0 ];
      end
         
  
    assign 	data_to_and_from_the_ssram[ 31 : 0 ] = data_to_and_from_the_ssram_outen_reg ? data_to_and_from_the_ssram_reg : 'z ;
       
  
    reg [ 31 : 0 ] 	data_to_and_from_the_ssram_in_reg;
								    
    always@(posedge clk) begin
	 data_to_and_from_the_ssram_in_reg <= data_to_and_from_the_ssram[ 31 : 0 ];
    end
    
  
    assign      tcs_data_to_and_from_the_ssram_in[ 31 : 0 ] = data_to_and_from_the_ssram_in_reg[ 31 : 0 ];
        

endmodule


