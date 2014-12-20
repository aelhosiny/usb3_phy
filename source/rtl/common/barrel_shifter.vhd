-------------------------------------------------------------------------------
-- Title      : generic barrel shifter
-- Project    : 
-------------------------------------------------------------------------------
-- File       : barrel_shifter.vhd
-- Author     : amr  <amr@amr-laptop>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 20-12-2014
-- Last update: 20-12-2014
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 Ensphere Solutions & Silicon Vision
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 20-12-2014  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.basic_functions.all;

entity barrel_shifter is
  
  generic (
    width     : integer   := 8;         -- input width
    direction : std_logic := '1');      -- '1' right, '0' left

  port (
    din          : in  std_logic_vector(width-1 downto 0);  -- input data to be shifter
    shift_amount : in  std_logic_vector(log2(width)-1 downto 0);  -- shift amount
    dout         : out std_logic_vector(width-1 downto 0));

end entity barrel_shifter;


architecture behav of barrel_shifter is

  type   t_stage is array (0 to log2(width)) of std_logic_vector(width-1 downto 0);
  signal stages0_a : t_stage := (others => (others => '0'));
  signal stages1_a : t_stage := (others => (others => '0'));
  signal sel       : std_logic_vector(shift_amount'length-1 downto 0);
  
begin  -- architecture behav

  sel <= shift_amount;

  left_shift : if (direction = '0') generate
    
    stages0_a(0) <= din;
    stages1_a(0) <= din(din'length-2 downto 0) & '0';

    stages : for i in 1 to log2(width) generate
      stages0_a(i)                      <= stages1_a(i-1) when sel(i-1) = '1' else stages0_a(i-1);
      stages1_a(i)(2**i-1 downto 0)     <= (others => '0');
      stages1_a(i)(width-1 downto 2**i) <= stages0_a(i)(width-1-2**i downto 0);
    end generate stages;
    dout <= stages0_a(log2(width));
  end generate;


  right_shift : if (direction = '1') generate
    
    stages0_a(0) <= din;
    stages1_a(0) <= '0' & din(din'length-1 downto 1);

    stages : for i in 1 to log2(width) generate
      stages0_a(i)                            <= stages1_a(i-1) when sel(i-1) = '1' else stages0_a(i-1);
      stages1_a(i)(width-1 downto width-2**i) <= (others => '0');
      stages1_a(i)(width-2**i-1 downto 0)     <= stages0_a(i)(width-1 downto 2**i);
    end generate stages;
    dout <= stages0_a(log2(width));
  end generate;
  
end architecture behav;
