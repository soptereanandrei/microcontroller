entity STATE_SELECTOR is
	port (
	CLK : in BIT;
	RESET : in BIT;
	SET : in BIT;
	STATE : out BIT;
	NOT_STATE : out BIT
	);
end STATE_SELECTOR;

architecture AR_STATE_SELECTOR of STATE_SELECTOR is

signal STATE_SLICE : BIT := '0';

begin
	process (CLK)
	begin
		if CLK = '0' and CLK'EVENT then
			if RESET = '0' then
				STATE_SLICE <= '0';
			elsif SET = '0' then
				STATE_SLICE <= '1';
			else
				STATE_SLICE <= not(STATE_SLICE);
			end if;
		end if;
	end process;
	STATE <= STATE_SLICE;
	NOT_STATE <= not(STATE_SLICE);

end AR_STATE_SELECTOR;