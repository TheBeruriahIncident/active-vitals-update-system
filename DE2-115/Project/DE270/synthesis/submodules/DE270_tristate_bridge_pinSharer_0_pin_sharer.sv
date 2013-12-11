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



  
`timescale 1 ns / 1 ns

			 
module DE270_tristate_bridge_pinSharer_0_pin_sharer (
 // ** Clock and Reset Connections
    input  logic clk
   ,input  logic reset

 // ** Arbiter Connections

 // *** Arbiter Grant Interface
   ,output logic ack
   ,input  logic [ 1 - 1 : 0 ] next_grant

// *** Arbiter Request Interface

    ,output logic arb_ssram_tcm 
		
		     // ** Avalon TC Slave Interfaces




  // Slave Interface tcs0

    ,input  logic tcs0_request 
    ,output logic tcs0_grant   

  //ssram.tcm signals
    ,input  logic[ 0 :0 ] tcs0_tcm_chipselect_n_out
    ,input  logic[ 3 :0 ] tcs0_tcm_byteenable_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_outputenable_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_write_n_out
    ,output logic[ 31 :0 ]  tcs0_tcm_data_in
    ,input  logic[ 31 :0 ]  tcs0_tcm_data_out
    ,input  logic tcs0_tcm_data_outen
    ,input  logic[ 20 :0 ] tcs0_tcm_address_out
    ,input  logic[ 0 :0 ] tcs0_tcm_reset_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_begintransfer_n_out
		     
		     // ** Avalon TC Master Interface
    ,output logic request
    ,input  logic grant

		     // *** Passthrough Signals
		     
		     
                     // *** Shared Signals
		      	     
    ,output  logic[ 3 :0 ] bw_n_to_the_ssram
    ,output  logic[ 0 :0 ] outputenable_n_to_the_ssram
    ,input   logic[ 31  :0 ]  data_to_and_from_the_ssram_in
    ,output  logic[ 31  :0 ]  data_to_and_from_the_ssram
    ,output  logic data_to_and_from_the_ssram_outen
    ,output  logic[ 20 :0 ] address_to_the_ssram
    ,output  logic[ 0 :0 ] chipenable1_n_to_the_ssram
    ,output  logic[ 0 :0 ] bwe_n_to_the_ssram
    ,output  logic[ 0 :0 ] adsc_n_to_the_ssram
    ,output  logic[ 0 :0 ] reset_n_to_the_ssram

		     );

   function [1-1:0] getIndex;
      
      input [1-1:0] select;
      
      getIndex = 'h0;
      
      for(int i=0; i < 1; i = i + 1) begin
	 if( select[i] == 1'b1 )
           getIndex = i;
      end
      
   endfunction // getIndex

   logic[ 1 - 1 : 0 ] selected_grant;


   // Request Assignments

    assign arb_ssram_tcm = tcs0_request;
   
   logic [ 1 - 1 : 0 ] concated_incoming_requests;
   
   
   assign 			      concated_incoming_requests = {						    
         tcs0_request 
				};
   
				       
   assign 			      request = | concated_incoming_requests;
  assign        tcs0_grant = selected_grant[0];

   
    // Perform Grant Selection						  
   always@(posedge clk, posedge reset) begin
     if(reset) begin
	selected_grant<=0;
	ack <= 0;
     end 
     else begin
       if(grant && (concated_incoming_requests[getIndex(selected_grant)] == 0 || selected_grant == 0 )) begin
	  if(~request)
	    selected_grant <= '0;
	  else
	    selected_grant <= next_grant;
	  
          ack<=1;
       end
       else begin
         ack<=0;
         selected_grant <= selected_grant;
       end
     end
   end // always@ (posedge clk, posedge reset)

// Passthrough Signals

  
// Renamed Signals
    assign chipenable1_n_to_the_ssram = tcs0_tcm_chipselect_n_out ;
    assign bw_n_to_the_ssram = tcs0_tcm_byteenable_n_out ;
    assign outputenable_n_to_the_ssram = tcs0_tcm_outputenable_n_out ;
    assign bwe_n_to_the_ssram = tcs0_tcm_write_n_out ;
    assign tcs0_tcm_data_in = data_to_and_from_the_ssram_in[31:0];
    assign data_to_and_from_the_ssram =  tcs0_tcm_data_out;
    assign data_to_and_from_the_ssram_outen = tcs0_tcm_data_outen;
    assign address_to_the_ssram = tcs0_tcm_address_out ;
    assign reset_n_to_the_ssram = tcs0_tcm_reset_n_out ;
    assign adsc_n_to_the_ssram = tcs0_tcm_begintransfer_n_out ;
  
// Shared Signals
  
endmodule   
					    



