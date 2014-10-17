-------------------------------------------------------------------------------
-- Title      : gen1 scrambler
-- Project    : 
-------------------------------------------------------------------------------
-- File       : scrambler_core_gen2.vhd
-- Author     : amr  <amr@laptop>
-- Company    : 
-- Created    : 2014-10-17
-- Last update: 2014-10-18
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: scrambler for GEN2 PHY
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-10-17  1.0      amr     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity scrambler_core_gen2 is
  
  port (
    clk          : in  std_logic;
    -- scrambler clock
    rst          : in  std_logic;
    -- synchronous active high reset
    advance_lfsr : in  std_logic;
    -- enable LFSR advance
    xor_data     : in  std_logic;
    -- XOR input data with LFSR out
    init_lfsr    : in  std_logic;
    -- Initialize the LFSR
    din          : in  std_logic_vector(7 downto 0);
    -- Input data byte
    dout         : out std_logic_vector(7 downto 0)
    -- Scrambled output
    );

end scrambler_core_gen2;

architecture behav of scrambler_core_gen2 is

begin  -- behav



end behav;
