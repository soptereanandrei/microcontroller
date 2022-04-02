entity FULL_SUB_1_bit is
	port (A,B,Br:in bit;
	D,Inp:out bit);
	
end FULL_SUB_1_bit;

architecture ARHITECTURA_FULL_SUB_1_bit of FULL_SUB_1_bit is
signal COMPLEMENTAR_A,INTER:BIT;

begin  
	INTER<=A XOR B;
	D<=INTER xor Br;
	COMPLEMENTAR_A<= not A;
	Inp<=(COMPLEMENTAR_A and B) or (Br and B) or (Br and COMPLEMENTAR_A);
	
	end ARHITECTURA_FULL_SUB_1_bit ;
	
	
	entity SUBCY is
		port(R1:in BIT_VECTOR (7 downto 0);
		     R2:in BIT_VECTOR (7 downto 0);
			 Dif:out BIT_VECTOR (7 downto 0);
			 Br:out BIT);
			 
	end SUBCY;
	
	architecture ARHITECTURA_SUBCY_8_bit of SUBCY is
	
	component FULL_SUB_1_bit
		  port (A,B,Br:in bit;
	           D,Inp:out bit);
	end component;		  
	
	signal B1,B2,B3,B4,B5,B6,B7:BIT;
	
	begin 
		FSUB1:FULL_SUB_1_bit port map (R1(0),R2(0),'0',Dif(0),B1);
		FSUB2:FULL_SUB_1_bit port map (R1(1),R2(1),B1,Dif(1),B2);
		FSUB3:FULL_SUB_1_bit port map (R1(2),R2(2),B2,Dif(2),B3);
		FSUB4:FULL_SUB_1_bit port map (R1(3),R2(3),B3,Dif(3),B4);
		FSUB5:FULL_SUB_1_bit port map (R1(4),R2(4),B4,Dif(4),B5);
		FSUB6:FULL_SUB_1_bit port map (R1(5),R2(5),B5,Dif(5),B6);
		FSUB7:FULL_SUB_1_bit port map (R1(6),R2(6),B6,Dif(6),B7);
		FSUB8:FULL_SUB_1_bit port map (R1(7),R2(7),B7,Dif(7),Br);
		
		end ARHITECTURA_SUBCY_8_bit;

		