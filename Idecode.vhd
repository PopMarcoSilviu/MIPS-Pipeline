----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 10:27:55 AM
-- Design Name: 
-- Module Name: Idecode - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Idecode is
    Port ( RegWrite : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           Ext_imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           enable: in STD_LOGIC;
           sa : out STD_LOGIC;
           clk : in STD_LOGIC);
end Idecode;

architecture Behavioral of Idecode is

component FileRegister is
           Port(
           RA1: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           RA2: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WA: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WD: in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
           RegWr: in STD_LOGIC :='0';
           Enable: in STD_LOGIC;
           clk: in STD_LOGIC :='0';
           RD1: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
           RD2: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0')
           );
end component;

signal ReadAdress1: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal ReadAdress2: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal WriteAdress: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal extended : STD_LOGIC_VECTOR(15 downto 0);
begin

          

    RF1: FileRegister port map( RA1=> ReadAdress1,  RA2=> ReadAdress2, WA=> WriteAdress, WD => WD, RegWr => RegWrite,
                                Enable => enable, clk =>clk, RD1=> RD1, RD2 => RD2);
                                
 with Instruction(0) select
    extended <= (x"00" & Instruction(7 downto 0)) when '0',
                 (x"11" & Instruction(7 downto 0)) when '1'; 
                                
with ExtOp select
             Ext_imm <= X"0000" when '0',
                        extended when '1';                   

  func <= Instruction(2 downto 0);
  sa <=  Instruction(3);
end Behavioral;
