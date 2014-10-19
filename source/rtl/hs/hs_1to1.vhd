-------------------------------------------------------------------------------
-- Title      : handshaking 8bit to 8bit
-- Project    : 
-------------------------------------------------------------------------------
-- File       : hs_8to8.vhd
-- Author     : amr  <amr@laptop>
-- Company    : 
-- Created    : 2014-10-18
-- Last update: 2014-10-18
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-10-18  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity hs_1to1 is
  
  generic (
    width : integer := 8);

  port (
    clk     : in  std_logic;
    rst     : in  std_logic;
    validin : in  std_logic;
    din     : in  std_logic_vector(width-1 downto 0);
    ackin   : in  std_logic;
    ackout  : out std_logic;
    vldout  : out std_logic;
    dout    : out std_logic_vector(width-1 downto 0));

end hs_1to1;

architecture behav of hs_1to1 is

  signal ackout_nxt  : std_logic;
  signal ackout_reg  : std_logic                          := '0';
  signal vldout_nxt  : std_logic;
  signal vldout_reg  : std_logic                          := '0';
  signal update_dreg : std_logic;
  signal dout_reg    : std_logic_vector(width-1 downto 0) := (others => '0');
  
begin  -- behav

  logic_pr : process(ackin, ackout_reg, validin, vldout_reg)
  begin  -- process logic_pr
    vldout_nxt  <= vldout_reg;
    ackout_nxt  <= '0';
    update_dreg <= '0';

    if (validin = '1' and vldout_reg = '0') or (validin = '1' and ackin = '1') then
      vldout_nxt  <= '1';
      update_dreg <= '1';
      ackout_nxt  <= '1';
    elsif (validin = '0' and ackin = '1') then
      vldout_nxt  <= '0';
      update_dreg <= '1';
    end if;
    
  end process logic_pr;

  -- purpose: clock process
  -- type   : combinational
  -- inputs : clk
  -- outputs: dout, vldout
  clk_pr : process (clk)
  begin  -- process clk_pr
    if rising_edge(clk) then
      if update_dreg = '1' then
        dout_reg <= din;
      end if;
      if rst = '1' then
        vldout_reg <= '0';
        ackout_reg <= '0';
      else
        vldout_reg <= vldout_nxt;
        ackout_reg <= ackout_nxt;
      end if;
    end if;
  end process clk_pr;

  ackout <= ackout_reg;
  vldout <= vldout_reg;
  dout   <= dout_reg;
  
end behav;
