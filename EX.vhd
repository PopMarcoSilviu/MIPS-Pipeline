----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2021 10:43:56 AM
-- Design Name: 
-- Module Name: EX - Behavioral
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

entity EX is
    Port ( PC : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_imm : in STD_LOGIC_VECTOR (15 downto 0);
           func : in STD_LOGIC_VECTOR (2 downto 0);
           sa : in STD_LOGIC;
           ALUSrc : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           ALURes: out  STD_LOGIC_VECTOR(15 downto 0);
           ZERO: out STD_LOGIC;
           BranchAdress: out STD_LOGIC_VECTOR(15 downto 0);
           RA1: in STD_LOGIC_VECTOR(2 downto 0);
           RA2: in STD_LOGIC_VECTOR(2 downto 0);
           RegDst: in STD_LOGIC;
           RegDstAddress: out STD_LOGIC_VECTOR(2 downto 0));
end EX;

architecture Behavioral of EX is

signal SecondOperand: STD_LOGIC_VECTOR(15 downto 0);
signal ALUCtrl: STD_LOGIC_VECTOR (2 downto 0);
signal Result: STD_LOGIC_VECTOR (15 downto 0);
signal ShiftedResult : STD_LOGIC_VECTOR(15 downto 0);
signal shift: INTEGER:= 0;
begin

BranchAdress <= PC + 1 + Ext_imm; 
ShiftedResult <= Result(15 downto 1) & '0';

process(ALUSrc)
begin
    if ALUSrc = '0' then
        SecondOperand <= RD2;
     else
        SecondOperand <= Ext_imm;
    end if;

end process;

process(ALUOp, func)
begin

    case ALUOp is
        when "000" =>
            case func is 
                when "000" => ALUCtrl <= "000"; --OR
                when "001" => ALUCtrl <= "001"; --ADD
                when "010" => ALUCtrl <= "010"; --SUB
                when "011" => ALUCtrl <= "011"; --SLL
                when "111" => ALUCtrl <= "111"; --SRL
                when "100" => ALUCtrl <= "100"; --XOR
                when "101" => ALUCtrl <= "101"; --XNOR
                when "110" => ALUCtrl <= "110"; --AND
                when others => ALUCtrl <= (others => 'X');
             end case;
        when "010" => ALUCtrl <="001"; -- ADDI
        when "001" => ALUCtrl <="001"; -- LW
        when "100" => ALUCtrl <="001"; -- SW
        when "101" => ALUCtrl <="010"; --BEQ
        when "110" => ALUCtrl <= "010"; --BNEZ
        when others => ALUCtrl <= (others => 'X');
    end case;
end process;

shift <= to_integer(unsigned(SecondOperand));

process(ALUCtrl, RD1, SecondOperand, sa)
begin
    case ALUCtrl is
        when "000" => Result <= RD1 or SecondOperand;
        when "001" => Result <= RD1 + SecondOperand;
        when "010" => Result <= RD1 - SecondOperand;
        when "011" => Result <= ShiftedResult;
        when "100" => Result <= RD1 xor SecondOperand;
        when "101" => Result <= not (RD1 xor SecondOperand);
        when "110" => Result <= RD1 and SecondOperand;
        when others => Result <= (others => '0');                 
    end case;

end process;







end Behavioral;
