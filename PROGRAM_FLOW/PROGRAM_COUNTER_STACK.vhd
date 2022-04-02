library IEEE;			 
use IEEE.NUMERIC_BIT.all;

-----------------------------------------------------------------PROGRAM_COUNTER_STACK

library RAM_MEMORY;
library	UTILITIES;

entity PROGRAM_COUNTER_STACK is
	port (
	CLK : in BIT;
	RESET : in BIT;
	STATE : in BIT;
	CHIP_SELECT : in BIT_VECTOR(1 downto 0);
	PUSH_ADDRESS: in BIT_VECTOR(7 downto 0);
	POP_ADDRESS: out BIT_VECTOR(7 downto 0)
	);
end PROGRAM_COUNTER_STACK;

architecture AR_PROGRAM_COUNTER_STACK of PROGRAM_COUNTER_STACK is

component PROGRAM_COUNTER
	port (
	CLK : in BIT;
	RESET : in BIT;
	CHIP_SELECT : in BIT;
	JUMP_ADDRESS : in BIT_VECTOR(7 downto 0);
	--CURRENT_ADDRESS : out BIT_VECTOR(7 downto 0);
	NEXT_INSTRUCTION_ADDRESS : out BIT_VECTOR(7 downto 0)
	);
end component;

signal NOT_CLK, NOT_STATE : BIT;
signal COUNTER_CS, WRITE_STROBE : BIT;
signal COUNTER_ADDRESS, MEMORY_DATA_OUT : BIT_VECTOR (7 downto 0);
signal STACK_POINTER : INTEGER range 0 to 15;

begin
	INV : entity UTILITIES.INVERSOR(AR_INVERSOR) port map (CLK, NOT_CLK);
	INV2 : entity UTILITIES.INVERSOR(AR_INVERSOR) port map (STATE, NOT_STATE);
	AND_GATE1 : entity UTILITIES.AND2(AR_AND2) port map (RESET, STATE, COUNTER_CS);
	INCREMENT_ADDRESS : PROGRAM_COUNTER port map (NOT_CLK, RESET, COUNTER_CS, PUSH_ADDRESS, COUNTER_ADDRESS);
	AND_GATE2 : entity UTILITIES.AND4(AR_AND4) port map (CHIP_SELECT(1), CHIP_SELECT(0), NOT_STATE, '1', WRITE_STROBE);
	POINTER : process (STATE, CLK)
	begin
		if (RESET = '0') then
			STACK_POINTER <= 15;
		elsif (STATE = '0' and STATE'EVENT and CLK = '0') then
			if (CHIP_SELECT(1) and CHIP_SELECT(0)) = '1' then
				STACK_POINTER <= STACK_POINTER - 1;
			end if;
		elsif (STATE = '0' and CLK = '1' and CLK'EVENT) then
			if (CHIP_SELECT(1) or CHIP_SELECT(0)) = '0' then
				STACK_POINTER <= STACK_POINTER + 1;
			end if;
		end if;
	end process POINTER;
	STACK_MEMORY : entity RAM_MEMORY.STACK_RAM_MEMORY(AR_STACK_RAM_MEMORY) port map (CLK, WRITE_STROBE, STACK_POINTER, COUNTER_ADDRESS, POP_ADDRESS);
	
	

end AR_PROGRAM_COUNTER_STACK;
-----------------------------------------------------------------END