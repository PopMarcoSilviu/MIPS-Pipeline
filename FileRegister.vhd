----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2021 11:15:51 AM
-- Design Name: 
-- Module Name: FileRegister - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FileRegister is
           Port(
           RA1: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           RA2: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WA: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WD: in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
           RegWr: in STD_LOGIC :='0';
           clk: in STD_LOGIC :='0';
           RD1: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
           Enable: in STD_LOGIC;
           RD2: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0')
           );
end FileRegister;

architecture Behavioral of FileRegister is

    type REG_array is array (0 to 15) of STD_LOGIC_VECTOR (15 downto 0) ;
    signal reg_file: REG_array:=
    (
       x"0010",
       x"1111",
       x"3444",
       x"1344",
       others=>x"0000"
    ); 
    
begin



    
    process (clk)
    begin
    
        if falling_edge(clk) then
            RD1 <= reg_file ( to_integer(unsigned(RA1)));
            RD2 <= reg_file ( to_integer(unsigned(RA2)));
        end if;
    
        if rising_edge(clk) then
            if RegWr = '1' then
                if Enable = '1' then
                reg_file( to_integer(unsigned(WA)) ) <= WD ;
                end if;
            end if;
        end if;
    end process;
    

    
end Behavioral;
