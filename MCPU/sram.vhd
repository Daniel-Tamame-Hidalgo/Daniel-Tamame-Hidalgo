-- **********************************************
-- sram.vhd : 64K*8 Bit SRAM Memory
--            Memory Content Initialization from File
--
-- Prof. Luis A. Aranda
--
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity sram is
    generic ( init_file_name : string := "C:\Vivado\mcpu\mcpu.srcs\counter.dat");    -- Initial Memory Content File
    port ( addr : in std_logic_vector(5 downto 0);      -- Memory Address
           data : inout std_logic_vector(7 downto 0);   -- Input/Output Data
           nwe  : in std_logic;                         -- Not Write  Enable
           noe  : in std_logic                          -- Not Output Enable 
    );
end sram;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of sram is
begin
    process
        constant low_addr  : natural := 0;
        constant high_addr : natural := 65535;  -- 64K SRAM
        type memory_array is array (natural range low_addr to high_addr) of std_logic_vector(7 downto 0);
        variable mem : memory_array;
        variable address : natural;
        variable L : line;
        
        -- Procedure to Initialize Memory Content Reading from File
        procedure load ( mem : out memory_array ) is
            file binary_file : text is in init_file_name;
            variable L : line;
            variable add : natural := 0;
            variable input_data : std_logic_vector(7 downto 0);
        begin
            while not endfile(binary_file) loop
                readline(binary_file, L);
                hread(L, input_data);
                mem(add) := input_data;
                add := add + 1;
            end loop;
        end load;
    begin
        -- Call Load Procedure
        load(mem);
        data <= "ZZZZZZZZ";
        -- Process Memory Cycles
        loop
            -- Decode Address
            address := conv_integer(addr);
            if (nwe = '0') then
                -- Write Cycle
                mem(address) := data(7 downto 0);
                data <= "ZZZZZZZZ";
            elsif (nwe = '1') then 
                -- Read Cycle
                if (noe = '0') then
                    data <= mem(address);
                else 
                    data <= "ZZZZZZZZ";
                end if;
            else
                data <= "ZZZZZZZZ";
            end if;
            wait on nwe, noe, addr, data;
        end loop;
    end process;
end Behavioral;
