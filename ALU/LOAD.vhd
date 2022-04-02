entity LOAD is
	port(
	--CS : in BIT;
	--DATA_REG : in BIT_VECTOR (7 downto 0);
	DATA_IN : in BIT_VECTOR (7 downto 0); 
--DATA_CONST : in BIT_VECTOR (7 downto 0);
	DATA_OUT : out BIT_VECTOR (7 downto 0)
	);
end LOAD;

architecture AR_LOAD of LOAD is

begin
	--process (CS)
--	begin
--		if (CS = '0') then
--			DATA_OUT <= DATA_CONST after 5 ns;
--		else
--			DATA_OUT <= DATA_REG after 5 ns;
--		end if;
--	end process;
	DATA_OUT <= DATA_IN;
	
end AR_LOAD;