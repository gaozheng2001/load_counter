----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/04/23 15:26:08
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
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
end counter;

architecture Behavioral of counter is
type state_type is(s0, count);
signal state, state_next : state_type;
signal d1_reg, d10_reg, d100_reg: std_logic_vector (3 downto 0):="0000";
signal d1_next, d10_next, d100_next: std_logic_vector (3 downto 0):="0000";
begin
-- register
process (CLK, RESET, EN, LOAD) is
begin
    if RESET = '1' then
        state <= s0;
        d1_reg <="0000";
        d10_reg <="0000";
        d100_reg <="0000";
    elsif CLK'event and CLK='1' then
        if EN = '1' then
            if LOAD = '1' then
                state <= count;
                d1_reg <= d1_in;
                d10_reg <= d10_in;
                d100_reg <= d100_in;
            else
                state <= state_next;
                d1_reg <= d1_next;
                d10_reg <= d10_next;
                d100_reg <= d100_next;
            end if;
        end if;
    end if;
end process;

process (state, state_next, d1_in, d1_next, d1_reg, d10_in, d10_next, d10_reg, d100_in, d100_next, d100_reg) is
begin
    state_next <= count;
    d1_next <= d1_reg;
    d10_next <= d10_reg;
    d100_next <= d100_reg;
    case state is 
        when s0 => 
            d1_next <="0000";
            d10_next <="0000";
            d100_next <="0000";
            state_next <= count;
        when count => 
            if (d1_reg=9 and d10_reg=9 and d100_reg=9) then
                state_next <= s0;
            elsif (d1_reg=9 and d10_reg=9)then
                d10_next <= "0000";
                d1_next <= "0000";
                d100_next <= d100_reg + 1;
            elsif d1_reg = 9 then
                d1_next <= "0000";
                d10_next <= d10_reg + 1;
            else 
                d1_next <= d1_reg + 1;
            end if;
    end case;
end process;
-- next-state logic
--d1_next <= d1_in when LOAD = '1' else 
--           "0000" when d1_reg = 9 else d1_reg+1;
--d10_next <= d10_in when LOAD = '1' else 
--            "0000" when (d1_reg = 9 and d10_reg = 9) else
--            d10_reg+1 when d1_reg = 9 else d10_reg;
--d100_next <= d100_in when LOAD = '1'else
--             "0000" when (d1_reg=9 and d10_reg=9 and d100_reg=9) else
--             d100_reg+1 when (d1_reg=9 and d10_reg=9) else d100_reg;
-- Output logic
d1 <= d1_reg; d10 <= d10_reg; d100 <= d100_reg;
end Behavioral;
