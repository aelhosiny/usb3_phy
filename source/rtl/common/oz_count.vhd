-------------------------------------------------------------------------------
-- Title      : zero & one count
-- Project    : 
-------------------------------------------------------------------------------
-- File       : oz_count.vhd
-- Author     : amr  <amr@laptop>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 21-10-2014
-- Last update: 21-10-2014
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: immediate '1' & '0' count
-------------------------------------------------------------------------------
-- Copyright (c) 2014 Ensphere Solutions & Silicon Vision
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 21-10-2014  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.usb3_pkg.all;

entity oz_count is
  
  generic (
    width : integer := 8);

  port (
    din          : in  std_logic_vector(width-1 downto 0);
    ones_cnt     : out std_logic_vector(log2(width)-1 downto 0);
    zeros_cnt    : out std_logic_vector(log2(width)-1 downto 0)
    );

end entity oz_count;

architecture behav of oz_count is

begin  -- architecture behav

  process(din)
    variable ones_v : unsigned(log2(width)-1 downto 0) := (others=>'0');
  begin
    ones_v := (others=>'0');
    for i in 0 to width-1 loop
      if (din(i)='1') then
        ones_v := ones_v + 1;
      end if;
    end loop;  -- i
    ones_cnt <= std_logic_vector(ones_v);
    zeros_cnt <= std_logic_vector((to_unsigned(din'length, log2(width))) - ones_v);
  end process;
  
end architecture behav;
