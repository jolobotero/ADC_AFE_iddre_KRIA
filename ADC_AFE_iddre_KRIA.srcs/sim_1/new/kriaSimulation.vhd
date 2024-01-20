----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2024 10:27:50
-- Design Name: 
-- Module Name: kriaSimulation - Behavioral
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

entity kriaSimulation is
--  Port ( );
end kriaSimulation;

architecture Behavioral of kriaSimulation is

component KRIA_IDDRE is
  Port (Data_p            : in std_logic; 
        Data_n            : in std_logic;
        DCLK_p            : in std_logic;
        DCLK_n            : in std_logic;
        FCLK_p            : in std_logic;
        FCLK_n            : in std_logic;
        Rst               : in std_logic;
        Data_out          : out std_logic_vector(13 downto 0)

  );
end component;

signal Data_p            : std_logic := '0'; 
signal Data_n            : std_logic := '1';
signal DCLK_p            : std_logic := '1';
signal DCLK_n            : std_logic := '0';
signal FCLK_p            : std_logic := '1';
signal FCLK_n            : std_logic := '0';
signal Rst               : std_logic := '0';
--signal DATA_Q1           : std_logic := '0';
--signal DATA_Q2           : std_logic := '0';
--signal FCLK_Q1           : std_logic := '0';
--signal FCLK_Q2           : std_logic := '0';
signal Data_out          : std_logic_vector(13 downto 0):= "00000000000000";

begin

d: KRIA_IDDRE 
  Port map(Data_p => Data_p, 
        Data_n => Data_n,      
        DCLK_p => DCLK_p,      
        DCLK_n => DCLK_n,      
        FCLK_p => FCLK_p,      
        FCLK_n => FCLK_n,      
        Rst    => Rst,         
        Data_out  => Data_out 

  );
  
DCLK_p <= not DCLK_p after 1 ns;
FCLK_p <= not FCLK_p after 7 ns;

DCLK_n <= not DCLK_p;
FCLK_n <= not FCLK_p;

Data_n <= not Data_p;


estimulos: process
begin
   Data_p <= '1';
   rst <= '1';
   wait for 140 ns;
   rst <= '0';
   wait for 140 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 14 ns;
   
   Data_p <= '0';
   wait for 1 ns;
   Data_p <= '1';
   wait for 280 ns;
   
end process;     
end Behavioral;
