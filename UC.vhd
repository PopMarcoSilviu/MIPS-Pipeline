----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2021 04:06:39 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port ( OpCode : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOP : out STD_LOGIC;
           AluSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           Jne: out STD_LOGIC;
           AluOP : out STD_LOGIC_VECTOR(2 downto 0);
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin
    

process(OpCode)
begin
    case OpCode is
        when "000" => RegDst <= '1';
                      ExtOp <= '0';
                      ALUSrc <= '0';
                      Branch <= '0';
                      Jump <= '0';
                      AluOP <= "000";
                      MemWrite<= '0';
                      MemToReg <= '0';
                      RegWrite <= '1';
                      Jne <= '0';
                      
                      
        when "011" => RegDst <= '1';
                      ExtOp <= '0';
                      ALUSrc <= '0';
                      Branch <= '0';
                      Jump <= '1';
                      AluOP <= "000";
                      MemWrite<= '0';
                      MemToReg <= '0';
                      RegWrite <= '0';
                      Jne <= '1';
                                          
                      
                      
        when "111" => RegDst <= '1';
                    ExtOp <= '0';
                    ALUSrc <= '0';
                    Branch <= '0';
                    Jump <= '1';
                    AluOP <= "000";
                    MemWrite<= '0';
                    MemToReg <= '0';
                    RegWrite <= '0';
                    Jne <= '0';
                    
        when "001" => RegDst <= '0';
                    ExtOp <= '1';
                    ALUSrc <= '1';
                    Branch <= '0';
                    Jump <= '1';
                    AluOP <= "001";
                    MemWrite<= '0';
                    MemToReg <= '0';
                    RegWrite <= '0';
                    Jne <= '0';
                    
     when "010" => RegDst <= '0';
                   ExtOp <= '1';
                   ALUSrc <= '1';
                   Branch <= '0';
                   Jump <= '0';
                   AluOP <= "001";
                   MemWrite<= '0';
                   MemToReg <= '0';
                   RegWrite <= '1';
                   Jne <= '0';
                   
     when "101" => RegDst <= '0';
                    ExtOp <= '1';
                    ALUSrc <= '1';
                    Branch <= '1';
                    Jump <= '0';
                    AluOP <= "010";
                    MemWrite<= '0';
                    MemToReg <= '0';
                    RegWrite <= '0';
                    Jne <= '0';
                    
     when "100" => RegDst <= '0';
               ExtOp <= '1';
               ALUSrc <= '1';
               Branch <= '0';
               Jump <= '0';
               AluOP <= "010";
               MemWrite<= '0';
               MemToReg <= '1';
               RegWrite <= '1';
               Jne <= '0';
               
    when others =>
            null;
    
 
    end case;

end process;


end Behavioral;
