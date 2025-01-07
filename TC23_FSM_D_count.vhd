

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TC23_FSM_D_count is
    Port (RST: in std_logic;
    CLK: in std_logic;
    TICKET_OUT: in std_logic; 
    FULL: out std_logic);
end TC23_FSM_D_count;

architecture Behavioral of TC23_FSM_D_count is

    component TC23_ffD 
        Port  (CLK: in std_logic;
        RST: in std_logic;
        D: in std_logic;
        Q: out std_logic );
    end component;
    
    component TC23_full
        Port ( Q: in std_logic_vector (2 downto 0);
        FULL: out std_logic );
    end component;
    
    component TC23_transicion_D
        Port ( Q: in std_logic_vector(2 downto 0);
        T_OUT: in std_logic;
        D: out std_logic_vector(2 downto 0)
         );
    end component;

    signal current_state, next_state: std_logic_vector (2 downto 0);
begin
    Transicion:  TC23_transicion_D port map ( Q => current_state, T_OUT => TICKET_OUT, D => next_state);
    Salida: TC23_full port map (Q => current_state, FULL => FULL);
    FlipFlop_2:  TC23_ffD port map ( CLK => CLK, RST => RST, D => next_state(2), Q => current_state(2));
    FlipFlop_1:  TC23_ffD port map ( CLK => CLK, RST => RST, D => next_state(1), Q => current_state(1));
    FlipFlop_0:  TC23_ffD port map ( CLK => CLK, RST => RST, D => next_state(0), Q => current_state(0));

end Behavioral;
