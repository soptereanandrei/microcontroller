entity REG_MICRO is
	port (
	CHIP_SELECT : in BIT;
	DATE_IN : in BIT_VECTOR(7 downto 0);
	DATE_OUT : out BIT_VECTOR(7 downto 0)
	);
end REG_MICRO;

architecture AR_REG_MICRO of REG_MICRO is


signal REG : BIT_VECTOR(7 downto 0);

begin
	process (CHIP_SELECT, DATE_IN)
	begin
		if (CHIP_SELECT = '0') then
			REG <= DATE_IN;
		end if;
	end process;
	DATE_OUT <= REG;

end AR_REG_MICRO;

entity REGISTERS_BOX is
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
end REGISTERS_BOX;

architecture AR_REGISTERS_BOX of REGISTERS_BOX is

component REG_MICRO
	port (
	CHIP_SELECT : in BIT;
	DATE_IN : in BIT_VECTOR(7 downto 0);
	DATE_OUT : out BIT_VECTOR(7 downto 0)
	);
end component; 

TYPE DATE_BUS is array (0 to 15) of BIT_VECTOR (7 downto 0);

signal C_S : BIT_VECTOR (0 to 15);
signal DATE_IN_BUS : DATE_BUS;
signal DATE_OUT_BUS : DATE_BUS;

begin
	S0 : REG_MICRO port map (C_S(0), DATE_IN_BUS(0), DATE_OUT_BUS(0));
	S1 : REG_MICRO port map (C_S(1), DATE_IN_BUS(1), DATE_OUT_BUS(1));
	S2 : REG_MICRO port map (C_S(2), DATE_IN_BUS(2), DATE_OUT_BUS(2));
	S3 : REG_MICRO port map (C_S(3), DATE_IN_BUS(3), DATE_OUT_BUS(3));
	S4 : REG_MICRO port map (C_S(4), DATE_IN_BUS(4), DATE_OUT_BUS(4));
	S5 : REG_MICRO port map (C_S(5), DATE_IN_BUS(5), DATE_OUT_BUS(5));
	S6 : REG_MICRO port map (C_S(6), DATE_IN_BUS(6), DATE_OUT_BUS(6));
	S7 : REG_MICRO port map (C_S(7), DATE_IN_BUS(7), DATE_OUT_BUS(7));
	S8 : REG_MICRO port map (C_S(8), DATE_IN_BUS(8), DATE_OUT_BUS(8));
	S9 : REG_MICRO port map (C_S(9), DATE_IN_BUS(9), DATE_OUT_BUS(9));
	S10 : REG_MICRO port map (C_S(10), DATE_IN_BUS(10), DATE_OUT_BUS(10));
	S11 : REG_MICRO port map (C_S(11), DATE_IN_BUS(11), DATE_OUT_BUS(11));
	S12 : REG_MICRO port map (C_S(12), DATE_IN_BUS(12), DATE_OUT_BUS(12));
	S13 : REG_MICRO port map (C_S(13), DATE_IN_BUS(13), DATE_OUT_BUS(13));
	S14 : REG_MICRO port map (C_S(14), DATE_IN_BUS(14), DATE_OUT_BUS(14));
	S15 : REG_MICRO port map (C_S(15), DATE_IN_BUS(15), DATE_OUT_BUS(15));
	
	DEMUX : process (SELECTION, STATE)
	begin
		if STATE = '0' and STATE'EVENT then
		case SELECTION is
			when "0000"	=>
			DATE_IN_BUS(0) <= DATE_IN;
			C_S(0) <= OPERATION;
			----
			when "0001"	=>
			DATE_IN_BUS(1) <= DATE_IN;
			C_S(1) <= OPERATION;
			----
			when "0010"	=>
			DATE_IN_BUS(2) <= DATE_IN;
			C_S(2) <= OPERATION;
			----
			when "0011"	=>
			DATE_IN_BUS(3) <= DATE_IN;
			C_S(3) <= OPERATION;
			----
			when "0100"	=>
			DATE_IN_BUS(4) <= DATE_IN;
			C_S(4) <= OPERATION;
			----
			when "0101"	=>
			DATE_IN_BUS(5) <= DATE_IN;
			C_S(5) <= OPERATION;
			----
			when "0110"	=>
			DATE_IN_BUS(6) <= DATE_IN;
			C_S(6) <= OPERATION;
			----
			when "0111"	=>
			DATE_IN_BUS(7) <= DATE_IN;
			C_S(7) <= OPERATION;
			----
			when "1000"	=>
			DATE_IN_BUS(8) <= DATE_IN;
			C_S(8) <= OPERATION;
			----
			when "1001"	=>
			DATE_IN_BUS(9) <= DATE_IN;
			C_S(9) <= OPERATION;
			---
			when "1010"	=>
			DATE_IN_BUS(10) <= DATE_IN;
			C_S(10) <= OPERATION;
			---
			when "1011"	=>
			DATE_IN_BUS(11) <= DATE_IN;
			C_S(11) <= OPERATION;
			---
			when "1100"	=>
			DATE_IN_BUS(12) <= DATE_IN;
			C_S(12) <= OPERATION;
			---
			when "1101"	=>
			DATE_IN_BUS(13) <= DATE_IN;
			C_S(13) <= OPERATION;
			---
			when "1110"	=>
			DATE_IN_BUS(14) <= DATE_IN;
			C_S(14) <= OPERATION;
			---
			when "1111"	=>
			DATE_IN_BUS(15) <= DATE_IN;
			C_S(15) <= OPERATION;
			
			when others => null;
		end case;
		end if;
	end process;
	
	MUX1 : process ( STATE)
	begin
		if (STATE = '1' and STATE'EVENT) then
		case SELECTION_OUT1 is
			when "0000"	=>
			DATE_OUT1 <= DATE_OUT_BUS(0);
			----
			when "0001"	=>
			DATE_OUT1 <= DATE_OUT_BUS(1);
			----
			when "0010"	=>
			DATE_OUT1 <= DATE_OUT_BUS(2);
			----
			when "0011"	=>
			DATE_OUT1 <= DATE_OUT_BUS(3);
			----
			when "0100"	=>
			DATE_OUT1 <= DATE_OUT_BUS(4);
			----
			when "0101"	=>
			DATE_OUT1 <= DATE_OUT_BUS(5);
			----
			when "0110"	=>
			DATE_OUT1 <= DATE_OUT_BUS(6);
			----
			when "0111"	=>
			DATE_OUT1 <= DATE_OUT_BUS(7);
			----
			when "1000"	=>
			DATE_OUT1 <= DATE_OUT_BUS(8);
			----
			when "1001"	=>
			DATE_OUT1 <= DATE_OUT_BUS(9);
			---
			when "1010"	=>
			DATE_OUT1 <= DATE_OUT_BUS(10);
			---
			when "1011"	=>
			DATE_OUT1 <= DATE_OUT_BUS(11);
			---
			when "1100"	=>
			DATE_OUT1 <= DATE_OUT_BUS(12);
			---
			when "1101"	=>
			DATE_OUT1 <= DATE_OUT_BUS(13);
			---
			when "1110"	=>
			DATE_OUT1 <= DATE_OUT_BUS(14);
			---
			when "1111"	=>
			DATE_OUT1 <= DATE_OUT_BUS(15);
			
			when others => null;
		end case;
		end if;
	end process;
	
	MUX2 : process ( STATE)
	begin
		if (STATE = '1' and STATE'EVENT) then
		case SELECTION_OUT2 is
			when "0000"	=>
			DATE_OUT2 <= DATE_OUT_BUS(0);
			----
			when "0001"	=>
			DATE_OUT2 <= DATE_OUT_BUS(1);
			----
			when "0010"	=>
			DATE_OUT2 <= DATE_OUT_BUS(2);
			----
			when "0011"	=>
			DATE_OUT2 <= DATE_OUT_BUS(3);
			----
			when "0100"	=>
			DATE_OUT2 <= DATE_OUT_BUS(4);
			----
			when "0101"	=>
			DATE_OUT2 <= DATE_OUT_BUS(5);
			----
			when "0110"	=>
			DATE_OUT2 <= DATE_OUT_BUS(6);
			----
			when "0111"	=>
			DATE_OUT2 <= DATE_OUT_BUS(7);
			----
			when "1000"	=>
			DATE_OUT2 <= DATE_OUT_BUS(8);
			----
			when "1001"	=>
			DATE_OUT2 <= DATE_OUT_BUS(9);
			---
			when "1010"	=>
			DATE_OUT2 <= DATE_OUT_BUS(10);
			---
			when "1011"	=>
			DATE_OUT2 <= DATE_OUT_BUS(11);
			---
			when "1100"	=>
			DATE_OUT2 <= DATE_OUT_BUS(12);
			---
			when "1101"	=>
			DATE_OUT2 <= DATE_OUT_BUS(13);
			---
			when "1110"	=>
			DATE_OUT2 <= DATE_OUT_BUS(14);
			---
			when "1111"	=>
			DATE_OUT2 <= DATE_OUT_BUS(15);
			
			when others => null;
		end case;
		end if;
	end process;

end AR_REGISTERS_BOX;






--ALU
--
--SIGNAL R1, R2
--
--OP INTRE R1 SI R6
--OP INTRE DATE_OUT_BUS(ADR1) SI DATE_OUT_BUS(ADR2);
--
--CASE 'ADUNARE'
--	R1 <= DATE_OUT_BUS(ADR1);
--	R2 <= DATE_OUT_BIS(ADR2);
