-------------------------------------------------------------------------------
-- Title      : Gen2 scrambler controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : scrambler_cntrl_gen2.vhd
-- Author     :   <aelhosiny@tiger.eg.si-vision.com>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 26-10-2014
-- Last update: 26-10-2014
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 Ensphere Solutions & Silicon Vision
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 26-10-2014  1.0      aelhosiny       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.usb3_pkg.all;

entity scrambler_cntrl_gen2 is

  port (
    -- scrambler clock (byte processing time)
    clk          : in  std_logic;
    -- synchronous active high reset    
    rst          : in  std_logic;
    -- The symbol index within a block (0 -> 15)
    symbol_index : in  std_logic_vector(3 downto 0);
    -- The symbol type ex:(SKP, TS1, etc..) the opcodes are defined in the package
    symbol_type  : in  std_logic_vector(op_gen2_width_c-1 downto 0);
    -- data valid input flag
    validin      : in  std_logic;
    -- DC balance operation   
    DC_balance   : in  std_logic;
    -- reinitiate scrambelr LFSR
    init_lfsr    : out std_logic;
    -- enable LFSR advance    
    advance_lfsr : out std_logic;
    -- XOR input data with LFSR out    
    xor_data     : out std_logic
    );

end entity scrambler_cntrl_gen2;


architecture behav of scrambler_cntrl_gen2 is

  signal scrm_cntrl_s   : std_logic_vector(1 downto 0);
  
begin  -- architecture behav

  scrm_cntrl_s <= "10" when
                  (unsigned(symbol_index) = 0 and
                   (symbol_type = op_TS1_gen2 or symbol_type = op_TS2_gen2 or symbol_type = op_TSEQ_gen2)) or
                  ((unsigned(symbol_index) = 14 or unsigned(symbol_index) = 15) and DC_balance = '1' and
                   (symbol_type = op_TS1_gen2 or symbol_type = op_TS2_gen2 or symbol_type = op_TSEQ_gen2)) or
                  (symbol_type = op_SDS_gen2)
                  else
                  "00" when
                  (symbol_type = op_SKP_gen2 or symbol_type = op_SKPEND_gen2 or symbol_type = op_SYNC_gen2)
                  else
                  "11";
  advance_lfsr <= scrm_cntrl_s(1) and validin;
  xor_data     <= scrm_cntrl_s(0) and validin;

  init_lfsr <= '1' when (symbol_type = op_SYNC_gen2 and unsigned(symbol_index) = 15) else '0';

end architecture behav;
