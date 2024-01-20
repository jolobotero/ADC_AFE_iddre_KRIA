----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2024 18:34:48
-- Design Name: 
-- Module Name: data_iserdese3 - Behavioral
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
Library UNISIM;
use UNISIM.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity KRIA_IDDRE is
  Port (Data_p            : in std_logic; 
        Data_n            : in std_logic;
        DCLK_p            : in std_logic;
        DCLK_n            : in std_logic;
        FCLK_p            : in std_logic;
        FCLK_n            : in std_logic;
        Rst               : in std_logic;
        Data_out          : out std_logic_vector(13 downto 0)
        

  );
end KRIA_IDDRE;

architecture Behavioral of KRIA_IDDRE is

signal DataOut                   : std_logic;
signal FCLKOut                   : std_logic;
signal CLKFBOUTInt               : std_logic;
signal DCLKOut                   : std_logic;
signal DCLKINT                   : std_logic;
signal CLKFBOUTIntOut            : std_logic;
signal DCLKIDDREINT              : std_logic;

signal FCLK_Q1_INT               : std_logic;
signal FCLK_Q2_INT               : std_logic;
signal DATA_Q1_INT               : std_logic;
signal DATA_Q2_INT               : std_logic;

signal D_INT                     : std_logic_vector(13 downto 0);
signal Data_trans                : std_logic_vector(13 downto 0);
signal DATA_Q1                   : std_logic;
signal DATA_Q2                   : std_logic;
signal FCLK_Q1                   : std_logic;
signal FCLK_Q2                   : std_logic;

signal D_transQ1                 : std_logic_vector(6 downto 0);        
signal D_transQ2                 : std_logic_vector(6 downto 0);
signal contadorQ1                : integer;
signal contadorQ2                : integer;
        

begin

IBUFDS_inst_data : IBUFDS
port map (
O => DataOut, -- 1-bit output: Buffer output
I => Data_p, -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
IB => Data_n -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
); 

IBUFDS_inst_FCLK : IBUFDS
port map (
O => FCLKOut, -- 1-bit output: Buffer output
I => FCLK_p, -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
IB => FCLK_n -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
); 

IBUFDS_inst_DCLK : IBUFDS
port map (
O => DCLKINT, -- 1-bit output: Buffer output
I => DCLK_p, -- 1-bit input: Diff_p buffer input (connect directly to top-level port)
IB => DCLK_n -- 1-bit input: Diff_n buffer input (connect directly to top-level port)
); 


BUFG_inst_BCLK : BUFG
port map (
O => CLKFBOUTIntOut, -- 1-bit output: Clock output.
I => CLKFBOUTInt -- 1-bit input: Clock input.
);


MMCME3_BASE_inst : MMCME3_BASE
generic map (
BANDWIDTH => "OPTIMIZED", -- Jitter programming (HIGH, LOW, OPTIMIZED)
CLKFBOUT_MULT_F => 2.0, -- Multiply value for all CLKOUT (2.000-64.000)
CLKFBOUT_PHASE => 150.0, -- Phase offset in degrees of CLKFB (-360.000-360.000)
CLKIN1_PERIOD => 2.0, -- Input clock period in ns units, ps resolution (i.e., 33.333 is 30 MHz).
CLKOUT0_DIVIDE_F => 2.0, -- Divide amount for CLKOUT0 (1.000-128.000)
-- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
CLKOUT0_DUTY_CYCLE => 0.5,
CLKOUT1_DUTY_CYCLE => 0.5,
CLKOUT2_DUTY_CYCLE => 0.5,
CLKOUT3_DUTY_CYCLE => 0.5,
CLKOUT4_DUTY_CYCLE => 0.5,
CLKOUT5_DUTY_CYCLE => 0.5,
CLKOUT6_DUTY_CYCLE => 0.5,
-- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
CLKOUT0_PHASE => 0.0,
CLKOUT1_PHASE => 0.0,
CLKOUT2_PHASE => 0.0,
CLKOUT3_PHASE => 0.0,
CLKOUT4_PHASE => 0.0,
CLKOUT5_PHASE => 0.0,
CLKOUT6_PHASE => 0.0,
-- CLKOUT1_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
CLKOUT1_DIVIDE => 1,
CLKOUT2_DIVIDE => 1,
CLKOUT3_DIVIDE => 1,
CLKOUT4_DIVIDE => 1,
CLKOUT5_DIVIDE => 1,
CLKOUT6_DIVIDE => 1,
CLKOUT4_CASCADE => "FALSE", -- Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
DIVCLK_DIVIDE => 1, -- Master division value (1-106)
-- Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
IS_CLKFBIN_INVERTED => '0', -- Optional inversion for CLKFBIN
IS_CLKIN1_INVERTED => '0', -- Optional inversion for CLKIN1
IS_PWRDWN_INVERTED => '0', -- Optional inversion for PWRDWN
IS_RST_INVERTED => '0', -- Optional inversion for RST
REF_JITTER1 => 0.0, -- Reference input jitter in UI (0.000-0.999)
STARTUP_WAIT => "FALSE" -- Delays DONE until MMCM is locked (FALSE, TRUE)
)
port map (
-- Clock Outputs outputs: User configurable clock outputs
CLKOUT0 => DCLKOut, -- 1-bit output: CLKOUT0
CLKOUT0B => open, -- 1-bit output: Inverted CLKOUT0
CLKOUT1 => open, -- 1-bit output: CLKOUT1
CLKOUT1B => open, -- 1-bit output: Inverted CLKOUT1
CLKOUT2 => open, -- 1-bit output: CLKOUT2
CLKOUT2B => open, -- 1-bit output: Inverted CLKOUT2
CLKOUT3 => open, -- 1-bit output: CLKOUT3
CLKOUT3B => open, -- 1-bit output: Inverted CLKOUT3
CLKOUT4 => open, -- 1-bit output: CLKOUT4
CLKOUT5 => open, -- 1-bit output: CLKOUT5
CLKOUT6 => open, -- 1-bit output: CLKOUT6
-- Feedback outputs: Clock feedback ports
CLKFBOUT => CLKFBOUTInt, -- 1-bit output: Feedback clock
CLKFBOUTB => open, -- 1-bit output: Inverted CLKFBOUT
-- Status Ports outputs: MMCM status ports
LOCKED => open, -- 1-bit output: LOCK
-- Clock Inputs inputs: Clock input
CLKIN1 => DCLKINT, -- 1-bit input: Clock
-- Control Ports inputs: MMCM control ports
PWRDWN => '0', -- 1-bit input: Power-down                                  
RST => RST, -- 1-bit input: Reset
-- Feedback inputs: Clock feedback ports
CLKFBIN => CLKFBOUTIntOut  -- 1-bit input: Feedback clock
);   

BUFG_inst_DCLKInt : BUFG
port map (
O => DCLKIDDREINT, -- 1-bit output: Clock output.
I => DCLKOut -- 1-bit input: Clock input.
);
          
          
IDDRE1_inst_DATA : IDDRE1
generic map (
DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
IS_CB_INVERTED => '1', -- Optional inversion for CB
IS_C_INVERTED => '0' -- Optional inversion for C
)
port map (
Q1 => DATA_Q1_INT, -- 1-bit output: Registered parallel output 1
Q2 => DATA_Q2_INT, -- 1-bit output: Registered parallel output 2
C => DCLKIDDREINT, -- 1-bit input: High-speed clock
CB => DCLKIDDREINT, -- 1-bit input: Inversion of High-speed clock C
D => DataOut, -- 1-bit input: Serial Data Input
R => Rst -- 1-bit input: Active-High Async Reset
);     

IDDRE1_inst_FCLK : IDDRE1
generic map (
DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
IS_CB_INVERTED => '1', -- Optional inversion for CB
IS_C_INVERTED => '0' -- Optional inversion for C
)
port map (
Q1 => FCLK_Q1_INT, -- 1-bit output: Registered parallel output 1
Q2 => FCLK_Q2_INT, -- 1-bit output: Registered parallel output 2
C => DCLKIDDREINT, -- 1-bit input: High-speed clock
CB => DCLKIDDREINT, -- 1-bit input: Inversion of High-speed clock C
D => FCLKOut, -- 1-bit input: Serial Data Input
R => Rst -- 1-bit input: Active-High Async Reset
);    


FDRE_inst_DATAQ1 : FDRE
generic map (
INIT => '0', -- Initial value of register, '0', '1'
-- Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion 
IS_C_INVERTED => '0', -- Optional inversion for C
IS_D_INVERTED => '0', -- Optional inversion for D
IS_R_INVERTED => '0' -- Optional inversion for R
)
port map (
Q => DATA_Q1, -- 1-bit output: Data
C => DCLKIDDREINT, -- 1-bit input: Clock
CE => '1', -- 1-bit input: Clock enable
D => DATA_Q1_INT, -- 1-bit input: Data
R => Rst -- 1-bit input: Synchronous reset
);    

FDRE_inst_DATAQ2 : FDRE
generic map (
INIT => '0', -- Initial value of register, '0', '1'
-- Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion 
IS_C_INVERTED => '1', -- Optional inversion for C
IS_D_INVERTED => '0', -- Optional inversion for D
IS_R_INVERTED => '0' -- Optional inversion for R
)
port map (
Q => DATA_Q2, -- 1-bit output: Data
C => DCLKIDDREINT, -- 1-bit input: Clock
CE => '1', -- 1-bit input: Clock enable
D => DATA_Q2_INT, -- 1-bit input: Data
R => Rst -- 1-bit input: Synchronous reset
);    



FDRE_inst_FCLKQ1 : FDRE
generic map (
INIT => '0', -- Initial value of register, '0', '1'
-- Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion 
IS_C_INVERTED => '0', -- Optional inversion for C
IS_D_INVERTED => '0', -- Optional inversion for D
IS_R_INVERTED => '0' -- Optional inversion for R
)
port map (
Q => FCLK_Q1, -- 1-bit output: Data
C => DCLKIDDREINT, -- 1-bit input: Clock
CE => '1', -- 1-bit input: Clock enable
D => FCLK_Q1_INT, -- 1-bit input: Data
R => Rst -- 1-bit input: Synchronous reset
);    

FDRE_inst_FCLKQ2 : FDRE
generic map (
INIT => '0', -- Initial value of register, '0', '1'
-- Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion 
IS_C_INVERTED => '1', -- Optional inversion for C
IS_D_INVERTED => '0', -- Optional inversion for D
IS_R_INVERTED => '0' -- Optional inversion for R
)
port map (
Q => FCLK_Q2, -- 1-bit output: Data
C => DCLKIDDREINT, -- 1-bit input: Clock
CE => '1', -- 1-bit input: Clock enable
D => FCLK_Q2_INT, -- 1-bit input: Data
R => Rst -- 1-bit input: Synchronous reset
);    

data1: process(DCLKIDDREINT,Rst)
begin
   if Rst = '1' then 
--      D_INT(13) <= '0';
--      D_INT(11) <= '0';
--      D_INT(9)  <= '0';
--      D_INT(7)  <= '0';
--      D_INT(5)  <= '0';
--      D_INT(3)  <= '0';
--      D_INT(1)  <= '0';
     D_INT <= "00000000000000";
   elsif rising_edge(DCLKIDDREINT) then
      D_INT(1)   <= DATA_Q1;
      D_INT(3)   <= D_INT(1);
      D_INT(5)   <= D_INT(3);
      D_INT(7)   <= D_INT(5);
      D_INT(9)   <= D_INT(7);
      D_INT(11)  <= D_INT(9);
      D_INT(13)  <= D_INT(11); 
      D_INT(0)   <= DATA_Q2;
      D_INT(2)   <= D_INT(0);
      D_INT(4)   <= D_INT(2);
      D_INT(6)   <= D_INT(4);
      D_INT(8)   <= D_INT(6);
      D_INT(10)  <= D_INT(8);
      D_INT(12)  <= D_INT(10);
   end if;
end process;      

--data2: process(DCLKIDDREINT,Rst)
--begin
--   if Rst = '1' then 
--      D_INT(12) <= '0';
--      D_INT(10) <= '0';
--      D_INT(8)  <= '0';
--      D_INT(6)  <= '0';
--      D_INT(4)  <= '0';
--      D_INT(2)  <= '0';
--      D_INT(0)  <= '0';
--      D_transQ2 <= "0000000";
--      contadorQ2 <= 0;
--   elsif falling_edge(DCLKIDDREINT) then
--      D_INT(0)   <= DATA_Q2;
--      D_INT(2)   <= D_INT(0);
--      D_INT(4)   <= D_INT(2);
--      D_INT(6)   <= D_INT(4);
--      D_INT(8)   <= D_INT(6);
--      D_INT(10)  <= D_INT(8);
--      D_INT(12)  <= D_INT(10);
--      if contadorQ2 >= 6 then
--         contadorQ2 <= 0;
--         D_transQ2   <= D_INT(12) & D_INT(10) & D_INT(8) & D_INT(6) & D_INT(4) & D_INT(2) & D_INT(0);
--      else
--         contadorQ2 <= contadorQ2 + 1;
--      end if;  
--   end if;
--end process;

datoOut: process(FCLK_Q1)
begin
    if rising_edge(FCLK_Q1) then
--        Data_trans(13) <= D_INT(13);
--        Data_trans(11) <= D_INT(11);
--        Data_trans(9)  <= D_INT(9);
--        Data_trans(7)  <= D_INT(7);
--        Data_trans(5)  <= D_INT(5);
--        Data_trans(3)  <= D_INT(3);
--        Data_trans(1)  <= D_INT(1);
        Data_out       <= D_INT;
--          Data_out(13)   <= D_transQ1(6);
--          Data_out(12)   <= D_transQ2(6);
--          Data_out(11)   <= D_transQ1(5);
--          Data_out(10)   <= D_transQ2(5);
--          Data_out(9)   <= D_transQ1(4);
--          Data_out(8)   <= D_transQ2(4);
--          Data_out(7)   <= D_transQ1(3);
--          Data_out(6)   <= D_transQ2(3);
--          Data_out(5)   <= D_transQ1(2);
--          Data_out(4)   <= D_transQ2(2);
--          Data_out(3)   <= D_transQ1(1);
--          Data_out(2)   <= D_transQ2(1);
--          Data_out(1)   <= D_transQ1(0);
--          Data_out(0)   <= D_transQ2(0);
          
          
          
    end if;
end process;        
                               
end Behavioral;
