----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2021 09:00:22 PM
-- Design Name: 
-- Module Name: WB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB is
    Port ( MemToReg : in STD_LOGIC;
           Branch : in STD_LOGIC;
           JNE: in STD_LOGIC;
           ZeroFlag: in STD_LOGIC;
           JumpIn : in STD_LOGIC_VECTOR (12 downto 0);
           RD: in STD_LOGIC_VECTOR(15 downto 0);
           ALUResult: in STD_LOGIC_VECTOR(15 downto 0);
           PC: in STD_LOGIC_VECTOR (15 downto 0);
           JumpOut : out STD_LOGIC_VECTOR (15 downto 0);
           WD: out STD_LOGIC_VECTOR (15 downto 0);
           PCSrc : out STD_LOGIC);
end WB;


architecture Behavioral of WB is

begin

    JumpOut <= PC(15 downto 13)  & JumpIn ;
    PCSrc <= (Branch and ZeroFlag)and ((not ZeroFlag) and JNE );
    
    process(MemToReg)
    
    begin
        if MemToReg = '1' then
           WD <= RD;
        else
            WD <= ALUResult;
          end if; 
    end process;


end Behavioral;
