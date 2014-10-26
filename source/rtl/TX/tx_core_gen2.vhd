-------------------------------------------------------------------------------
-- Title      : GEN2 TX top
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tx_core_gen1.vhd
-- Author     : amr  <amr@laptop>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 24-10-2014
-- Last update: 26-10-2014
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 Ensphere Solutions & Silicon Vision
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 24-10-2014  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.usb3_pkg.all;

entity tx_core_gen2 is

  port (
    -- scrambler clock (byte processing time)
    clk       : in  std_logic;
    -- synchronous active high reset    
    rst       : in  std_logic;
    -- 4-bit block header
    header : in std_logic_vector(3 downto 0);
    -- Input data / K code
    din       : in  std_logic_vector(7 downto 0);
    -- The symbol index within a block (0 -> 15)
    symbol_index       : in  std_logic_vector(3 downto 0);
    -- The symbol type ex:(SKP, TS1, etc..) the opcodes are defined in the package
    symbol_type      : in  std_logic_vector(op_gen2_width_c-1 downto 0);
    -- data valid input flag
    validin   : in  std_logic;
    -- reinitiate scrambelr LFSR
    init_lfsr : in  std_logic;
    -- TX output data to serializer
    dout      : out std_logic_vector(9 downto 0);
    -- valid data out flag to SerDes
    validout  : out std_logic
    );

end entity tx_core_gen2;


architecture behav of tx_core_gen2 is

 
  
begin  -- architecture behav




end architecture behav;
