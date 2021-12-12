----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2021 08:32:46 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
   Port ( 
  RA : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
  WA: in STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
  WD :  in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  RD: out STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
  MemWrite: in STD_LOGIC := '0';
  clk: in STD_LOGIC
 );
end MEM;

architecture Behavioral of MEM is
type RAM_type is array (0 to 256) of STD_LOGIC_VECTOR (15 downto 0);
     
     signal RAM: RAM_type := 
     ( 
     others=>x"0000"
     );
begin

  RD <= RAM(to_integer(unsigned (RA)));
   process(clk)
   begin
   if rising_edge(clk) then
    if MemWrite = '1' then
        RAM(to_integer(unsigned(WA))) <= WD ;
        end if;
     end if;
   end process;

end Behavioral;
