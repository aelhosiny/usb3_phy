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
    -- reinitiate scrambelr LFSR
    init_lfsr    : out std_logic;
    -- enable LFSR advance    
    advance_lfsr : in  std_logic;
    -- XOR input data with LFSR out    
    xor_data     : in  std_logic;
    -- output data valid flag
    validout     : out std_logic
    );

end entity scrambler_cntrl_gen2;
