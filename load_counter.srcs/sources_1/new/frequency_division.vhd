----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:22:06
-- Design Name: 
-- Module Name: frequency_division - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency_division is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           clk_out_1hz : out std_logic);
end frequency_division;

architecture Behavioral of frequency_division is
type state_type is(s0, s1);
signal state, state_next :state_type;
signal count, count_next : std_logic_vector(23 downto 0);
constant upcount :integer:=10000000;
begin
-- register
process (CLK, RESET) is
begin
    if RESET = '1' then
        state <= s0;
        count <= (others => '0');
    elsif CLK'event and CLK='1' then
        state <= state_next;
        count <= count_next;
    end if;
end process;
process (state, state_next, count, count_next) is
begin
    clk_out_1hz <= '0';
    state_next <= s0;
    count_next <= count;
    case state is
        when s0 => 
            count_next <= (others => '0');
            clk_out_1hz <='1';
            state_next <= s1;
        when s1 => 
            if count = upcount - 2 then
                count_next <= (others => '0');
                state_next <= s0;
            else 
                count_next <= count + 1;
                state_next <= s1;
            end if;
    end case;
end process;


end Behavioral;
