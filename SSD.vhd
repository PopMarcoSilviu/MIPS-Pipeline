----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2021 10:32:21 AM
-- Design Name: 
-- Module Name: SSD - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( Digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           AnodIn : in STD_LOGIC_VECTOR (15 downto 0);
           AnodOut : out STD_LOGIC_VECTOR (3 downto 0);
           Cat : out STD_LOGIC_VECTOR (6 downto 0));
end SSD;

architecture Behavioral of SSD is

signal counter : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal Selection: STD_LOGIC_VECTOR (1 downto 0) := (others => '0') ;
signal SelectedDigit : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
           counter <= counter +1;
        end if;
    end process;
    
    Selection <= counter (15 downto 14);
    
    process(Digit, Selection)
    begin
        case Selection is
            when "00" =>    
               SelectedDigit <= Digit (3 downto 0); 
            when "01" =>    
               SelectedDigit <= Digit (7 downto 4);  
            when "10" =>    
               SelectedDigit <= Digit (11 downto 8); 
            when others =>
                SelectedDigit <= Digit (15 downto 12);
         
        end case;
    
    end process;
    
    process(AnodIn, Selection)
    begin
           case Selection is
              when "00" =>    
                 AnodOut <= AnodIn (3 downto 0); 
              when "01" =>    
                 AnodOut <= AnodIn (7 downto 4);  
              when "10" =>    
                 AnodOut <= AnodIn (11 downto 8); 
              when others =>
                  AnodOut <= AnodIn (15 downto 12);
          end case;   
    
    
    end process;

    
   with Digit SELect
   Cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0        

end Behavioral;









