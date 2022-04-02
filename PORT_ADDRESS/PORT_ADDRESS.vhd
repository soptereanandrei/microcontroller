entity  Port_address is 
	port (
	CHIP_SELECT:in bit_vector (2 downto 0);
    Registru1:in bit_vector (7 downto 0);
	Registru2:in bit_vector (7 downto 0);
    Constanta:in bit_vector (7 downto 0);

    PORT_ID:out bit_vector (7 downto 0) ;
    READ_STROBE:out bit ;
    WRITE_STROBE:out bit;
	OUT_PORT : out bit_vector (7 downto 0)
    );
end Port_address;

architecture ARHITECTURA_PORT_ADDRESS of Port_address is

begin
   process (CHIP_SELECT, Registru1, Registru2, Constanta)
   begin
	   case CHIP_SELECT is
		   when "100" => 
		   READ_STROBE <= '1';
		   WRITE_STROBE <= '0';
		   PORT_ID <= Constanta;
		   when "101" =>
		   READ_STROBE <= '1';
		   WRITE_STROBE <= '0';
		   PORT_ID <= Registru2;
		   when "110" =>
		   READ_STROBE <= '0';
		   WRITE_STROBE <= '1';
		   PORT_ID <= Constanta;
		   OUT_PORT <= Registru1;
		   when "111" =>
		   READ_STROBE <= '0';
		   WRITE_STROBE <= '1';
		   PORT_ID <= Registru2;
		   OUT_PORT <= Registru1;
		   when others =>
		   READ_STROBE <= '0';
		   WRITE_STROBE <= '0';
	   end case;
   end process;
   
end ARHITECTURA_PORT_ADDRESS;