-----------------------------------------------------------------JK_FLIP_FLOP

entity JK_FLIP_FLOP is  
	port (
	CLK, J, K, S, R: in BIT;   
	Q, NQ: buffer BIT); 
end JK_FLIP_FLOP; 

architecture AR_JK_FLIP_FLOP of JK_FLIP_FLOP is 
begin
	process (CLK, S, R)
	variable temp : BIT;
	begin
		if S = '0' then
			Q <= '1';
			NQ <= '0';
		elsif R = '0' then
			Q <= '0';
			NQ <= '1';
		elsif CLK = '1' and CLK'EVENT then
			if J = '0' and K = '0' then
				null;
			end if;
			if J = '1' and K = '0' then
				Q <= '1';
				NQ <= '0';
			end if;
			if J = '0' and K = '1' then
				Q <= '0';
				NQ <= '1';
			end if;
			if J = '1' and K = '1' then
				temp := Q;
				Q <= not(temp);
				NQ <= temp;
			end if;
		end if;
	end process;
	
end architecture AR_JK_FLIP_FLOP;



-----------------------------------------------------------------END 