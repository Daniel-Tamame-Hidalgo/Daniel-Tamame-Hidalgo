
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TC23_ffD is
    Port (CLK: in std_logic;
        RST: in std_logic;
        D: in std_logic;
        Q: out std_logic );
end TC23_ffD;

architecture Behavioral of TC23_ffD is

begin
    process (CLK) begin
        if (rising_edge(CLK)) then
            if(RST='1') then
                Q<='0';
            else
                Q<=D;
            end if;
        end if;
    end process;
end Behavioral;