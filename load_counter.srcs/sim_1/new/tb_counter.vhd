----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:29:40
-- Design Name: 
-- Module Name: tb_counter - Behavioral
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_counter is
--  Port ( );
end tb_counter;

architecture Behavioral of tb_counter is
    component counter
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           EN : in std_logic;
           d1_in : in STD_LOGIC_VECTOR (3 downto 0);
           d10_in : in STD_LOGIC_VECTOR (3 downto 0);
           d100_in : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : out STD_LOGIC_VECTOR (3 downto 0);
           d10 : out STD_LOGIC_VECTOR (3 downto 0);
           d100 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    --Inputs
    signal CLK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal LOAD : std_logic := '0';
    signal EN : std_logic := '1';

    signal d1_in : std_logic_vector(3 downto 0):="0010";
    signal d10_in : std_logic_vector(3 downto 0):="0010";
    signal d100_in : std_logic_vector(3 downto 0):="0010";   

    --Outputs
    signal d1 : std_logic_vector(3 downto 0):="0000";
    signal d10 : std_logic_vector(3 downto 0):="0000";
    signal d100 : std_logic_vector(3 downto 0):="0000";
    
    constant period : time := 100 ns;
begin

    uut : counter
    port map(
    CLK => CLK,
    RESET => RESET,
    LOAD => LOAD,
    EN => EN,
    d1_in => d1_in,
    d10_in => d10_in,
    d100_in => d100_in,
    d1 => d1,
    d10 => d10,
    d100 => d100
    );

    clock_gen: process
    begin
        CLK <= '0';
        wait for period/2;
        CLK <= '1';
        wait for period/2;
    end process;
    
    en_gen: process
    begin
        EN <= '0';
        wait for 9*period;
        EN <= '1';
        wait for period;
    end process;
    
    reset_process : process
    begin
        RESET <= '1';
        for i in 1 to 2 loop
            wait until CLK = '1';
        end loop;
        RESET <= '0';
        wait;
    end process;

    load_process : process
    begin
        LOAD <= '1';
        wait for 30*period;
        LOAD <= '0';
        wait;
    end process;

end Behavioral;
