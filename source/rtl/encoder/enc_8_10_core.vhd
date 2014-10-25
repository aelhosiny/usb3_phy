-------------------------------------------------------------------------------
-- Title      : encoder 8b/10 core
-- Project    : 
-------------------------------------------------------------------------------
-- File       : enc_8_10_core.vhd
-- Author     : amr  <amr@laptop>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 21-10-2014
-- Last update: 24-10-2014
-- Platform   : RTL Compiler, Design Compiler, ModelSim, NC-Sim
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
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

entity enc_8_10_core is
  
  port (
    clk          : in  std_logic;
    rst          : in  std_logic;
    enable       : in  std_logic;
    KnD          : in  std_logic;
    din          : in  std_logic_vector(7 downto 0);
    validout     : out std_logic;
    encoded_data : out std_logic_vector(9 downto 0)
    );

end enc_8_10_core;

architecture behav of enc_8_10_core is

  signal rom_dout        : std_logic_vector(19 downto 0);
  signal dout_selected   : std_logic_vector(9 downto 0);
  signal count_oc        : std_logic_vector(3 downto 0);
  signal count_zc        : std_logic_vector(3 downto 0);
  signal oc_m_zc         : signed(3 downto 0);
  signal sel_neg_dsp_nxt : std_logic;
  signal sel_neg_dsp     : std_logic                    := '0';
  signal enable_d        : std_logic                    := '0';
  signal din_ext         : std_logic_vector(8 downto 0);
  signal dout_reg        : std_logic_vector(9 downto 0) := (others => '0');
  signal vldout_reg      : std_logic                    := '0';

  component enc_8_10_rom2p is
    port (
      clk       : in  std_logic;
      address_a : in  std_logic_vector(8 downto 0);
      address_b : in  std_logic_vector(8 downto 0) := (others => '0');
      rde_a     : in  std_logic;
      rde_b     : in  std_logic                    := '0';
      dout_a    : out std_logic_vector(19 downto 0);
      dout_b    : out std_logic_vector(19 downto 0));
  end component enc_8_10_rom2p;

  --component enc_8_10_rom is
  --  port (
  --    clk          : in  std_logic;
  --    address      : in  std_logic_vector(7 downto 0);
  --    rde          : in  std_logic;
  --    encoded_data : out std_logic_vector(19 downto 0));
  --end component enc_8_10_rom;

  component oz_count is
    generic (
      width : integer);
    port (
      din       : in  std_logic_vector(width-1 downto 0);
      ones_cnt  : out std_logic_vector(log2(width)-1 downto 0);
      zeros_cnt : out std_logic_vector(log2(width)-1 downto 0));
  end component oz_count;
  
begin  -- architecture behav


  din_ext <= KnD & din;

  --enc_8_10_rom_1 : enc_8_10_rom
  --  port map (
  --    clk          => clk,              -- [in  std_logic]
  --    address      => din,              -- [in  std_logic_vector(7 downto 0)]
  --    rde          => enable,           -- [in  std_logic]
  --    encoded_data => rom_dout);        -- [out std_logic_vector(19 downto 0)]

  enc_8_10_rom2p_1 : enc_8_10_rom2p
    port map (
      clk       => clk,                 -- [in  std_logic]
      address_a => din_ext,             -- [in  std_logic_vector(8 downto 0)]
      --address_b => address_b,           -- [in  std_logic_vector(8 downto 0)]
      rde_a     => enable,              -- [in  std_logic]
      --rde_b     => rde_b,               -- [in  std_logic]
      dout_a    => rom_dout,            -- [out std_logic_vector(19 downto 0)]
      dout_b    => open);               -- [out std_logic_vector(19 downto 0)]

  
  clk_pr : process (clk) is
  begin  -- process clk_pr
    if (rising_edge(clk)) then
      if (rst = '1') then
        enable_d    <= '0';
        sel_neg_dsp <= '0';
        vldout_reg  <= '0';
      else
        enable_d   <= enable;
        vldout_reg <= enable_d;
        if (enable_d = '1') then
          sel_neg_dsp <= sel_neg_dsp_nxt;
        end if;
      end if;

    end if;
  end process clk_pr;

  clk_pr2 : process (clk) is
  begin  -- process clk_pr2
    if (rising_edge(clk)) then
      if (enable_d = '1') then
        dout_reg <= dout_selected;
      end if;
    end if;
  end process clk_pr2;

  oz_count_1 : oz_count
    generic map (
      width => 10)                      -- [integer]
    port map (
      din       => dout_selected,  -- [in  std_logic_vector(width-1 downto 0)]
      ones_cnt  => count_oc,  -- [out std_logic_vector(log2(width)-1 downto 0)]
      zeros_cnt => count_zc);  -- [out std_logic_vector(log2(width)-1 downto 0)]

  oc_m_zc         <= signed(count_oc) - signed(count_zc);
  sel_neg_dsp_nxt <= oc_m_zc(3);

  dout_selected <= rom_dout(9 downto 0) when sel_neg_dsp = '0' else rom_dout(19 downto 10);

  encoded_data <= dout_reg;
  validout     <= vldout_reg;
  
end architecture behav;
