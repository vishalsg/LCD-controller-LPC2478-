//
// This is a simple test bench for the 24xx lcd controller
// 

`timescale 1ns/10ps

`include "lcdifproj.sv"

package tl_pkg;

`include "uvm.sv"

import uvm_pkg::*;




`include "tbregsproj.svp"

`include "tbdefproj.svp"

`include "lcduvmproj.svp"


endpackage : tl_pkg



module top();

import uvm_pkg::*;
import tl_pkg::*;

AHBIF TB();

AHBIF Q0();
MEMIF R0();
MEMIF S0();
RAM128IF cpal0();
RAM256IF crsr0();

LCDOUT lcdout0();

AHBIF Q1();
MEMIF R1();
MEMIF S1();
RAM128IF cpal1();
RAM256IF crsr1();

LCDOUT lcdout1();

AHBIF Q2();
MEMIF R2();
MEMIF S2();
RAM128IF cpal2();
RAM256IF crsr2();

LCDOUT lcdout2();

AHBIF Q3();
MEMIF R3();
MEMIF S3();
RAM128IF cpal3();
RAM256IF crsr3();

LCDOUT lcdout3();


initial begin
Q0.HRESET=0;
Q1.HRESET=0;
Q2.HRESET=0;
Q3.HRESET=0;
TB.HRESET=0;
Q0.HCLK=1;
Q1.HCLK=1;
Q2.HCLK=1;
Q3.HCLK=1;
TB.HCLK=1;
forever #5 begin
  Q0.HCLK = ~ Q0.HCLK;
  Q1.HCLK = ~ Q1.HCLK;
  Q2.HCLK = ~ Q2.HCLK;
  Q3.HCLK = ~ Q3.HCLK;
  TB.HCLK = ~ TB.HCLK;
end
end

default clocking CB @(posedge(Q0.HCLK));


endclocking : CB

initial begin
//  $dumpfile("lcd.vcd");
//  $dumpvars(5,top.arb0);
//  $dumpvars(7,top.l0);
//  $dumpvars(9,top.l0.lcd_timh);
//    $dumpvars(4,top);
//  $dumpvars(9,top);
  ##10000000;
//  ##1000000;
  $display("\n\n\n============= Time Out reached ==================\n\n\n");
  $finish;
end

arbitrator arb0(Q0.HCLK,Q0.HRESET,Q0.AHBMin,Q1.AHBMin,Q2.AHBMin,Q3.AHBMin,TB.AHBMin,
    Q0.AHBSout,Q1.AHBSout,Q2.AHBSout,Q3.AHBSout,TB.AHBSout);

lcd l0(Q0.AHBCLKS, Q0.AHBM, Q0.AHBS, R0.F0, S0.F0,cpal0.R0,crsr0.R0,lcdout0.O0);

mem128x32 palmem0(Q0.HCLK,cpal0.write,cpal0.waddr,cpal0.wdata,
    cpal0.raddr,cpal0.rdata,cpal0.raddr1,cpal0.rdata1);
    
mem256x32 cursmem0(Q0.HCLK,crsr0.write,crsr0.waddr,crsr0.wdata,
    crsr0.raddr,crsr0.rdata,crsr0.raddr1,crsr0.rdata1);

mem32x32 fifoMem00(Q0.HCLK,R0.f0_waddr,R0.f0_wdata,R0.f0_write,
    R0.f0_raddr,R0.f0_rdata);

mem32x32 fifoMem01(Q0.HCLK,S0.f0_waddr,S0.f0_wdata,S0.f0_write,
    S0.f0_raddr,S0.f0_rdata);

lcd l1(Q1.AHBCLKS, Q1.AHBM, Q1.AHBS, R1.F0, S1.F0,cpal1.R0,crsr1.R0,lcdout1.O0);

mem128x32 palmem1(Q1.HCLK,cpal1.write,cpal1.waddr,cpal1.wdata,
    cpal1.raddr,cpal1.rdata,cpal1.raddr1,cpal1.rdata1);
    
mem256x32 cursmem1(Q1.HCLK,crsr1.write,crsr1.waddr,crsr1.wdata,
    crsr1.raddr,crsr1.rdata,crsr1.raddr1,crsr1.rdata1);

mem32x32 fifoMem10(Q1.HCLK,R1.f0_waddr,R1.f0_wdata,R1.f0_write,
    R1.f0_raddr,R1.f0_rdata);

mem32x32 fifoMem11(Q1.HCLK,S1.f0_waddr,S1.f0_wdata,S1.f0_write,
    S1.f0_raddr,S1.f0_rdata);

lcd l2(Q2.AHBCLKS, Q2.AHBM, Q2.AHBS, R2.F0, S2.F0,cpal2.R0,crsr2.R0,lcdout2.O0);

mem128x32 palmem2(Q2.HCLK,cpal2.write,cpal2.waddr,cpal2.wdata,
    cpal2.raddr,cpal2.rdata,cpal2.raddr1,cpal2.rdata1);
    
mem256x32 cursmem2(Q2.HCLK,crsr2.write,crsr2.waddr,crsr2.wdata,
    crsr2.raddr,crsr2.rdata,crsr2.raddr1,crsr2.rdata1);

mem32x32 fifoMem20(Q2.HCLK,R2.f0_waddr,R2.f0_wdata,R2.f0_write,
    R2.f0_raddr,R2.f0_rdata);

mem32x32 fifoMem21(Q2.HCLK,S2.f0_waddr,S2.f0_wdata,S2.f0_write,
    S2.f0_raddr,S2.f0_rdata);

lcd l3(Q3.AHBCLKS, Q3.AHBM, Q3.AHBS, R3.F0, S3.F0,cpal3.R0,crsr3.R0,lcdout3.O0);

mem128x32 palmem3(Q3.HCLK,cpal3.write,cpal3.waddr,cpal3.wdata,
    cpal3.raddr,cpal3.rdata,cpal3.raddr1,cpal3.rdata1);
    
mem256x32 cursmem3(Q3.HCLK,crsr3.write,crsr3.waddr,crsr3.wdata,
    crsr3.raddr,crsr3.rdata,crsr3.raddr1,crsr3.rdata1);

mem32x32 fifoMem30(Q3.HCLK,R3.f0_waddr,R3.f0_wdata,R3.f0_write,
    R3.f0_raddr,R3.f0_rdata);

mem32x32 fifoMem31(Q1.HCLK,S3.f0_waddr,S3.f0_wdata,S3.f0_write,
    S3.f0_raddr,S3.f0_rdata);

initial
  begin
    //Q0.mHGRANT=0;
    //Q1.mHGRANT=0;
    //Q2.mHGRANT=0;
    //Q3.mHGRANT=0;
    //TB.mHGRANT=0;
    //Q0.mHBUSREQ=0;
    //Q1.mHBUSREQ=0;
    //Q2.mHBUSREQ=0;
    //Q3.mHBUSREQ=0;
    //TB.mHBUSREQ=0;
    Q0.HRESET=1;
    Q1.HRESET=1;
    Q2.HRESET=1;
    Q3.HRESET=1;
    TB.HRESET=1;
    repeat(3) @(posedge(Q0.HCLK)) #1;
    Q0.HRESET=0;
    Q1.HRESET=0;
    Q2.HRESET=0;
    Q3.HRESET=0;
    TB.HRESET=0;
    
  end

initial
  begin
    uvm_config_db #(virtual  AHBIF)::set(null, "uvm_test_top", 
      "ahbif0"  , Q0);
    uvm_config_db #(virtual LCDOUT)::set(null, "uvm_test_top", 
      "lcdout0" , lcdout0);
    uvm_config_db #(virtual  AHBIF)::set(null, "uvm_test_top", 
      "ahbif1"  , Q1);
    uvm_config_db #(virtual LCDOUT)::set(null, "uvm_test_top", 
      "lcdout1" , lcdout1);
    uvm_config_db #(virtual  AHBIF)::set(null, "uvm_test_top", 
      "ahbif2"  , Q2);
    uvm_config_db #(virtual LCDOUT)::set(null, "uvm_test_top", 
      "lcdout2" , lcdout2);
    uvm_config_db #(virtual  AHBIF)::set(null, "uvm_test_top", 
      "ahbif3"  , Q3);
    uvm_config_db #(virtual LCDOUT)::set(null, "uvm_test_top", 
      "lcdout3" , lcdout3);
    uvm_config_db #(virtual AHBIF)::set(null, "uvm_test_top", 
      "test_bench" , TB);
    run_test("l0_test");
    ##100;
    $finish;
  end



endmodule : top

`include "arbitrator.sv"
`include "lcd.sv"
`include "mem32x32.sv"
`include "mem128x32.sv"
`include "mem256x32.sv"

