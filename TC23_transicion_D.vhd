

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TC23_transicion_D is
    Port ( Q: in std_logic_vector(2 downto 0);
        T_OUT: in std_logic;
        D: out std_logic_vector(2 downto 0)
         );
end TC23_transicion_D;

architecture Behavioral of TC23_transicion_D is

begin

    D(2) <= Q(2) or (Q(1) and Q(0) and T_OUT);
    D(1) <= (Q(1) and not(Q(0))) or (Q(1) and not(T_OUT)) or (not(Q(1)) and Q(0) and T_OUT);
    D(0) <= (Q(0) and not(T_OUT)) or (not(Q(2)) and not(Q(0)) and T_OUT);

end Behavioral;
