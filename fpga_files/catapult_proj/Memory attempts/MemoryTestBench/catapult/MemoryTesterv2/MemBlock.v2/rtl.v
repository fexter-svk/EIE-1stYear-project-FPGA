// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   al3515@EEWS104A-014
//  Generated date: Fri May 06 15:35:14 2016
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    MemBlock_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module MemBlock_core_fsm (
  clk, rst, fsm_output, st_data_vinit_1_tr0
);
  input clk;
  input rst;
  output [5:0] fsm_output;
  reg [5:0] fsm_output;
  input st_data_vinit_1_tr0;


  // FSM State Type Declaration for MemBlock_core_fsm_1
  parameter
    st_core_rlp = 3'd0,
    st_data_vinit = 3'd1,
    st_data_vinit_1 = 3'd2,
    st_main = 3'd3,
    st_main_1 = 3'd4,
    st_main_2 = 3'd5,
    state_x = 3'b000;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : MemBlock_core_fsm_1
    case (state_var)
      st_core_rlp : begin
        fsm_output = 6'b1;
        state_var_NS = st_data_vinit;
      end
      st_data_vinit : begin
        fsm_output = 6'b10;
        state_var_NS = st_data_vinit_1;
      end
      st_data_vinit_1 : begin
        fsm_output = 6'b100;
        if ( st_data_vinit_1_tr0 ) begin
          state_var_NS = st_data_vinit;
        end
        else begin
          state_var_NS = st_main;
        end
      end
      st_main : begin
        fsm_output = 6'b1000;
        state_var_NS = st_main_1;
      end
      st_main_1 : begin
        fsm_output = 6'b10000;
        state_var_NS = st_main_2;
      end
      st_main_2 : begin
        fsm_output = 6'b100000;
        state_var_NS = st_main;
      end
      default : begin
        fsm_output = 6'b000000;
        state_var_NS = st_core_rlp;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= st_core_rlp;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    MemBlock_core
// ------------------------------------------------------------------


module MemBlock_core (
  clk, rst, row_rsc_mgc_in_wire_d, col_rsc_mgc_in_wire_d, bit_in_rsc_mgc_in_wire_d,
      write_enable_rsc_mgc_in_wire_d, bits_out_rsc_mgc_out_stdreg_d, data_rsc_singleport_data_in,
      data_rsc_singleport_addr, data_rsc_singleport_re, data_rsc_singleport_we, data_rsc_singleport_data_out
);
  input clk;
  input rst;
  input [5:0] row_rsc_mgc_in_wire_d;
  input [6:0] col_rsc_mgc_in_wire_d;
  input bit_in_rsc_mgc_in_wire_d;
  input write_enable_rsc_mgc_in_wire_d;
  output [29:0] bits_out_rsc_mgc_out_stdreg_d;
  reg [29:0] bits_out_rsc_mgc_out_stdreg_d;
  output data_rsc_singleport_data_in;
  output [12:0] data_rsc_singleport_addr;
  output data_rsc_singleport_re;
  output data_rsc_singleport_we;
  input data_rsc_singleport_data_out;


  // Interconnect Declarations
  wire [5:0] fsm_output;
  reg [12:0] data_vinit_ndx_sva;
  reg if_nor_itm;
  reg [12:0] if_acc_1_itm;
  wire [13:0] nl_if_acc_1_itm;
  reg io_read_write_enable_rsc_d_svs_st;
  reg data_rsc_singleport_data_in_reg;
  wire and_4_rmff;


  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_MemBlock_core_fsm_inst_st_data_vinit_1_tr0;
  assign nl_MemBlock_core_fsm_inst_st_data_vinit_1_tr0 = ~ if_nor_itm;
  MemBlock_core_fsm MemBlock_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .st_data_vinit_1_tr0(nl_MemBlock_core_fsm_inst_st_data_vinit_1_tr0)
    );
  assign and_4_rmff = bit_in_rsc_mgc_in_wire_d & (fsm_output[3]);
  assign data_rsc_singleport_data_in = and_4_rmff;
  assign data_rsc_singleport_addr = MUX_v_13_2_2({data_vinit_ndx_sva , ({1'b0 , (conv_s2u_7_10(({2'b10
      , (col_rsc_mgc_in_wire_d[6:2])}) + conv_u2s_6_7(~ row_rsc_mgc_in_wire_d)) +
      ({row_rsc_mgc_in_wire_d , 4'b1})) , (col_rsc_mgc_in_wire_d[1:0])})}, fsm_output[3]);
  assign data_rsc_singleport_re = ~((fsm_output[3]) & (~ write_enable_rsc_mgc_in_wire_d));
  assign data_rsc_singleport_we = ~(((fsm_output[3]) & write_enable_rsc_mgc_in_wire_d)
      | (fsm_output[1]));
  always @(posedge clk) begin
    if ( rst ) begin
      data_rsc_singleport_data_in_reg <= 1'b0;
      bits_out_rsc_mgc_out_stdreg_d <= 30'b0;
      data_vinit_ndx_sva <= 13'b1001010111111;
      if_nor_itm <= 1'b0;
      if_acc_1_itm <= 13'b0;
      io_read_write_enable_rsc_d_svs_st <= 1'b0;
    end
    else begin
      data_rsc_singleport_data_in_reg <= and_4_rmff;
      bits_out_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({bits_out_rsc_mgc_out_stdreg_d
          , ({9'b0 , (MUX_s_1_2_2({data_rsc_singleport_data_out , data_rsc_singleport_data_in_reg},
          io_read_write_enable_rsc_d_svs_st)) , 20'b0})}, fsm_output[4]);
      data_vinit_ndx_sva <= MUX_v_13_2_2({data_vinit_ndx_sva , if_acc_1_itm}, fsm_output[2]);
      if_nor_itm <= ~((data_vinit_ndx_sva[12]) | (data_vinit_ndx_sva[11]) | (data_vinit_ndx_sva[10])
          | (data_vinit_ndx_sva[9]) | (data_vinit_ndx_sva[8]) | (data_vinit_ndx_sva[7])
          | (data_vinit_ndx_sva[6]) | (data_vinit_ndx_sva[5]) | (data_vinit_ndx_sva[4])
          | (data_vinit_ndx_sva[3]) | (data_vinit_ndx_sva[2]) | (data_vinit_ndx_sva[1])
          | (data_vinit_ndx_sva[0]));
      if_acc_1_itm <= nl_if_acc_1_itm[12:0];
      io_read_write_enable_rsc_d_svs_st <= write_enable_rsc_mgc_in_wire_d;
    end
  end
  assign nl_if_acc_1_itm  = data_vinit_ndx_sva + 13'b1111111111111;

  function [12:0] MUX_v_13_2_2;
    input [25:0] inputs;
    input [0:0] sel;
    reg [12:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[25:13];
      end
      1'b1 : begin
        result = inputs[12:0];
      end
      default : begin
        result = inputs[25:13];
      end
    endcase
    MUX_v_13_2_2 = result;
  end
  endfunction


  function [29:0] MUX_v_30_2_2;
    input [59:0] inputs;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[59:30];
      end
      1'b1 : begin
        result = inputs[29:0];
      end
      default : begin
        result = inputs[59:30];
      end
    endcase
    MUX_v_30_2_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function  [9:0] conv_s2u_7_10 ;
    input signed [6:0]  vector ;
  begin
    conv_s2u_7_10 = {{3{vector[6]}}, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2s_6_7 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    MemBlock
//  Generated from file(s):
//    2) $PROJECT_HOME/src2/NewMemory.cpp
//    6) $MGC_HOME/shared/include/ac_int.h
// ------------------------------------------------------------------


module MemBlock (
  row_rsc_z, col_rsc_z, bit_in_rsc_z, write_enable_rsc_z, bits_out_rsc_z, clk, rst
);
  input [5:0] row_rsc_z;
  input [6:0] col_rsc_z;
  input bit_in_rsc_z;
  input write_enable_rsc_z;
  output [29:0] bits_out_rsc_z;
  input clk;
  input rst;


  // Interconnect Declarations
  wire [5:0] row_rsc_mgc_in_wire_d;
  wire [6:0] col_rsc_mgc_in_wire_d;
  wire bit_in_rsc_mgc_in_wire_d;
  wire write_enable_rsc_mgc_in_wire_d;
  wire [29:0] bits_out_rsc_mgc_out_stdreg_d;
  wire data_rsc_singleport_data_in;
  wire [12:0] data_rsc_singleport_addr;
  wire data_rsc_singleport_re;
  wire data_rsc_singleport_we;
  wire data_rsc_singleport_data_out;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(6)) row_rsc_mgc_in_wire (
      .d(row_rsc_mgc_in_wire_d),
      .z(row_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(7)) col_rsc_mgc_in_wire (
      .d(col_rsc_mgc_in_wire_d),
      .z(col_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(1)) bit_in_rsc_mgc_in_wire (
      .d(bit_in_rsc_mgc_in_wire_d),
      .z(bit_in_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(1)) write_enable_rsc_mgc_in_wire (
      .d(write_enable_rsc_mgc_in_wire_d),
      .z(write_enable_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(30)) bits_out_rsc_mgc_out_stdreg (
      .d(bits_out_rsc_mgc_out_stdreg_d),
      .z(bits_out_rsc_z)
    );
  singleport_ram_be #(.ram_id(6),
  .words(4800),
  .width(1),
  .addr_width(13),
  .a_reset_active(0),
  .s_reset_active(1),
  .enable_active(0),
  .re_active(0),
  .we_active(0),
  .num_byte_enables(1),
  .clock_edge(1),
  .num_input_registers(1),
  .num_output_registers(0),
  .no_of_singleport_readwrite_port(1)) data_rsc_singleport (
      .data_in(data_rsc_singleport_data_in),
      .addr(data_rsc_singleport_addr),
      .re(data_rsc_singleport_re),
      .we(data_rsc_singleport_we),
      .data_out(data_rsc_singleport_data_out),
      .clk(clk),
      .a_rst(1'b1),
      .s_rst(rst),
      .en(1'b0)
    );
  MemBlock_core MemBlock_core_inst (
      .clk(clk),
      .rst(rst),
      .row_rsc_mgc_in_wire_d(row_rsc_mgc_in_wire_d),
      .col_rsc_mgc_in_wire_d(col_rsc_mgc_in_wire_d),
      .bit_in_rsc_mgc_in_wire_d(bit_in_rsc_mgc_in_wire_d),
      .write_enable_rsc_mgc_in_wire_d(write_enable_rsc_mgc_in_wire_d),
      .bits_out_rsc_mgc_out_stdreg_d(bits_out_rsc_mgc_out_stdreg_d),
      .data_rsc_singleport_data_in(data_rsc_singleport_data_in),
      .data_rsc_singleport_addr(data_rsc_singleport_addr),
      .data_rsc_singleport_re(data_rsc_singleport_re),
      .data_rsc_singleport_we(data_rsc_singleport_we),
      .data_rsc_singleport_data_out(data_rsc_singleport_data_out)
    );
endmodule



