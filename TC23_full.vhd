
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TC23_full is
    Port ( Q: in std_logic_vector (2 downto 0);
        FULL: out std_logic );
end TC23_full;

architecture Behavioral of TC23_full is

begin

    FULL <= Q(2);

end Behavioral;
