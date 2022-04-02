library MICROCONTROLLER_DESIGN;

entity OPERATIONAL_CONTROL is
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
	
end OPERATIONAL_CONTROL;

architecture AR_OPERATIONAL_CONTROL of OPERATIONAL_CONTROL is 

signal STATE, NOT_STATE : BIT;
signal STATE_RESET : BIT := '0'; 

begin
	S_S : entity MICROCONTROLLER_DESIGN.STATE_SELECTOR(AR_STATE_SELECTOR) port map (CLK, STATE_RESET, '1', STATE, NOT_STATE);
	OP_STATE <= STATE;
	
	process (STATE, CLK)
	begin
		if (RESET = '0' and CLK = '1' and CLK'EVENT) then
			STATE_RESET <= '0'; --RESETARE STARE
		else
			STATE_RESET <= '1';
		end if;	
	if (STATE = '0' and CLK = '1'and RESET = '1') then
		if INSTRUCTION (15 downto 12) ="1100" then 
				--- opertatii arimt+logice pe registrii
			case INSTRUCTION (3 downto 0)  is
				when "0000" =>	  ---LOAD
				Sel_ALU <="00000";
				
				when "0001"=>	 ---AND
				Sel_ALU <="00010";
				
				when "0010" =>	 ---OR
				Sel_ALU <= "00100";
				
				when "0011" =>	---XOR
				Sel_ALU <="00110";
				
				when "0100" =>	---ADD
				Sel_ALU <="01000";
				
				when "0101" => ---ADDCY
				Sel_ALU <="01010";
				
				when "0110" => ---SUB
				Sel_ALU <="01100";
				
				when "0111" => ---SUBCY
				Sel_ALU <="01110";
				
				when others =>
				Sel_ALU<="11111";
			end case ;
			   Reg1<=INSTRUCTION (11 downto 8);
			   Reg2<=INSTRUCTION (7 downto 4);
		end if;
			
		--- operatie aritm+logica pe registru signal constanta
		 if INSTRUCTION (15) ='0' then 
			case INSTRUCTION (15 downto 12) is 
				when "0000" => 	 ---LOAD
				Sel_ALU <="00001";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0001"=>	 ---AND
				Sel_ALU <="00011";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0010" =>	 ---OR
				Sel_ALU <="00101";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0011" => ---XOR
				Sel_ALU <="00111";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0100"=> ---ADD
				Sel_ALU <="01001";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0101"=> ---ADDCY 
				Sel_ALU	<= "01011";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0110" => ---SUB
				Sel_ALU<="01101";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when "0111"=> ---SUBCY
				Sel_ALU <="01111";
				Const_ALU<= INSTRUCTION (7 downto 0);
				
				when others => 
				 Sel_ALU <="11111" ;
			end case;
				Reg1<=INSTRUCTION (11 downto 8);
			end if;
			 --- opearatii de shiftare 
			if INSTRUCTION (15 downto 12) ="1101" then 
				if INSTRUCTION(3) = '1' then
				-- SHIFT RIGHT
				case INSTRUCTION(2 downto 0) is
					when "110" => Sel_ALU <= "10000";
					when "111" => Sel_ALU <= "10001";
					when "010" => Sel_ALU <= "10010";
					when "000" => Sel_ALU <= "10011";
					when "100" => Sel_ALU <= "10100";
					when others => Sel_ALU <= "11111";
				end case;
				else
				-- SHIFT LEFT
				case INSTRUCTION(2 downto 0) is
					when "110" => Sel_ALU <= "10101";
					when "111" => Sel_ALU <= "10110";
					when "010" => Sel_ALU <= "10111";
					when "000" => Sel_ALU <= "11000";
					when "100" => Sel_ALU <= "11001";
					when others => Sel_ALU <= "11111";
				end case;
				end if;
				Reg1 <= INSTRUCTION(11 downto 8);
			end if;
			  --- operatii de flow
			if INSTRUCTION (15 downto 13) ="100" then
				COMAND <= INSTRUCTION(9 downto 8);
				CONDITION_OF_COMAND <= INSTRUCTION(12 downto 10);
				INSTRUCTION_ADDRESS <= INSTRUCTION(7 downto 0);
			else
				COMAND <= "10";	
				CONDITION_OF_COMAND <= "000";
			end if;
			--- operatie de intrare cu constanta
			if INSTRUCTION (15 downto 12) = "1010" then
				PORT_ADDRESS_CS <= "100";
				INPUT <= '1';
				CONSTANT_PORD_ID <= INSTRUCTION(7 downto 0);
				Reg1 <= INSTRUCTION(11 downto 8);
				Sel_ALU <="11111" ;
			--- operatie de intrare registru-registru
			elsif INSTRUCTION (15 downto 12) = "1011" then
				PORT_ADDRESS_CS <= "101";
				INPUT <= '1';
				Reg1 <= INSTRUCTION(11 downto 8);
				Reg2 <= INSTRUCTION(7 downto 4);
				Sel_ALU <="11111" ;
			--- operatie de iesire cu constanta
			elsif INSTRUCTION (15 downto 12) = "1110" then
				PORT_ADDRESS_CS <= "110";
				INPUT <= '0';
				CONSTANT_PORD_ID <= INSTRUCTION(7 downto 0);
				Reg1 <= INSTRUCTION(11 downto 8);
				Sel_ALU <="11111";
			--- operatie de iesire registru-registru
			elsif INSTRUCTION (15 downto 12) = "1111" then
				PORT_ADDRESS_CS <= "111";
				INPUT <= '0';
				Reg1 <= INSTRUCTION(11 downto 8);
				Reg2 <= INSTRUCTION(7 downto 4); 
				Sel_ALU <="11111";
			else
				PORT_ADDRESS_CS <= "000";
				INPUT <= '0';
			end if;
			
		end if;
	end process;

end AR_OPERATIONAL_CONTROL;