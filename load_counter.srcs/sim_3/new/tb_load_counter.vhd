----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:58:23
-- Design Name: 
-- Module Name: tb_load_counter - Behavioral
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

entity tb_load_counter is
--  Port ( );
end tb_load_counter;

architecture Behavioral of tb_load_counter is
    component load_counter 
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
    end component;
    
    component frequency_division  is
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               CLK_OUT_1hz : out STD_LOGIC
        );
    end component;

    component counter 
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

    --input 
    signal CLK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal LOAD : std_logic := '0';

    signal d1_in : std_logic_vector(3 downto 0):="0010";
    signal d10_in : std_logic_vector(3 downto 0):="0010";
    signal d100_in : std_logic_vector(3 downto 0):="0010";   

    --Outputs
    signal d1 : std_logic_vector(3 downto 0):="0000";
    signal d10 : std_logic_vector(3 downto 0):="0000";
    signal d100 : std_logic_vector(3 downto 0):="0000";
    
    constant period : time := 10 ns;
begin
uut: load_counter
    port map(
        CLK => CLK,
        RESET => RESET,
        LOAD => LOAD,
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
    
    reset_process : process
    begin
        RESET <= '1';
        --for i in 1 to 2 loop
        --    wait until CLK = '1';
        --end loop;
        wait for 100 ns;
        RESET <= '0';
        wait;
    end process;

    load_process : process
    begin
        LOAD <= '1';
        wait for 5 us;
        LOAD <= '0';
        wait;
    end process;

end Behavioral;
