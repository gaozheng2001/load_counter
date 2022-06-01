----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:39:06
-- Design Name: 
-- Module Name: load_counter - Behavioral
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

entity load_counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           d1_in : in STD_LOGIC_VECTOR (3 downto 0);
           d10_in : in STD_LOGIC_VECTOR (3 downto 0);
           d100_in : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : out STD_LOGIC_VECTOR (3 downto 0);
           d10 : out STD_LOGIC_VECTOR (3 downto 0);
           d100 : out STD_LOGIC_VECTOR (3 downto 0)
     );
end load_counter;

architecture Behavioral of load_counter is
component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out_10M          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  clk_in           : in     std_logic
 );
end component;

component frequency_division  is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_OUT_1hz : out STD_LOGIC);
end component;

component counter is
port(
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           EN : in std_logic;
           d1_in : in STD_LOGIC_VECTOR (3 downto 0);
           d10_in : in STD_LOGIC_VECTOR (3 downto 0);
           d100_in : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : out STD_LOGIC_VECTOR (3 downto 0);
           d10 : out STD_LOGIC_VECTOR (3 downto 0);
           d100 : out STD_LOGIC_VECTOR (3 downto 0)
);
end component;

signal clk_out_10M : std_logic;
signal clk_out_1 : std_logic;
begin
down_clk_pro : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out_10M => clk_out_10M,
  -- Status and control signals                
   reset => RESET,
   -- Clock in ports
   clk_in => CLK
 );

freq_division: frequency_division
    port map(
        CLK => clk_out_10M,
        RESET => RESET,
        CLK_OUT_1hz => clk_out_1
    );
 
 counters : counter
    port map (
    CLK => clk_out_10M,
    RESET => RESET,
    LOAD => LOAD,
    EN => clk_out_1,
    d1_in => d1_in,
    d10_in => d10_in,
    d100_in => d100_in,
    d1 => d1,
    d10 => d10,
    d100 => d100
);

end Behavioral;
