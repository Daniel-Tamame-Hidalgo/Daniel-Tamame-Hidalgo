
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TC23_FSM_D is
    Port (COIN_IN: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        TICKET_OUT: out std_logic );
end TC23_FSM_D;

architecture Behavioral of TC23_FSM_D is
    
    component TC23_FSM_D_count
        Port (RST: in std_logic;
        CLK: in std_logic;
        TICKET_OUT: in std_logic; 
        FULL: out std_logic);
    end component;
    
    type estados is(S0,S1);
    signal current_state, next_state: estados;
    signal full, ticket: std_logic;
begin

    Contador: TC23_FSM_D_count port map(RST=>RST, CLK=>CLK, TICKET_OUT=>ticket, FULL=>full);

    process (CLK) begin
        if (rising_edge(CLK)) then
            if (RST='1') then
                current_state <= S0;
            else
                current_state <= next_state;
            end if;
        end if;
    end process;
    
    process (current_state, COIN_IN) begin
        case current_state is
            when S0 =>
                ticket <= '0';
                if (COIN_IN='1' and full='0') then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1=>
                ticket <= '1';
                if (COIN_IN='1' and full='0') then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when others =>
                ticket <= '0';
                next_state <= S0;
        end case;
    end process;
    
    TICKET_OUT <= ticket;

end Behavioral;
