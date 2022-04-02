entity ADDCY_1_bite is
	port(A,B,CIN:in Bit;
	y,CO:out bit);
	
end ADDCY_1_bite;

architecture ARHITECTURA_1_bite of ADDCY_1_bite is

signal INSERT: BIT;

begin
	INSERT<=A xor B after 1 ns;
	y<=INSERT xor CIN after 1 ns;
	CO<= (A and B) or (INSERT and CIN) after 2 ns; 
	
end ARHITECTURA_1_bite;

entity ADDCY is
	port(R1:in BIT_VECTOR (7 downto 0);
	     R2:in BIT_VECTOR (7 downto 0);
	     RY:out BIT_VECTOR (7 downto 0);
	     COUT:out BIT);
	
end ADDCY;

architecture ARHITECTURA_ADDCY_8_bite of ADDCY is

component ADDCY_1_bite
	port(A,B,CIN:in BIT;
	y,CO:out BIT);
end component;					

signal C1,C2,C3,C4,C5,C6,C7:BIT;

begin 
	FAD1:ADDCY_1_bite port map (R1(0),R2(0),'0',RY(0),C1);
	FAD2:ADDCY_1_bite port map (R1(1),R2(1),C1,RY(1),C2);
	FAD3:ADDCY_1_bite port map (R1(2),R2(2),C2,RY(2),C3);
	FAD4:ADDCY_1_bite port map (R1(3),R2(3),C3,RY(3),C4);
	FAD5:ADDCY_1_bite port map (R1(4),R2(4),C4,RY(4),C5);
	FAD6:ADDCY_1_bite port map (R1(5),R2(5),C5,RY(5),C6);
	FAD7:ADDCY_1_bite port map (R1(6),R2(6),C6,RY(6),C7);
	FAD8:ADDCY_1_bite port map (R1(7),R2(7),C7,RY(7),COUT);
	
	end ARHITECTURA_ADDCY_8_bite;
	

