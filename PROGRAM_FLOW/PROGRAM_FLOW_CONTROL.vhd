library IEEE;			 
use IEEE.NUMERIC_BIT.all;

-----------------------------------------------------------------PROGRAM_FLOW_CONTROL

library MICROCONTROLLER_DESIGN;
library UTILITIES;

entity PROGRAM_FLOW_CONTROL is
	port (
	CLK : in BIT;
	RESET : in BIT;
	--CHIP_SELECT : in BIT;
	COMAND : in BIT_VECTOR (1 downto 0);
	CONDITION_OF_COMAND: in BIT_VECTOR (2 downto 0);
	FLAGS_REG : in BIT_VECTOR (1 downto 0);
	INSTRUCTION_ADDRESS : in BIT_VECTOR(7 downto 0);
	NEXT_INSTRUCTION_ADDRESS : out BIT_VECTOR(7 downto 0)
	);
end PROGRAM_FLOW_CONTROL;

architecture AR_PROGRAM_FLOW_CONTROL of PROGRAM_FLOW_CONTROL is

component STATE_SELECTOR
	port (
	CLK : in BIT;
	RESET : in BIT;
	SET : in BIT;
	STATE : out BIT;
	NOT_STATE : out BIT
	);
end component; 

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

component PROGRAM_COUNTER_STACK
	port (
	CLK : in BIT;
	RESET : in BIT;
	STATE : in BIT;
	CHIP_SELECT : in BIT_VECTOR(1 downto 0);
	PUSH_ADDRESS: in BIT_VECTOR(7 downto 0);
	POP_ADDRESS: out BIT_VECTOR(7 downto 0)
	);
end component;

signal STATE, NOT_STATE : BIT;
signal SET : BIT := '0';
signal COUNTER_CLK : BIT;
signal CURRENT_ADDRESS : BIT_VECTOR(7 downto 0);
signal JUMP_ADDRESS : BIT_VECTOR(7 downto 0);
signal POP_ADDRESS : BIT_VECTOR(7 downto 0);
signal STACK_CS : BIT_VECTOR(1 downto 0) := "00";
signal COUNTER_CS : BIT;

begin
	S_S : entity MICROCONTROLLER_DESIGN.STATE_SELECTOR(AR_STATE_SELECTOR) port map (CLK, '1', SET, STATE, NOT_STATE);
	
	process (CLK, STATE)
	begin
		if (RESET = '0' and CLK = '1' and CLK'EVENT) then
			SET <= '0'; --SETARE STARE PE 1
		else
			SET <= '1';
		end if;
		if (STATE = '0' and CLK = '0' and RESET = '1') then
			if ( not(CONDITION_OF_COMAND(2)) or ( not(CONDITION_OF_COMAND(1)) and ( CONDITION_OF_COMAND(0) xor FLAGS_REG(1) ) ) or ( CONDITION_OF_COMAND(1) and ( CONDITION_OF_COMAND(0) xor FLAGS_REG(0) ) ) ) = '1' then	
				case COMAND is
					when "10" => 
						COUNTER_CS <= '1';
						STACK_CS <= COMAND;
					when "01" => 
						COUNTER_CS <= '0';
						JUMP_ADDRESS <= INSTRUCTION_ADDRESS;
						STACK_CS <= COMAND;
					when "11" => 
						COUNTER_CS <= '0';
						JUMP_ADDRESS <= INSTRUCTION_ADDRESS; 
						STACK_CS <= COMAND;
					when "00" => 
						COUNTER_CS <= '0';
						JUMP_ADDRESS <= POP_ADDRESS;
						STACK_CS <= COMAND;
				end case; 
			else
				COUNTER_CS <= '1';
				STACK_CS <= "10";
			end if;
		end if;
	end process;
	AND_GATE : entity UTILITIES.AND4(AR_AND4) port map (CLK, NOT_STATE, '1', '1', COUNTER_CLK);
	P_C : PROGRAM_COUNTER port map (COUNTER_CLK, RESET, COUNTER_CS, JUMP_ADDRESS, CURRENT_ADDRESS);
	P_S_C : PROGRAM_COUNTER_STACK port map (CLK, RESET, STATE, STACK_CS, CURRENT_ADDRESS, POP_ADDRESS);
	NEXT_INSTRUCTION_ADDRESS <= CURRENT_ADDRESS;
	
end AR_PROGRAM_FLOW_CONTROL;


-------------------------------------------------------------------END