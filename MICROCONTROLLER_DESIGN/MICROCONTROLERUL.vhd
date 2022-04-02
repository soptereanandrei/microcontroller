	 	
----------------------MICROCONTROLLER
library IEEE;
use IEEE.NUMERIC_BIT.all;
library RAM_MEMORY;
library OPCON;
library PROGRAM_FLOW;
library ALU; 
library UTILITIES;
library PORT_ADDRESS;

entity MICROCONTROLLER is
	port (
	CLK : in BIT;
	RESET : in BIT;
	IN_PORT : in BIT_VECTOR (7 downto 0);
	OUT_PORT : out BIT_VECTOR (7 downto 0);	
	PORT_ID : out BIT_VECTOR (7 downto 0);
	WRITE_STROBE : out BIT;
	READ_STROBE : out BIT
	);
	
end MICROCONTROLLER;

architecture AR_MICROCONTROLLER of MICROCONTROLLER is

component RAM_MEMORY is
	   port(Data_in:in BIT_VECTOR (15 downto 0 );
	        Data_out:out BIT_VECTOR (15 downto 0);
	   		Adress :in INTEGER;
			WR:in BIT;
			RESET:in BIT;
			CLK:in BIT);
end component;

component FLAGS_REGISTER
	port (
	CARRY_IN : in BIT;
	ZERO_IN : in BIT;
	FLAGS : out BIT_VECTOR (1 downto 0)
	);
end component;

component OPERATIONAL_CONTROL
	generic (
	DELAY_TIME : TIME := 20 ns
	);
	port (
	CLK : in BIT;
	RESET : in BIT;

	INSTRUCTION : in BIT_VECTOR (15 downto 0);
	COMAND : out BIT_VECTOR (1 downto 0);
	CONDITION_OF_COMAND : out BIT_VECTOR (2 downto 0);
	INSTRUCTION_ADDRESS : out BIT_VECTOR (7 downto 0);
	Sel_ALU : out BIT_VECTOR (4 downto 0);
	Const_ALU :out BIT_VECTOR (7 downto 0);
	Reg1:out BIT_VECTOR (3 downto 0);
	Reg2 :out BIT_VECTOR (3 downto 0);
	OP_STATE: out BIT;
	INPUT : out BIT;
	PORT_ADDRESS_CS : out BIT_VECTOR (2 downto 0);
	CONSTANT_PORD_ID : out BIT_VECTOR (7 downto 0)
	);
end component;

component PROGRAM_FLOW_CONTROL
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
end component;

component REGISTERS_BOX is 
	port (
	STATE : in BIT;
	DATE_IN : in BIT_VECTOR(7 downto 0);
	SELECTION : in BIT_VECTOR(3 downto 0);
	OPERATION : in BIT;
	SELECTION_OUT1 : in BIT_VECTOR(3 downto 0);
	SELECTION_OUT2 : in BIT_VECTOR(3 downto 0);
	DATE_OUT1 : out BIT_VECTOR(7 downto 0);
	DATE_OUT2 : out BIT_VECTOR(7 downto 0)
	);
	end component ;

signal FLAGS_IN, FLAGS_OUT : BIT_VECTOR (1 downto 0);

signal INSTRUCTION : BIT_VECTOR (15 downto 0);
signal COMAND : BIT_VECTOR (1 downto 0);
signal CONDITION_OF_COMAND : BIT_VECTOR (2 downto 0);
signal INSTRUCTION_ADDRESS : BIT_VECTOR (7 downto 0);
signal Sel_ALU :BIT_VECTOR (4 downto 0);
signal Const_ALU :BIT_VECTOR (7 downto 0);
signal Reg1:BIT_VECTOR (3 downto 0);
signal Reg2 :BIT_VECTOR (3 downto 0);
signal R1:BIT_VECTOR (7 downto 0);
signal R2:BIT_VECTOR (7 downto 0);
signal Rez:BIT_VECTOR (7 downto 0);
signal CR:BIT;
signal ZR:BIT;
signal OP_STATE : BIT;
signal INPUT : BIT := '0';
signal DATA : BIT_VECTOR (7 downto 0); 
signal PORT_ADDRESS_CS : BIT_VECTOR(2 downto 0);
signal CONSTANT_PORT_ID	: BIT_VECTOR (7 downto 0);

signal DATA_IN : BIT_VECTOR (15 downto 0);

signal NEXT_INSTRUCTION_ADDRESS : BIT_VECTOR (7 downto 0) := "00000000";
signal MEMORY_ADDRESS : INTEGER;

begin
	MEMORY_ADDRESS <= to_integer(unsigned(NEXT_INSTRUCTION_ADDRESS)); 
	MEM : entity RAM_MEMORY.RAM_MEMORY(ARHITECTURA_RAM_256_WORDS) port map (DATA_IN, INSTRUCTION, MEMORY_ADDRESS, '0', RESET, CLK);
	F_R : FLAGS_REGISTER port map (CR,ZR, FLAGS_OUT);
	O_C : entity OPCON.OPERATIONAL_CONTROL(AR_OPERATIONAL_CONTROL) port map (CLK, RESET, INSTRUCTION, COMAND, CONDITION_OF_COMAND, INSTRUCTION_ADDRESS, Sel_ALU, Const_ALU, Reg1, Reg2, OP_STATE, INPUT, PORT_ADDRESS_CS, CONSTANT_PORT_ID);
	P_F_C : entity PROGRAM_FLOW.PROGRAM_FLOW_CONTROL(AR_PROGRAM_FLOW_CONTROL) port map (CLK, RESET, COMAND, CONDITION_OF_COMAND, FLAGS_OUT, INSTRUCTION_ADDRESS, NEXT_INSTRUCTION_ADDRESS);
	A_L_U: entity ALU.ALUconfig(ARHITECTURA_ALU) port map (R1,R2,Const_ALU,Sel_ALU,Rez,CR,ZR); 
	MUX1: entity UTILITIES.MUX8_1(AR_MUX8_1)	port map (Rez(7 downto 4), IN_PORT(7 downto 4), INPUT, DATA(7 downto 4));
	MUX2: entity UTILITIES.MUX8_1(AR_MUX8_1)	port map (Rez(3 downto 0), IN_PORT(3 downto 0), INPUT, DATA(3 downto 0));
	R_E_G: 	REGISTERS_BOX port map (OP_STATE, DATA, Reg1 ,'0',Reg1, Reg2, R1, R2);
	P_A : entity PORT_ADDRESS.Port_address(ARHITECTURA_PORT_ADDRESS) port map (PORT_ADDRESS_CS, R1, R2, CONSTANT_PORT_ID, PORT_ID, READ_STROBE, WRITE_STROBE, OUT_PORT);													
end AR_MICROCONTROLLER;

----------------------END