entity INVERSOR is
	port (
	I : in BIT;
	O : out BIT
	);
end INVERSOR;

architecture AR_INVERSOR of INVERSOR is
begin
	O <= not(I);
end AR_INVERSOR;

--------------------------------------------

entity AND4 is
	port (
	I1, I2, I3, I4 : in BIT;
	O : out BIT
	);
end AND4;

architecture AR_AND4 of AND4 is
begin
	O <= I1 and I2 and I3 and I4;
end AR_AND4;

---------------------------------------------

entity AND2 is
	port (
	I1, I2 : in BIT;
	O : out BIT
	);
end AND2;

architecture AR_AND2 of AND2 is
begin
	O <= I1 and I2;
end AR_AND2;

----------------------------------------------

entity OR2 is
	port (
	I1, I2 : in BIT;
	O : out BIT
	);
end OR2;

architecture AR_OR2 of OR2 is
begin
	O <= I1 or I2;
end AR_OR2;

----------------------------------------------

entity OR3 is
	port (
	I1, I2, I3 : in BIT;
	O : out BIT
	);
end OR3;

architecture AR_OR3 of OR3 is
begin
	O <= I1 or I2 or I3;
end AR_OR3;

------------------------------------------------

entity MUX2_1 is
	port (
	I0, I1 : in BIT;
	SELECTION : in BIT;
	O : out BIT
	);
end MUX2_1;

architecture AR_MUX2_1 of MUX2_1 is
begin
	O <= (I0 and not(SELECTION)) or (I1 and SELECTION);
	
end AR_MUX2_1;

-------------------------------------------------

entity MUX8_1 is
	port (
	I0, I1 : in BIT_VECTOR (3 downto 0);
	SELECTION : in BIT;
	O : out BIT_VECTOR (3 downto 0)
	);
end MUX8_1;

architecture AR_MUX8_1 of MUX8_1 is
begin
	O(3) <= (I0(3) and not(SELECTION)) or (I1(3) and SELECTION);
	O(2) <= (I0(2) and not(SELECTION)) or (I1(2) and SELECTION);
	O(1) <= (I0(1) and not(SELECTION)) or (I1(1) and SELECTION);
	O(0) <= (I0(0) and not(SELECTION)) or (I1(0) and SELECTION);
	
end AR_MUX8_1;

---------------------------------------------------

entity DATA_SELECTOR is
	port (
	CHIP_SELECT : in BIT;
	I : in BIT_VECTOR(7 downto 0);
	IO : inout BIT_VECTOR(7 downto 0);
	O : out BIT_VECTOR(7 downto 0)
	);
end DATA_SELECTOR;

architecture AR_DATA_SELECTOR of DATA_SELECTOR is

begin
	process (CHIP_SELECT, I, IO)
	begin
		if (CHIP_SELECT = '1') then
			IO <= I;
		else
			O <= IO;
		end if;
	end process;

end AR_DATA_SELECTOR;