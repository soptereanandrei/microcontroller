--- COMANDA SR0    
entity SR0 is 
		port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity SR0;
  
  architecture ARHITECTURA_SR0 of SR0 is 
  
  begin 
	  cr<= data_in(0);
	  data_out <= data_in srl 1;

  end architecture  ARHITECTURA_SR0;
  
  ---COMANDA SR1
  entity SR1 is 
		port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity SR1;
  
  architecture ARHITECTURA_SR1 of SR1 is 
  
  signal INTER:BIT_VECTOR (7 downto 0);
  begin 
	  cr<= data_in(0);
	  INTER(0) <= data_in(1);
	  INTER(1) <= data_in(2) ;
	  INTER(2) <= data_in(3);
	  INTER(3) <= data_in(4);
	  INTER(4) <= data_in(5);
	  INTER(5) <= data_in(6);
	  INTER(6) <= data_in(7);
	  INTER(7) <= '1'; 
	  data_out <= INTER;
	  
end architecture  ARHITECTURA_SR1; 

---COMANDA SRX
 entity SRX is 
		port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
 end entity SRX; 
 
 architecture ARHITECTURA_SRX of SRX is 
 
 begin 
	 cr <=data_in (0);
	 data_out <= data_in sra 1;
	 
 end architecture  ARHITECTURA_SRX; 
 
 --- COMANDA SRA
 
   entity SR_A is 
		port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
 end entity SR_A; 
 
 architecture ARHITECTURA_SR_A of SR_A is 
 
 begin 
	 cr <= data_in (0);
	 data_out <= data_in ror 1;
	 
 end architecture  ARHITECTURA_SR_A; 
	 
 --- COMANDA RR
 
     entity RR is 
		port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
 end entity RR;
 
 architecture ARHITECTURA_RR of RR is
 
  signal INTER:BIT_VECTOR (7 downto 0);	
  signal BITUL:BIT ;
 begin 
	  cr<=data_in(0);
	  BITUL<= data_in (1);
	  INTER (0)	<= data_in (1);
	  INTER (1)	<= data_in (2);
	  INTER (2)	<= data_in (3);
	  INTER (3)	<= data_in (4);
	  INTER (4)	<= data_in (5);
	  INTER (5)	<= data_in (6);
	  INTER (6)	<= data_in (7);
	  INTER (7)	<= BITUL;
 
  end architecture  ARHITECTURA_RR;
   
   