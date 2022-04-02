library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_STD.all; 
use IEEE.numeric_BIT.all;
use IEEE.std_logic_unsigned.all;

 entity RAM_MEMORY is
	   port(Data_in:in BIT_VECTOR (15 downto 0 );
	        Data_out:out BIT_VECTOR (15 downto 0);
	   		Adress :in INTEGER;
			WR:in BIT;
			RESET:in BIT;
			CLK:in BIT);
   end entity RAM_MEMORY ;
   
   architecture ARHITECTURA_RAM_256_WORDS of RAM_MEMORY is
   
   type RAM1 is array (255 downto 0) of BIT_VECTOR (15 downto 0);
   signal my_ram:RAM1;
   
   begin				 
	   process (WR,RESET,Adress)
	   begin
		   if RESET = '1' then 
				   --if WR = '1' then 
					   --my_ram(Adress) <= Data_in;
				   --else
					   Data_out <= my_ram(Adress);
				   --end if;
		   else
			   --my_ram <= (others => x"0000");
			   Data_out <= my_ram(0);
		  end if;
		  
	  end process;
	  
	  MODUL_DE_TESTARE : process
					    begin
		  --my_ram(0) <= "0000000000001000";
		  --my_ram(1) <= "0101000000000111";
		  --my_ram(2) <= "1100000000010101";
		  --my_ram(3) <= "1100000000010101";
		  --my_ram(4) <= "1100000000010111";
		  --my_ram(5) <= "1100000000010101";
		  my_ram(0) <= "1010000011111111";
		  my_ram(1) <= "0000000110100000";
		  my_ram(2) <= "1100000000010101";
		  my_ram(3) <= "1111000000010000";
		  wait;
	  end process;
	
end architecture ARHITECTURA_RAM_256_WORDS;

-------------------------------------------------------------------------
entity STACK_RAM_MEMORY is
	port (
	CLK : in BIT;
	WR : in BIT;
	ADDRESS : in INTEGER;
	DATA_IN : in BIT_VECTOR(7 downto 0);
	DATA_OUT : out BIT_VECTOR(7 downto 0)
	);
end STACK_RAM_MEMORY;

architecture AR_STACK_RAM_MEMORY of STACK_RAM_MEMORY is

type STACK_RAM is array (15 downto 0) of BIT_VECTOR (7 downto 0);
signal MEMORY : STACK_RAM;
   
begin
	process (CLK)
	begin
		if CLK = '1' and CLK'EVENT then
			if WR = '1' then
				MEMORY(ADDRESS) <= DATA_IN;
			else
				DATA_OUT <= MEMORY(ADDRESS);
			end if;
		end if;
	end process;
	
end architecture AR_STACK_RAM_MEMORY;