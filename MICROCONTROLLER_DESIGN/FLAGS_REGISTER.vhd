entity FLAGS_REGISTER is
	port (
	CARRY_IN : in BIT;
	ZERO_IN : in BIT;
	FLAGS : out BIT_VECTOR (1 downto 0)
	);
end FLAGS_REGISTER;

architecture AR_FLAGS_REGISTER of FLAGS_REGISTER is
signal FLAGS_REG : BIT_VECTOR (1 downto 0);

begin
	FLAGS(1) <= CARRY_IN;
	FLAGS(0) <= ZERO_IN;
			
end AR_FLAGS_REGISTER;