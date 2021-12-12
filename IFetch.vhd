----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2021 10:20:42 AM
-- Design Name: 
-- Module Name: IFetch - Behavioral
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

entity IFetch is
    Port ( JumpAdress : in STD_LOGIC_VECTOR (15 downto 0);
           BranchAdress : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCSrc: in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0) := (others =>'0');
           Instruction: out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC
           );
end IFetch;

architecture Behavioral of IFetch is
    
signal PC : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal temp : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal temp2:  STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
type ROM_type is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);
signal ROM :ROM_type:=
(
B"000_000_000_001_0_000", -- or $1, $0, $0	0010
B"000_000_000_010_0_000", -- or $2, $0, $0	0020
B"001_000_100_0010000", --lw $4, matrixDimension($0)	2210
B"010_000_011_1111111", --addi $3, $0, 0x7f	41FF
B"001_001_011_0010000",--lw $3 ,$minRow($1) 	2590
B"010_001_001_0000001", --addi $1, $1, 1	4481
B"011_001_100_0001000", --beq $1, $4, endLoop	6608
B"111_0000000000011", --j arrayInitializeLoop:	E003
B"000_000_000_001_0_000", --or $1, $0, $0	0010
B"000_000_000_110_0_001", -- add $6, $0, $0	0061
B"000_000_000_111_0_001", --add $7, $0, $0	0071
B"000_110_100_110_0_001", --add $6, $6, $4 	1A61
B"010_111_111_0000001", --addi $7, $7, 1	5F81
B"101_111_001_0001111", --beq $7, $1, multiplyLoopExit	BC8F
B"111_0000000001011", --j  multiplyLoop	E00B
B"000_110_010_110_0_001", --add $6, $6, $2	1961
B"001_110_111_001000", --lw $7, matrix($6)   	3B97
B"001_001_011_0100000", --lw  $3, minRow($1) 	25A0
B"000_111_011_011_0_010", --sub $3, $7, $3  	1DB2
B"010_000_111_1000000", --addi $7, $0, 0x40	43C0
B"000_000_111_111_0_111",  --sll $7, $7, 7   	03F7
B"000_000_111_111_0_010", -- sll $7, $7, 2   	03F2
B"000_011_111_011_0_001", --and $3, $3, $7	0FB1
B"101_011_000_0011001", --beq $3, $0, elseJump	AC19
B"100_001_111_0100000", --sw $7, minRow($1) 	87A0
B"010_010_010_0000001", --addi $2, $2, 1  	4901
B"101_010_100_0011011", --beq $2, $4, innerLoop 	AA1B
B"010_001_001_0000001", --addi $1, $1, 1   	4481
B"010_001_100_0011110", -- beq $1, $4, outerLoopExit	461E
B"000_000_000_001_0_000", --or $1, $0, $0	0010
B"101_010_100_0101111", --beq $4, $2 outerLoop1Exit	AA2F
B"000_000_000_010_0_000", --or $2, $0, $0 	0020
B"101_001_100_0001100", --beq $1, $4 inneLoop1Exit	A60C
B"000_000_000_110_0_001", --add $6, $0, $0		 	0061
B"000_000_000_111_0_001", --add $7, $0, $0	0071
B"000_110_100_110_0_001",  --add $6, $6, $4		1A61
B"010_111_111_0000001",  --addi $7, $7, 1	5F81
B"101_111_001_0000010", --beq $7, $1, multiplyLoopExit 	BC82
B"111_111111111101", --j  multiplyLoop		FFFA
B"000_110_010_0_001_001", --add $6, $6, $2	1909
B"001_110_111_0010000", -- lw $7, matrix($6)	3B90
B"001_001_011_0100000", --lw $3, minRow($1)  	25A0
B"000_111_011_111_0_010", --sub $7, $7, $3	1DF2
B"100_110_111_0010000", --sw $7, matrix($6)	9B90
B"111_1111111110100", -- j innerLoop1	FFF4
B"010_010_010_0000001", -- addi $2, $2, 1	4901
B"111_111111111000", --j outerLoop1	FFF1
B"000_000_000_010_0_000", --or $2, $0, $0	0020
B"101_100_010_1110000", -- beq $4, $2, outerLoop3Exit	B170
B"000_000_000_001_0_000", --or $1, $0, $0	0010
B"101_001_100_1110100", --beq $1, $4 innerLoop3Exit	A674
B"000_000_000_110_0_001", --add $6, $0, $0	0061
B"000_000_000_111_0_001", --add $7, $0, $0	0071
B"000_100_110_110_0_001", --add $6, $6, $4	1361
B"010_111_111_0000001", -- addi $7, $7, 1	5F81
B"101_111_001_1111110", --beq $7, $1, multiplyLoopExit	BCFE
B"111_111111111101", -- j  multiplyLoop	FFFA
B"001_110_111_0100000",   --lw $7, matrix($6)	3BA0
B"001_010_011_1000000", --lw $3, minCol($2)	29C0
B"000_110_111_011_0_010", --sub $6,$7, $3	1BB2
B"101_000_110_1111110", --beq $6, $0 elseJump2	A37E
B"100_010_111_1000000", --	sw $7, minCol($2) 	8BC0
B"010_001_001_0000001", -- addi $1,$1,1	4481
B"010_010_010_0000001",	--addi $2, $2, 1	4901
B"000_000_000_100_0_000",--	or $1, $0, $0	0040
B"101_100_010_1110001", --beq $4, $2 outerLoop1Exit	B171
B"000_000_000_010_0_000", --or $2, $0, $0	0020
B"101_100_001_1110100", --beq $1, $4 inneLoop1Exit	B0F4
B"000_000_000_110_0_000", --add $6, $0, $0			0060
B"000_000_000_111_0_000", --add $7, $0, $0  	  	0070
B"000_110_100_110_0_00", --add $6, $6, $4			1A66
B"010_111_111_0000001", --addi $7, $7, 1					5F81
B"101_001_111_1111110", --beq $7, $1, multiplyLoopExit 			A7FE
B"101_001_111_1111110", --	beq $7, $1, multiplyLoopExit 	A7FE
B"111_111111111101", --j  multiplyLoop			FFFA
B"000_010_110_0_001", --		add $6, $6, $2			0B2E
B"001_110_111_0010000", --	lw $7, matrix($6)		3B90
B"001_010_011_1000000", ---	lw $3, minCol($2)		29C0
B"000_111_011_111_010", --sub $7, $7, $3			1DFB
B"100_110_111_0010000",--sw $7, matrix($6)		9B90
B"111_111111111101"	, --	j innerLoop4 	FFFE
B"010_010_010_0000001", --addi $2, $2, 1 	4901
B"111_1111111110001", --j outerLoop4	FFF1
  				 		
others => x"0000"
);


begin

PCout <= PC+4;
    
temp <= PC+4 when PCSrc = '0' else
        BranchAdress;
        
temp2 <= temp when Jump = '0' else
        JumpAdress;
        
process(clk)
begin
    if rising_edge(clk) then
        PC <= temp2;
    end if;

end process;

Instruction <= ROM(to_integer(unsigned(PC))) ;

end Behavioral;
