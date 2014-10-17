-------------------------------------------------------------------------------
-- Title      : negative disparity rom
-- Project    : 
-------------------------------------------------------------------------------
-- File       : enc_8_10.vhd
-- Author     : amr  <amr@laptop>
-- Company    : 
-- Created    : 2014-10-15
-- Last update: 2014-10-17
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: a negative disparity rom
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-10-15  1.0      amr     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity enc_8_10 is
  
  port (
    clk          : in  std_logic;
    address      : in  std_logic_vector(7 downto 0);
    rde          : in  std_logic;
    encoded_data : out std_logic_vector(19 downto 0));

end enc_8_10;


architecture behav of enc_8_10 is

  signal vROM_reg  : std_logic_vector(19 downto 0) := (others => '0');
  signal address_i : unsigned(7 downto 0);
  signal vROM_tmp  : std_logic_vector(19 downto 0);
  
begin  -- behav

  address_i    <= unsigned(address);
  encoded_data <= vROM_reg;

  clk_pr : process(clk) is
  begin
    if rising_edge(clk) then
      if rde = '1' then
        vROM_reg <= vROM_tmp;
      end if;
    end if;
  end process;

  process(address_i) is
  begin
    case to_integer(address_i) is
when 0 => vROM_tmp <= "10" & x"74" & "01" & x"8b";
when 1 => vROM_tmp <= "01" & x"d4" & "10" & x"2b";
when 2 => vROM_tmp <= "10" & x"d4" & "01" & x"2b";
when 3 => vROM_tmp <= "11" & x"1b" & "11" & x"14";
when 4 => vROM_tmp <= "11" & x"54" & "00" & x"ab";
when 5 => vROM_tmp <= "10" & x"9b" & "10" & x"94";
when 6 => vROM_tmp <= "01" & x"9b" & "01" & x"94";
when 7 => vROM_tmp <= "11" & x"8b" & "00" & x"74";
when 8 => vROM_tmp <= "11" & x"94" & "00" & x"6b";
when 9 => vROM_tmp <= "10" & x"5b" & "10" & x"54";
when 10 => vROM_tmp <= "01" & x"5b" & "01" & x"54";
when 11 => vROM_tmp <= "11" & x"4b" & "11" & x"44";
when 12 => vROM_tmp <= "00" & x"db" & "00" & x"d4";
when 13 => vROM_tmp <= "10" & x"cb" & "10" & x"c4";
when 14 => vROM_tmp <= "01" & x"cb" & "01" & x"c4";
when 15 => vROM_tmp <= "01" & x"74" & "10" & x"8b";
when 16 => vROM_tmp <= "01" & x"b4" & "10" & x"4b";
when 17 => vROM_tmp <= "10" & x"3b" & "10" & x"34";
when 18 => vROM_tmp <= "01" & x"3b" & "01" & x"34";
when 19 => vROM_tmp <= "11" & x"2b" & "11" & x"24";
when 20 => vROM_tmp <= "00" & x"bb" & "00" & x"b4";
when 21 => vROM_tmp <= "10" & x"ab" & "10" & x"a4";
when 22 => vROM_tmp <= "01" & x"ab" & "01" & x"a4";
when 23 => vROM_tmp <= "11" & x"a4" & "00" & x"5b";
when 24 => vROM_tmp <= "11" & x"34" & "00" & x"cb";
when 25 => vROM_tmp <= "10" & x"6b" & "10" & x"64";
when 26 => vROM_tmp <= "01" & x"6b" & "01" & x"64";
when 27 => vROM_tmp <= "11" & x"64" & "00" & x"9b";
when 28 => vROM_tmp <= "00" & x"eb" & "00" & x"e4";
when 29 => vROM_tmp <= "10" & x"e4" & "01" & x"1b";
when 30 => vROM_tmp <= "01" & x"e4" & "10" & x"1b";
when 31 => vROM_tmp <= "10" & x"b4" & "01" & x"4b";
when 32 => vROM_tmp <= "10" & x"79" & "01" & x"89";
when 33 => vROM_tmp <= "01" & x"d9" & "10" & x"29";
when 34 => vROM_tmp <= "10" & x"d9" & "01" & x"29";
when 35 => vROM_tmp <= "11" & x"19" & "11" & x"19";
when 36 => vROM_tmp <= "11" & x"59" & "00" & x"a9";
when 37 => vROM_tmp <= "10" & x"99" & "10" & x"99";
when 38 => vROM_tmp <= "01" & x"99" & "01" & x"99";
when 39 => vROM_tmp <= "11" & x"89" & "00" & x"79";
when 40 => vROM_tmp <= "11" & x"99" & "00" & x"69";
when 41 => vROM_tmp <= "10" & x"59" & "10" & x"59";
when 42 => vROM_tmp <= "01" & x"59" & "01" & x"59";
when 43 => vROM_tmp <= "11" & x"49" & "11" & x"49";
when 44 => vROM_tmp <= "00" & x"d9" & "00" & x"d9";
when 45 => vROM_tmp <= "10" & x"c9" & "10" & x"c9";
when 46 => vROM_tmp <= "01" & x"c9" & "01" & x"c9";
when 47 => vROM_tmp <= "01" & x"79" & "10" & x"89";
when 48 => vROM_tmp <= "01" & x"b9" & "10" & x"49";
when 49 => vROM_tmp <= "10" & x"39" & "10" & x"39";
when 50 => vROM_tmp <= "01" & x"39" & "01" & x"39";
when 51 => vROM_tmp <= "11" & x"29" & "11" & x"29";
when 52 => vROM_tmp <= "00" & x"b9" & "00" & x"b9";
when 53 => vROM_tmp <= "10" & x"a9" & "10" & x"a9";
when 54 => vROM_tmp <= "01" & x"a9" & "01" & x"a9";
when 55 => vROM_tmp <= "11" & x"a9" & "00" & x"59";
when 56 => vROM_tmp <= "11" & x"39" & "00" & x"c9";
when 57 => vROM_tmp <= "10" & x"69" & "10" & x"69";
when 58 => vROM_tmp <= "01" & x"69" & "01" & x"69";
when 59 => vROM_tmp <= "11" & x"69" & "00" & x"99";
when 60 => vROM_tmp <= "00" & x"e9" & "00" & x"e9";
when 61 => vROM_tmp <= "10" & x"e9" & "01" & x"19";
when 62 => vROM_tmp <= "01" & x"e9" & "10" & x"19";
when 63 => vROM_tmp <= "10" & x"b9" & "01" & x"49";
when 64 => vROM_tmp <= "10" & x"75" & "01" & x"85";
when 65 => vROM_tmp <= "01" & x"d5" & "10" & x"25";
when 66 => vROM_tmp <= "10" & x"d5" & "01" & x"25";
when 67 => vROM_tmp <= "11" & x"15" & "11" & x"15";
when 68 => vROM_tmp <= "11" & x"55" & "00" & x"a5";
when 69 => vROM_tmp <= "10" & x"95" & "10" & x"95";
when 70 => vROM_tmp <= "01" & x"95" & "01" & x"95";
when 71 => vROM_tmp <= "11" & x"85" & "00" & x"75";
when 72 => vROM_tmp <= "11" & x"95" & "00" & x"65";
when 73 => vROM_tmp <= "10" & x"55" & "10" & x"55";
when 74 => vROM_tmp <= "01" & x"55" & "01" & x"55";
when 75 => vROM_tmp <= "11" & x"45" & "11" & x"45";
when 76 => vROM_tmp <= "00" & x"d5" & "00" & x"d5";
when 77 => vROM_tmp <= "10" & x"c5" & "10" & x"c5";
when 78 => vROM_tmp <= "01" & x"c5" & "01" & x"c5";
when 79 => vROM_tmp <= "01" & x"75" & "10" & x"85";
when 80 => vROM_tmp <= "01" & x"b5" & "10" & x"45";
when 81 => vROM_tmp <= "10" & x"35" & "10" & x"35";
when 82 => vROM_tmp <= "01" & x"35" & "01" & x"35";
when 83 => vROM_tmp <= "11" & x"25" & "11" & x"25";
when 84 => vROM_tmp <= "00" & x"b5" & "00" & x"b5";
when 85 => vROM_tmp <= "10" & x"a5" & "10" & x"a5";
when 86 => vROM_tmp <= "01" & x"a5" & "01" & x"a5";
when 87 => vROM_tmp <= "11" & x"a5" & "00" & x"55";
when 88 => vROM_tmp <= "11" & x"35" & "00" & x"c5";
when 89 => vROM_tmp <= "10" & x"65" & "10" & x"65";
when 90 => vROM_tmp <= "01" & x"65" & "01" & x"65";
when 91 => vROM_tmp <= "11" & x"65" & "00" & x"95";
when 92 => vROM_tmp <= "00" & x"e5" & "00" & x"e5";
when 93 => vROM_tmp <= "10" & x"e5" & "01" & x"15";
when 94 => vROM_tmp <= "01" & x"e5" & "10" & x"15";
when 95 => vROM_tmp <= "10" & x"b5" & "01" & x"45";
when 96 => vROM_tmp <= "10" & x"73" & "01" & x"8c";
when 97 => vROM_tmp <= "01" & x"d3" & "10" & x"2c";
when 98 => vROM_tmp <= "10" & x"d3" & "01" & x"2c";
when 99 => vROM_tmp <= "11" & x"1c" & "11" & x"13";
when 100 => vROM_tmp <= "11" & x"53" & "00" & x"ac";
when 101 => vROM_tmp <= "10" & x"9c" & "10" & x"93";
when 102 => vROM_tmp <= "01" & x"9c" & "01" & x"93";
when 103 => vROM_tmp <= "11" & x"8c" & "00" & x"73";
when 104 => vROM_tmp <= "11" & x"93" & "00" & x"6c";
when 105 => vROM_tmp <= "10" & x"5c" & "10" & x"53";
when 106 => vROM_tmp <= "01" & x"5c" & "01" & x"53";
when 107 => vROM_tmp <= "11" & x"4c" & "11" & x"43";
when 108 => vROM_tmp <= "00" & x"dc" & "00" & x"d3";
when 109 => vROM_tmp <= "10" & x"cc" & "10" & x"c3";
when 110 => vROM_tmp <= "01" & x"cc" & "01" & x"c3";
when 111 => vROM_tmp <= "01" & x"73" & "10" & x"8c";
when 112 => vROM_tmp <= "01" & x"b3" & "10" & x"4c";
when 113 => vROM_tmp <= "10" & x"3c" & "10" & x"33";
when 114 => vROM_tmp <= "01" & x"3c" & "01" & x"33";
when 115 => vROM_tmp <= "11" & x"2c" & "11" & x"23";
when 116 => vROM_tmp <= "00" & x"bc" & "00" & x"b3";
when 117 => vROM_tmp <= "10" & x"ac" & "10" & x"a3";
when 118 => vROM_tmp <= "01" & x"ac" & "01" & x"a3";
when 119 => vROM_tmp <= "11" & x"a3" & "00" & x"5c";
when 120 => vROM_tmp <= "11" & x"33" & "00" & x"cc";
when 121 => vROM_tmp <= "10" & x"6c" & "10" & x"63";
when 122 => vROM_tmp <= "01" & x"6c" & "01" & x"63";
when 123 => vROM_tmp <= "11" & x"63" & "00" & x"9c";
when 124 => vROM_tmp <= "00" & x"ec" & "00" & x"e3";
when 125 => vROM_tmp <= "10" & x"e3" & "01" & x"1c";
when 126 => vROM_tmp <= "01" & x"e3" & "10" & x"1c";
when 127 => vROM_tmp <= "10" & x"b3" & "01" & x"4c";
when 128 => vROM_tmp <= "10" & x"72" & "01" & x"8d";
when 129 => vROM_tmp <= "01" & x"d2" & "10" & x"2d";
when 130 => vROM_tmp <= "10" & x"d2" & "01" & x"2d";
when 131 => vROM_tmp <= "11" & x"1d" & "11" & x"12";
when 132 => vROM_tmp <= "11" & x"52" & "00" & x"ad";
when 133 => vROM_tmp <= "10" & x"9d" & "10" & x"92";
when 134 => vROM_tmp <= "01" & x"9d" & "01" & x"92";
when 135 => vROM_tmp <= "11" & x"8d" & "00" & x"72";
when 136 => vROM_tmp <= "11" & x"92" & "00" & x"6d";
when 137 => vROM_tmp <= "10" & x"5d" & "10" & x"52";
when 138 => vROM_tmp <= "01" & x"5d" & "01" & x"52";
when 139 => vROM_tmp <= "11" & x"4d" & "11" & x"42";
when 140 => vROM_tmp <= "00" & x"dd" & "00" & x"d2";
when 141 => vROM_tmp <= "10" & x"cd" & "10" & x"c2";
when 142 => vROM_tmp <= "01" & x"cd" & "01" & x"c2";
when 143 => vROM_tmp <= "01" & x"72" & "10" & x"8d";
when 144 => vROM_tmp <= "01" & x"b2" & "10" & x"4d";
when 145 => vROM_tmp <= "10" & x"3d" & "10" & x"32";
when 146 => vROM_tmp <= "01" & x"3d" & "01" & x"32";
when 147 => vROM_tmp <= "11" & x"2d" & "11" & x"22";
when 148 => vROM_tmp <= "00" & x"bd" & "00" & x"b2";
when 149 => vROM_tmp <= "10" & x"ad" & "10" & x"a2";
when 150 => vROM_tmp <= "01" & x"ad" & "01" & x"a2";
when 151 => vROM_tmp <= "11" & x"a2" & "00" & x"5d";
when 152 => vROM_tmp <= "11" & x"32" & "00" & x"cd";
when 153 => vROM_tmp <= "10" & x"6d" & "10" & x"62";
when 154 => vROM_tmp <= "01" & x"6d" & "01" & x"62";
when 155 => vROM_tmp <= "11" & x"62" & "00" & x"9d";
when 156 => vROM_tmp <= "00" & x"ed" & "00" & x"e2";
when 157 => vROM_tmp <= "10" & x"e2" & "01" & x"1d";
when 158 => vROM_tmp <= "01" & x"e2" & "10" & x"1d";
when 159 => vROM_tmp <= "10" & x"b2" & "01" & x"4d";
when 160 => vROM_tmp <= "10" & x"7a" & "01" & x"8a";
when 161 => vROM_tmp <= "01" & x"da" & "10" & x"2a";
when 162 => vROM_tmp <= "10" & x"da" & "01" & x"2a";
when 163 => vROM_tmp <= "11" & x"1a" & "11" & x"1a";
when 164 => vROM_tmp <= "11" & x"5a" & "00" & x"aa";
when 165 => vROM_tmp <= "10" & x"9a" & "10" & x"9a";
when 166 => vROM_tmp <= "01" & x"9a" & "01" & x"9a";
when 167 => vROM_tmp <= "11" & x"8a" & "00" & x"7a";
when 168 => vROM_tmp <= "11" & x"9a" & "00" & x"6a";
when 169 => vROM_tmp <= "10" & x"5a" & "10" & x"5a";
when 170 => vROM_tmp <= "01" & x"5a" & "01" & x"5a";
when 171 => vROM_tmp <= "11" & x"4a" & "11" & x"4a";
when 172 => vROM_tmp <= "00" & x"da" & "00" & x"da";
when 173 => vROM_tmp <= "10" & x"ca" & "10" & x"ca";
when 174 => vROM_tmp <= "01" & x"ca" & "01" & x"ca";
when 175 => vROM_tmp <= "01" & x"7a" & "10" & x"8a";
when 176 => vROM_tmp <= "01" & x"ba" & "10" & x"4a";
when 177 => vROM_tmp <= "10" & x"3a" & "10" & x"3a";
when 178 => vROM_tmp <= "01" & x"3a" & "01" & x"3a";
when 179 => vROM_tmp <= "11" & x"2a" & "11" & x"2a";
when 180 => vROM_tmp <= "00" & x"ba" & "00" & x"ba";
when 181 => vROM_tmp <= "10" & x"aa" & "10" & x"aa";
when 182 => vROM_tmp <= "01" & x"aa" & "01" & x"aa";
when 183 => vROM_tmp <= "11" & x"aa" & "00" & x"5a";
when 184 => vROM_tmp <= "11" & x"3a" & "00" & x"ca";
when 185 => vROM_tmp <= "10" & x"6a" & "10" & x"6a";
when 186 => vROM_tmp <= "01" & x"6a" & "01" & x"6a";
when 187 => vROM_tmp <= "11" & x"6a" & "00" & x"9a";
when 188 => vROM_tmp <= "00" & x"ea" & "00" & x"ea";
when 189 => vROM_tmp <= "10" & x"ea" & "01" & x"1a";
when 190 => vROM_tmp <= "01" & x"ea" & "10" & x"1a";
when 191 => vROM_tmp <= "10" & x"ba" & "01" & x"4a";
when 192 => vROM_tmp <= "10" & x"76" & "01" & x"86";
when 193 => vROM_tmp <= "01" & x"d6" & "10" & x"26";
when 194 => vROM_tmp <= "10" & x"d6" & "01" & x"26";
when 195 => vROM_tmp <= "11" & x"16" & "11" & x"16";
when 196 => vROM_tmp <= "11" & x"56" & "00" & x"a6";
when 197 => vROM_tmp <= "10" & x"96" & "10" & x"96";
when 198 => vROM_tmp <= "01" & x"96" & "01" & x"96";
when 199 => vROM_tmp <= "11" & x"86" & "00" & x"76";
when 200 => vROM_tmp <= "11" & x"96" & "00" & x"66";
when 201 => vROM_tmp <= "10" & x"56" & "10" & x"56";
when 202 => vROM_tmp <= "01" & x"56" & "01" & x"56";
when 203 => vROM_tmp <= "11" & x"46" & "11" & x"46";
when 204 => vROM_tmp <= "00" & x"d6" & "00" & x"d6";
when 205 => vROM_tmp <= "10" & x"c6" & "10" & x"c6";
when 206 => vROM_tmp <= "01" & x"c6" & "01" & x"c6";
when 207 => vROM_tmp <= "01" & x"76" & "10" & x"86";
when 208 => vROM_tmp <= "01" & x"b6" & "10" & x"46";
when 209 => vROM_tmp <= "10" & x"36" & "10" & x"36";
when 210 => vROM_tmp <= "01" & x"36" & "01" & x"36";
when 211 => vROM_tmp <= "11" & x"26" & "11" & x"26";
when 212 => vROM_tmp <= "00" & x"b6" & "00" & x"b6";
when 213 => vROM_tmp <= "10" & x"a6" & "10" & x"a6";
when 214 => vROM_tmp <= "01" & x"a6" & "01" & x"a6";
when 215 => vROM_tmp <= "11" & x"a6" & "00" & x"56";
when 216 => vROM_tmp <= "11" & x"36" & "00" & x"c6";
when 217 => vROM_tmp <= "10" & x"66" & "10" & x"66";
when 218 => vROM_tmp <= "01" & x"66" & "01" & x"66";
when 219 => vROM_tmp <= "11" & x"66" & "00" & x"96";
when 220 => vROM_tmp <= "00" & x"e6" & "00" & x"e6";
when 221 => vROM_tmp <= "10" & x"e6" & "01" & x"16";
when 222 => vROM_tmp <= "01" & x"e6" & "10" & x"16";
when 223 => vROM_tmp <= "10" & x"b6" & "01" & x"46";
when 224 => vROM_tmp <= "10" & x"71" & "01" & x"8e";
when 225 => vROM_tmp <= "01" & x"d1" & "10" & x"2e";
when 226 => vROM_tmp <= "10" & x"d1" & "01" & x"2e";
when 227 => vROM_tmp <= "11" & x"1e" & "11" & x"11";
when 228 => vROM_tmp <= "11" & x"51" & "00" & x"ae";
when 229 => vROM_tmp <= "10" & x"9e" & "10" & x"91";
when 230 => vROM_tmp <= "01" & x"9e" & "01" & x"91";
when 231 => vROM_tmp <= "11" & x"8e" & "00" & x"71";
when 232 => vROM_tmp <= "11" & x"91" & "00" & x"6e";
when 233 => vROM_tmp <= "10" & x"5e" & "10" & x"51";
when 234 => vROM_tmp <= "01" & x"5e" & "01" & x"51";
when 235 => vROM_tmp <= "11" & x"4e" & "11" & x"48";
when 236 => vROM_tmp <= "00" & x"de" & "00" & x"d1";
when 237 => vROM_tmp <= "10" & x"ce" & "10" & x"c8";
when 238 => vROM_tmp <= "01" & x"ce" & "01" & x"c8";
when 239 => vROM_tmp <= "01" & x"71" & "10" & x"8e";
when 240 => vROM_tmp <= "01" & x"b1" & "10" & x"4e";
when 241 => vROM_tmp <= "10" & x"37" & "10" & x"31";
when 242 => vROM_tmp <= "01" & x"37" & "01" & x"31";
when 243 => vROM_tmp <= "11" & x"2e" & "11" & x"21";
when 244 => vROM_tmp <= "00" & x"b7" & "00" & x"b1";
when 245 => vROM_tmp <= "10" & x"ae" & "10" & x"a1";
when 246 => vROM_tmp <= "01" & x"ae" & "01" & x"a1";
when 247 => vROM_tmp <= "11" & x"a1" & "00" & x"5e";
when 248 => vROM_tmp <= "11" & x"31" & "00" & x"ce";
when 249 => vROM_tmp <= "10" & x"6e" & "10" & x"61";
when 250 => vROM_tmp <= "01" & x"6e" & "01" & x"61";
when 251 => vROM_tmp <= "11" & x"61" & "00" & x"9e";
when 252 => vROM_tmp <= "00" & x"ee" & "00" & x"e1";
when 253 => vROM_tmp <= "10" & x"e1" & "01" & x"1e";
when 254 => vROM_tmp <= "01" & x"e1" & "10" & x"1e";
when 255 => vROM_tmp <= "10" & x"b1" & "01" & x"4e";
      when others => vROM_tmp <= (others => '0');
    end case;
  end process;

end behav;
