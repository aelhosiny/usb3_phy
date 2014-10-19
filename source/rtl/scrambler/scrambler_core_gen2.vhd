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

  signal   lfsr_reg      : std_logic_vector(22 downto 0) := x"FFFF";
  type     lfsr_t is array (0 to 8) of std_logic_vector(22 downto 0);
  signal   lfsr_a        : lfsr_t;
  signal   din_int       : std_logic_vector(7 downto 0);
  signal   dout_nxt      : std_logic_vector(7 downto 0);
  signal   dout_reg      : std_logic_vector(7 downto 0)  := (others => '0');
  constant data_mirror_c : std_logic                     := '0';
  
begin  -- behav

  mirror_din1 : if data_mirror_c = '1' generate
    mr_lp : for i in 0 to 7 generate
      din_int(i) <= din(7-i);
    end generate mr_lp;
  end generate mirror_din1;
  mirror_din2 : if data_mirror_c = '0' generate
    din_int <= din;
  end generate mirror_din2;

  lfsr_a(0) <= lfsr_reg;

  lfsr_states_o : for i in 1 to 8 generate
    lfsr_states_i : for j in 0 to 22 generate
      xor_regs1 : if (j = 0 or j = 2 or j = 5 or j = 8 or j=16 or j=21) generate
        lfsr_a(i)(0) <= lfsr_a(i-1)(22);
        lfsr_a(i)(2) <= lfsr_a(i-1)(22) xor lfsr_a(i-1)(1);
        lfsr_a(i)(5) <= lfsr_a(i-1)(22) xor lfsr_a(i-1)(4);
        lfsr_a(i)(8) <= lfsr_a(i-1)(22) xor lfsr_a(i-1)(7);
        lfsr_a(i)(16) <= lfsr_a(i-1)(22) xor lfsr_a(i-1)(15);
        lfsr_a(i)(21) <= lfsr_a(i-1)(22) xor lfsr_a(i-1)(20);
      end generate xor_regs1;
      xor_regs2 : if (j /= 0 and j /= 2 and j /= 4 and j /= 8 and j/=16 and j/=21) generate
        lfsr_a(i)(j) <= lfsr_a(i-1)(j-1);
      end generate xor_regs2;
    end generate lfsr_states_i;
    dout_nxt(i-1) <= lfsr_a(i)(22) xor din_int(i-1);
  end generate lfsr_states_o;


  -- purpose: clock process
  -- type   : combinational
  -- inputs : clk
  -- outputs: lfsr_reg
  clk_pr : process (clk)
  begin  -- process clk_pr
    if rising_edge(clk) then
      if rst = '1' then
        lfsr_reg <= x"FFFF";
      else
        if init_lfsr = '1' then
          lfsr_reg <= x"FFFF";
        elsif advance_lfsr = '1' then
          lfsr_reg <= lfsr_a(8);
        end if;
      end if;
    end if;
  end process clk_pr;

  -- purpose: implement output data register
  -- type   : combinational
  -- inputs : clk
  -- outputs: dout_reg
  dout_Reg_pr : process (clk)
  begin  -- process dout_Reg_pr
    if rising_edge(clk) then
      if xor_data = '1' then
        dout_reg <= dout_nxt;
      else
        dout_reg <= din_int;
      end if;
    end if;
  end process dout_Reg_pr;

  dout <= dout_reg;
  

end behav;
