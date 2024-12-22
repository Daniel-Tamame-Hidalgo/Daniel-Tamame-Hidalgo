-- **********************************************
-- mcpu.vhd : Simple 8-bit CPU
--
-- Prof. Luis A. Aranda
--
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity mcpu is
    port ( clk  : in  std_logic;                       -- Clock
           rst  : in  std_logic;                       -- Reset
           data : inout std_logic_vector(7 downto 0);  -- Databus
           addr : out std_logic_vector(5 downto 0);    -- Address
           oe   : out std_logic;                       -- Output Enable
           we   : out std_logic                        -- Write Enable
    );
end;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of mcpu is
    -- Declare Signals
    signal accumulator : std_logic_vector(8 downto 0);
    alias carry  is accumulator(8);
    alias result is accumulator(7 downto 0);
    alias opcode is data(7 downto 6);

    signal addr_reg : std_logic_vector(5 downto 0);
    signal pc : std_logic_vector(5 downto 0);

    type cpu_state_type is (FETCH, WR_MEM, ALU_ADD, ALU_NOR, BRANCH_NOT_TAKEN);
    signal cpu_state : cpu_state_type;
begin
    process (clk, rst) begin
        if (rst = '1') then
            --> COMPLETAR
        elsif rising_edge(clk) then
            -- Address path
            if (cpu_state = FETCH) then
                --> COMPLETAR
            else
                --> COMPLETAR
            end if;

            -- Datapath
            case cpu_state is
                when ALU_ADD =>
                    accumulator <= ('0' & result) + ('0' & data);
                when ALU_NOR =>
                    --> COMPLETAR
                when BRANCH_NOT_TAKEN =>
                    --> COMPLETAR
                when others => null;
            end case;

            -- State Machine
            if (cpu_state /= FETCH) then
                --> COMPLETAR
            elsif (opcode = "11" and carry = '1') then
                --> COMPLETAR
            else
                case opcode is
                    --> COMPLETAR
                end case;
            end if;
        end if;
    end process;

    -- Assign Output Signals
    addr <= addr_reg;
    data <= result when (cpu_state = WR_MEM) else (others => 'Z');

    -- Signals for SRAM Memory Control
    -- Output enable is active low
    oe <= '1' when (clk = '1' or cpu_state = WR_MEM or rst = '1' or cpu_state = BRANCH_NOT_TAKEN) else '0';

    -- Write enable is active low
    we <= '1' when (clk = '1' or cpu_state /= WR_MEM or rst = '1') else '0';
end Behavioral;
