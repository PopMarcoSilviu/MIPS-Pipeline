----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2021 10:40:21 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is
    
    component MPG
        Port ( clk : in STD_LOGIC;  
                btn : in STD_LOGIC;
                enable : out STD_LOGIC); 
        end component;
                
    component SSD is
        Port ( Digit : in STD_LOGIC_VECTOR (15 downto 0);
               clk : in STD_LOGIC;
               AnodIn : in STD_LOGIC_VECTOR (15 downto 0);
               AnodOut : out STD_LOGIC_VECTOR (3 downto 0);
               Cat : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
  
    component FileRegister is
               Port(
               RA1: in STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
               RA2: in STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
               WA: in STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
               WD: in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
               RegWr: in STD_LOGIC :='0';
               clk: in STD_LOGIC :='0';
               RD1: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
               RD2: out STD_LOGIC_VECTOR(15 downto 0) := (others => '0')
               );
    end component;
    
    
    component IFetch is
        Port ( JumpAdress : in STD_LOGIC_VECTOR (15 downto 0);
               BranchAdress : in STD_LOGIC_VECTOR (15 downto 0);
               Jump : in STD_LOGIC;
               PCSrc: in STD_LOGIC;
               PCout : out STD_LOGIC_VECTOR (15 downto 0) := (others =>'0');
               Instruction: out STD_LOGIC_VECTOR (15 downto 0);
               clk : in STD_LOGIC
               );
    end component;
    
component UC is
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
    end component;

    
    
    component Idecode is
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
    end component;
    
    
    
    component MEM is
       Port ( 
      RA : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
      WA: in STD_LOGIC_VECTOR(2 downto 0):= (others => '0');
      WD :  in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
      RD: out STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
      MemWrite: in STD_LOGIC := '0';
      clk: in STD_LOGIC
     );
    end component;

   component RAM is
        Port ( 
         RA : in STD_LOGIC_VECTOR (3 downto 0):= (others => '0');
         WA: in STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
         WD :  in STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
         RD: out STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
         MemWrite: in STD_LOGIC := '0';
         clk: in STD_LOGIC
        );
    end component;
    
    
    component EX is
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
    end component;
            
            
     component WB is
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
    end component;

    

 
       signal digits: STD_LOGIC_VECTOR (15 downto 0) := (others =>'0');
       
       signal enables: STD_LOGIC_VECTOR (3 downto 0):=  (others =>'0');   
       signal JumpAdress : STD_LOGIC_VECTOR(15 downto 0) := x"0001";
       signal BranchAdress : STD_LOGIC_VECTOR(15 downto 0) := x"001A";
       signal ResetAdress: STD_LOGIC_VECTOR(15 downto 0):= x"0000";
       signal FinalJumpAdress: STD_LOGIC_VECTOR (15 downto 0);
       signal Jump: STD_LOGIC;
       signal PCout: STD_LOGIC_VECTOR(15 downto 0);
       signal Instruction: STD_LOGIC_VECTOR (15 downto 0);
       signal IFetchClk: STD_LOGIC;
       signal count : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
       signal RegWrite: STD_LOGIC;
       signal ExtOp: STD_LOGIC;
       signal RegDst: STD_LOGIC;
       signal RD1: STD_LOGIC_VECTOR(15 downto 0);
       signal RD2: STD_LOGIC_VECTOR(15 downto 0);  
       signal sum: STD_LOGIC_VECTOR(15 downto 0);
       signal Ext_imm: STD_LOGIC_VECTOR(15 downto 0);
       signal func: STD_LOGIC_VECTOR(2 downto 0);
       signal sa: STD_LOGIC ;
       signal ALUSrc: STD_LOGIC;
       signal ALUOp: STD_LOGIC_VECTOR(2 downto 0);
       signal ALURes: STD_LOGIC_VECTOR(15 downto 0);
       signal ZERO: STD_LOGIC;
       signal MemToReg: STD_LOGIC;
       signal Jne: STD_LOGIC;
       signal Branch: STD_LOGIC;
       signal MemWrite: STD_LOGIC;
       signal RD: STD_LOGIC_VECTOR(15 downto 0);
       signal WBData: STD_LOGIC_VECTOR(15 downto 0);
       signal RegDstAddress: STD_LOGIC_VECTOR(2 downto 0);
       signal RA1: STD_LOGIC_VECTOR(2 downto 0);
       signal RA2: STD_LOGIC_VECTOR(2 downto 0);
       
       signal Reg1: STD_LOGIC_VECTOR (31 downto 0); 
       signal Reg2: STD_LOGIC_VECTOR(83 downto 0);
       signal Reg3: STD_LOGIC_VECTOR(56 downto 0);
       signal Reg4: STD_LOGIC_VECTOR(36 downto 0);
       
       
begin
 
   process(clk)
   begin
        if rising_edge(clk) then
      
                count <= count + 1;         
        end if;

   end process;
   
   process(clk)
   begin
    if rising_edge(clk) then
        if(enables(0)='1') then
            Reg1(31 downto 16) <= PCout;
            Reg1(15 downto 0) <=Instruction ;
            
            Reg2(83) <= RegDst;
            Reg2(82 downto 80) <= func;
            Reg2(79) <= ALUSrc;
            Reg2(78) <= Branch;
            Reg2(77) <= MemWrite;
            Reg2(76) <= Jne;
            Reg2(75) <= RegWrite;
            Reg2(74) <=MemToReg ;
            Reg2(73 downto 58) <=  Reg1(31 downto 16) ;
            Reg2(57 downto 42) <= RD1;
            Reg2(41 downto 26) <= RD2;
            Reg2(25 downto 23) <= Reg1(2 downto 0)  ;
            Reg2(22) <= Reg1(3);
            Reg2(21 downto 6) <= Ext_imm ;
            Reg2(5 downto 3) <= Reg1(9 downto 7);
            Reg2(2 downto 0) <= Reg1(6 downto 4);
            
            Reg3(56) <= Reg2(78);
            Reg3(55) <= Reg2(77);
            Reg3(54) <= Reg2(76) ;
            Reg3(53) <= Reg2(75);
            Reg3(52) <=  Reg2(74);
            Reg3(51) <= ZERO;
            Reg3(50 downto 35) <= ALURes;
            Reg3(34 downto 19) <= Reg2(41 downto 26);
            Reg3(18 downto 3) <= BranchAdress;
            Reg3(2 downto 0) <= RegDstAddress ;
            
            Reg4(36) <=  Reg3(53);
            Reg4(35) <= Reg3(52); 
            Reg4(34 downto 19) <= RD;
            Reg4(18 downto 3) <= Reg3(50 downto 35);
            Reg4(2 downto 0) <= Reg3(2 downto 0);
                        
        end if;
    end if;
   
   
   end process;
   


       MPG_enable1:MPG port map(clk=> clk, btn => btn(0), enable=>enables(0));  -- reset
       MPG_enable2:MPG port map(clk=> clk, btn => btn(1), enable=>enables(1));  -- iterate
       MPG_enable3:MPG port map(clk=> clk, btn => btn(2), enable=>enables(2));  -- jump
       MPG_enable4:MPG port map(clk=> clk, btn => btn(3), enable=>enables(3));  -- branch
     
     
        process(clk)
        begin
            if rising_edge(clk) then
                if enables(0) = '1' then
                    FinalJumpAdress <= ResetAdress;
                else
                     FinalJumpAdress <= JumpAdress;
            end if;
            end if;
        end process;
     
        Jump <= enables(2) or enables(0);
        IFetchClk <= enables(0) or enables(1) or enables(2) or enables(3);
        
        IFetch1: IFetch port map (JumpAdress=> FinalJumpAdress, BranchAdress=> BranchAdress, Jump=>Jump,
                                PCSrc => enables(3), PCout => PCout, Instruction=> Instruction, clk=> IFetchClk ); 
        
        UC1 : UC port map(OpCode => Instruction(15 downto 13), RegWrite => RegWrite, RegDst=>RegDst, ExtOp=>ExtOp, ALUSrc => ALUSrc,
        ALUOp => ALUOp, MemToReg => MemToReg, Jne => Jne ,Branch => Branch, MemWrite=> MemWrite);
        
        
        IDecode1: Idecode port map(RD1=> RD1, RD2=> RD2,RegWrite => RegWrite, ExtOp=> ExtOp, Instruction=> Reg1(15 downto 0),
         enable => enables(0), WD => WBData, clk => clk, Ext_imm =>Ext_imm, sa => sa, func => func );
         
         RA1 <=  Instruction(9 downto 7);
         RA2 <= Instruction(6 downto 4);
         

        EX1: EX port map(PC =>   Reg2(73 downto 58), RD1 =>  Reg2(57 downto 42), RD2 =>Reg2(41 downto 26), Ext_imm =>  Reg2(21 downto 6),
         func=> Reg2(82 downto 80), sa => Reg2(22), ALUSrc=>Reg2(79), ALUOp => Reg2(82 downto 80),
          ALURes => ALURes,ZERO => ZERO,BranchAdress => BranchAdress,RegDst => RegDst, RA1 => RA1,
          RA2 => RA2, RegDstAddress => RegDstAddress  ); 
          
          
          
        WB1: WB port map(MemToReg => MemToReg, Branch => Branch, JNE => Jne, ZeroFlag=> ZERO, JumpIn => PCout(12 downto 0), RD => RD,
        ALUResult=>ALURes, PC => PCout, WD => WBData   );
        
        MEM1: MEM port map(clk => clk,MemWrite=> Reg4(36), RA=>Reg4(18 downto 3), WD => Reg4(34 downto 19), 
        WA => Reg4(2 downto 0), RD => RD  );
        
        process(clk)
        begin
            if rising_edge(clk) then
               case sw(7 downto 5) is
               when "000" => Digits <= Instruction;
               when "001" => Digits <=PCout;
               when "010" => Digits <=RD1;
               when "011" => Digits <=RD2;
               when "100" => Digits <=Ext_imm;
               when "101" => Digits <= ALURes;
               when "110" => Digits <= RD ;
               when "111" => Digits <= WBData;
               --when "101" => Digits <= ;
               when others => null;
               end case;
            end if;
        
        end process;
     
                 
     SSD1: SSD port map(Digit =>Digits, clk => clk, AnodIn =>count , Cat => cat, AnodOut=>an);
         
 --3
 
 
--        MPG_enable1:MPG port map(clk=> clk, btn => btn(0), enable=>enables(0));  
--        MPG_enable2:MPG port map(clk=> clk, btn => btn(1), enable=>enables(1)); 
--        MPG_enable3:MPG port map(clk=> clk, btn => btn(2), enable=>enables(2));
--        reset <= enables(2);
        
--        process(clk, reset)
--        begin
--            if rising_edge(clk) then
--                if enables(0) = '1' then
--                    count <= count +1;    
--                end if;
--            end if;
            
--            if reset ='1' then
--                count <= (others =>'0');
--            end if;
                
--        end process;
        
--        process(clk)
--        begin
--            if rising_edge(clk) then
--                count1 <=count1 +1;
--             end if;
        
--        end process;
 
--        RD3 <= RD1(13 downto 0 ) & "00";
        
--        RAM1: RAM port map(clk=> clk, RA => count, WA => count,WD => RD3, RD => RD1, MemWrite => sw(0) );
--        SSD1: SSD port map(Digit =>RD1, clk => clk, AnodIn =>count1 , Cat => cat, AnodOut=>an);

end Behavioral;
