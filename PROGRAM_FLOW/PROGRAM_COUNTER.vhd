-----------------------------------------------------------------PROGRAM_COUNTER

library UTILITIES;

entity PROGRAM_COUNTER is
	port (
	CLK : in BIT;
	RESET : in BIT;
	CHIP_SELECT : in BIT;
	JUMP_ADDRESS : in BIT_VECTOR(7 downto 0);
	--CURRENT_ADDRESS : out BIT_VECTOR(7 downto 0);
	NEXT_INSTRUCTION_ADDRESS : out BIT_VECTOR(7 downto 0)
	);
end PROGRAM_COUNTER;

architecture AR_PROGRAM_COUNTER of PROGRAM_COUNTER is

component COUNTER
	port (
	RESET : in BIT;
	CLK : in BIT;
	CHIP_SELECT : in BIT;
	PARALEL_LOAD : in BIT_VECTOR (3 downto 0);
	Q : buffer BIT_VECTOR (3 downto 0);
	CARRY : out BIT
	);
end component;

component MUX2_1
	port (
	I0, I1 : in BIT;
	SELECTION : in BIT;
	O : out BIT
	);
end component;

component MUX8_1
	port (
	I0, I1 : in BIT_VECTOR (3 downto 0);
	SELECTION : in BIT;
	O : out BIT_VECTOR (3 downto 0)
	);
end component;

signal COUNTER0_CHIP_SELECT, COUNTER1_CHIP_SELECT : BIT;
signal COUNTER1_PARALEL_LOAD : BIT_VECTOR (3 downto 0);
signal COUNTER0_CARRY, COUNTER1_CARRY : BIT;
signal Q : BIT_VECTOR (7 downto 0);

begin
	
	COUNTER0_CHIP_SELECT <= CHIP_SELECT;
	MUX1 : entity UTILITIES.MUX2_1(AR_MUX2_1) port map ('0', COUNTER0_CARRY, CHIP_SELECT, COUNTER1_CHIP_SELECT);
	MUX2 : entity UTILITIES.MUX8_1(AR_MUX8_1) port map (JUMP_ADDRESS(7 downto 4), Q(7 downto 4), CHIP_SELECT, COUNTER1_PARALEL_LOAD);
	COUNTER0 : COUNTER port map (RESET, CLK, COUNTER0_CHIP_SELECT, JUMP_ADDRESS(3 downto 0), Q(3 downto 0), COUNTER0_CARRY);
	COUNTER1 : COUNTER port map (RESET, CLK, COUNTER1_CHIP_SELECT, COUNTER1_PARALEL_LOAD, Q(7 downto 4), COUNTER1_CARRY);
	--CURRENT_ADDRESS <= Q;
	NEXT_INSTRUCTION_ADDRESS <= Q;
	
end AR_PROGRAM_COUNTER;	 

-----------------------------------------------------------------END 