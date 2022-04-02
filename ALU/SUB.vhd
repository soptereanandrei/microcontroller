entity HALF_SUBTRACTER_1_bit is
	port (A,B:in BIT;
	D,BR:out BIT);
	
end HALF_SUBTRACTER_1_bit;

architecture ARHITECTURA_HALF_SUBTRACTER_1_bit of HALF_SUBTRACTER_1_bit is	
signal COMPLEMENTAR_A:BIT;
begin
	D<=A xor B;
	COMPLEMENTAR_A<= not A;
	BR<=COMPLEMENTAR_A and B;
	
end ARHITECTURA_HALF_SUBTRACTER_1_bit;

entity SUB is
	port(R1:in BIT_VECTOR (7 downto 0);
	     R2:in BIT_VECTOR (7 downto 0);
		 Dif:out BIT_VECTOR (7 downto 0);
		 Borrow:out BIT);
end SUB;

architecture ARHITECTURA_SUB_8_bit of SUB is
component HALF_SUBTRACTER_1_bit 
	port(A,B:in BIT;
	D,BR:out BIT);
end component;

signal BR1,BR2,BR3,BR4,BR5,BR6,BR7,BR8:BIT;
begin 
	HSUB1:HALF_SUBTRACTER_1_bit port map(R1(0),R2(0),Dif(0),BR1);	 
	HSUB2:HALF_SUBTRACTER_1_bit port map(R1(1),R2(1),Dif(1),BR2);
	HSUB3:HALF_SUBTRACTER_1_bit port map(R1(2),R2(2),Dif(2),BR3);
	HSUB4:HALF_SUBTRACTER_1_bit port map(R1(3),R2(3),Dif(3),BR4);
	HSUB5:HALF_SUBTRACTER_1_bit port map(R1(4),R2(4),Dif(4),BR5);
	HSUB6:HALF_SUBTRACTER_1_bit port map(R1(5),R2(5),Dif(5),BR6);
	HSUB7:HALF_SUBTRACTER_1_bit port map(R1(6),R2(6),Dif(6),BR7);
	HSUB8:HALF_SUBTRACTER_1_bit port map(R1(7),R2(7),Dif(7),BR8);
	
	Borrow <=BR1 or BR2 OR BR3 OR BR4 OR BR5 OR BR6 OR BR7 OR BR8;
	
	end ARHITECTURA_SUB_8_bit;

		 
		 
   