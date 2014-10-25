-------------------------------------------------------------------------------
-- Title      : GEN1 TX top
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tx_core_gen1.vhd
-- Author     : amr  <amr@laptop>
-- Company    : Ensphere Solutions & Silicon Vision
-- Created    : 24-10-2014
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
-- 24-10-2014  1.0      amr     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.usb3_pkg.all;

entity tx_core_gen1 is

  port (
    -- scrambler clock    
    clk       : in  std_logic;
    -- synchronous active high reset    
    rst       : in  std_logic;
    -- Input data / K code
    din       : in  std_logic_vector(7 downto 0);
    -- Kcode/Dcode
    KnD       : in  std_logic;
    -- Training sequence
    TSeq      : in  std_logic;
    -- data valid input flag
    validin   : in  std_logic;
    -- reinitiate scrambelr LFSR
    init_lfsr : in  std_logic;
    -- TX output data to serializer
    dout      : out std_logic_vector(9 downto 0);
    -- valid data out flag to SerDes
    validout  : out std_logic
    );

end entity tx_core_gen1;


architecture behav of tx_core_gen1 is

  component scrambler_core_gen1 is
    port (
      clk          : in  std_logic;
      rst          : in  std_logic;
      advance_lfsr : in  std_logic;
      xor_data     : in  std_logic;
      init_lfsr    : in  std_logic;
      validin      : in  std_logic;
      din          : in  std_logic_vector(7 downto 0);
      validout     : out std_logic;
      dout         : out std_logic_vector(7 downto 0));
  end component scrambler_core_gen1;

  component enc_8_10_core is
    port (
      clk          : in  std_logic;
      rst          : in  std_logic;
      enable       : in  std_logic;
      KnD          : in  std_logic;
      din          : in  std_logic_vector(7 downto 0);
      validout     : out std_logic;
      encoded_data : out std_logic_vector(9 downto 0));
  end component enc_8_10_core;

  signal enable_scrm_s   : std_logic;
  signal enable_enc_s    : std_logic;
  signal validin_shreg_s : std_logic_vector(2 downto 0);
  signal scrm_validin_s  : std_logic;
  signal scrm_validout_s : std_logic;
  signal scrm_dout_s     : std_logic_vector(7 downto 0);
  signal KnD_d_s         : std_logic := '0';
  
begin  -- architecture behav

  enable_scrm_s  <= validin and not(KnD) and not(TSeq);
  scrm_validin_s <= validin;
  enable_enc_s   <= scrm_validout_s;

  -- purpose: clock process
  -- type   : sequential
  -- inputs : clk, rst
  -- outputs: validin_shreg_s
  clk_pr : process (clk) is
  begin  -- process clk_pr
    if rising_edge(clk) then            -- rising clock edge
      if (rst = '1') then
        validin_shreg_s <= (others => '0');
        KnD_d_s         <= '0';
      else
        validin_shreg_s <= validin_shreg_s(validin_shreg_s'length-2 downto 0) & validin;
        KnD_d_s         <= KnD;
      end if;
    end if;
  end process clk_pr;

  scrambler_core_gen1_1 : scrambler_core_gen1
    port map (
      clk          => clk,              -- [in  std_logic]
      rst          => rst,              -- [in  std_logic]
      advance_lfsr => enable_scrm_s,    -- [in  std_logic]
      xor_data     => enable_scrm_s,    -- [in  std_logic]
      init_lfsr    => init_lfsr,        -- [in  std_logic]
      validin      => scrm_validin_s,
      din          => din,              -- [in  std_logic_vector(7 downto 0)]
      validout     => scrm_validout_s,
      dout         => scrm_dout_s);     -- [out std_logic_vector(7 downto 0)]

  enc_8_10_core_1 : enc_8_10_core
    port map (
      clk          => clk,              -- [in  std_logic]
      rst          => rst,              -- [in  std_logic]
      enable       => enable_enc_s,     -- [in  std_logic]
      KnD          => KnD_d_s,          -- [in  std_logic]
      din          => scrm_dout_s,      -- [in  std_logic_vector(7 downto 0)]
      validout     => validout,
      encoded_data => dout);            -- [out std_logic_vector(9 downto 0)]


end architecture behav;
