-------------------------------------------------------------------------------
-- Title      : negative disparity rom
-- Project    : 
-------------------------------------------------------------------------------
-- File       : enc_8_10_rdn.vhd
-- Author     : amr  <amr@laptop>
-- Company    : 
-- Created    : 2014-10-15
-- Last update: 2014-10-15
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: a negative disparity rom
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-10-15  1.0      amr	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity enc_8_10_rdn is
  
  port (
    clk : in std_logic;
    address      : in  std_logic_vector(7 downto 0);
    encoded_data : out std_logic_vector(9 downto 0));

end enc_8_10_rdn;


architecture behav of enc_8_10_rdn is

  type t_ROM is array (0 to 255) of std_logic_vector(9 downto 0);
  signal aROM : t_ROM := (others=>(others=>'0'));
  signal vROM_reg : std_logic_vector(9 downto 0);
  
begin  -- behav

  clk_pr : process(clk) is
  begin
    if rising_edge(clk) then
      vROM_reg <= aROM(to_integer(unsigned(address)));
    end if;
  end process;
  

end behav;
