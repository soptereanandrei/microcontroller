 
library IEEE;
use IEEE.std_logic_1164.all;   


entity ADD_1_bite is
	port(A,B:in BIT;
	     y,Co:out BIT);
	
end ADD_1_bite;

architecture ARHITECTURA_ADD_1_bite of ADD_1_bite is
begin
	y<=A xor B after 1 ns;
	Co<=A and B after 1 ns;	
	
end ARHITECTURA_ADD_1_bite ;

entity ADD is
	port(R1:in BIT_VECTOR (7 downto 0) ;
	      R2:in BIT_VECTOR (7 downto 0);
	       Y:out BIT_VECTOR (7 downto 0) ;
	        C0:out BIT);
	
end ADD;

architecture ARHITECTURA_ADD_8_bite of ADD is

component ADD_1_bite
	port(A,B:in BIT;
	y,Co:out BIT);
	
end component; 

signal C1,C2,C3,C4,C5,C6,C7,C8:bit;
begin
	HA1: ADD_1_bite port map (R1(0),R2(0),Y(0),C1);
	HA2: ADD_1_bite port map (R1(1),R2(1),Y(1),C2);
	HA3: ADD_1_bite port map (R1(2),R2(2),Y(2),C3);
	HA4: ADD_1_bite port map (R1(3),R2(3),Y(3),C4);
	HA5: ADD_1_bite port map (R1(4),R2(4),Y(4),C5);
	HA6: ADD_1_bite port map (R1(5),R2(5),Y(5),C6);
	HA7: ADD_1_bite port map (R1(6),R2(6),Y(6),C7);
	HA8: ADD_1_bite port map (R1(7),R2(7),Y(7),C8);
	
	
	
	
	
	
	      
end ARHITECTURA_ADD_8_bite;

										 