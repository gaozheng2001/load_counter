----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:32:45
-- Design Name: 
-- Module Name: tb_frequency_division - Behavioral
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

entity tb_frequency_division is
--  Port ( );
end tb_frequency_division;

architecture Behavioral of tb_frequency_division is
    component frequency_division 
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           clk_out_1hz : out std_logic);
    end component;
    --Inputs
    signal CLK : std_logic := '0';
    signal RESET : std_logic := '0';

    --Outputs
    signal clk_out_1hz : std_logic:='0';
    
    constant period : time := 100 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: frequency_division PORT MAP (
        CLK => CLK,
        RESET => RESET,
        clk_out_1hz => clk_out_1hz
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
        for i in 1 to 2 loop
            wait until CLK = '1';
        end loop;
        RESET <= '0';
        wait;
    end process;
    
    --monitor : process
    --constant n : integer := 1000;
    --variable number : integer range 0 to 999 :=0;
    --begin
    --    wait until reset <= '0';
    --    wait for 1 ns;
    --    for i in 0 to n loop
    --       number := to_integer(unsigned(d100))*100+to_integer(unsigned(d10))*10+to_integer(unsigned(d1));
    --        assert number = i mod n
    --        report "count of " & integer'image(i mod n) & " failed"
    --        severity error;
    --        wait until clk = '1';
    --        wait for 1 ns;
    --    end loop;
    --    wait;
    --end process;

end Behavioral;
