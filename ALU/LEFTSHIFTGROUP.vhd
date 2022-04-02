---COMANDA SL0	
 entity SL0 is 
		 port (data_in :in BIT_VECTOR (7 downto 0) ;
		       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
	end entity SL0;
	
	architecture ARHITECTURA_SL0 of SL0 is
	
	
	begin
		cr<=data_in(7)	;
		data_out <= data_in sll 1 ;
	
  end architecture 	ARHITECTURA_SL0;
  
  ---COMANDA SL1
  entity SL1 is 
	  port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity SL1;
  
  architecture ARHITECTURA_SL1 of SL1 is 
  
  signal INTER :BIT_VECTOR (7 downto 0);
  begin 
	   
	  cr<= data_in(7);
	  INTER(7) <= data_in(6);
	  INTER(6) <= data_in(5) ;
	  INTER(5) <= data_in(4);
	  INTER(4) <= data_in(3);
	  INTER(3) <= data_in(2);
	  INTER(2) <= data_in(1);
	  INTER(1) <= data_in(0);
	  INTER(0) <= '1'; 
	  data_out <= INTER;
	  
  end architecture 	ARHITECTURA_SL1;
  
  --COMANDA SLX
  entity SLX is 
	  port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity SLX;
  
  architecture ARHITECTURA_SLX of SLX is 
  
  begin 
	  cr<= data_in(7);
	  data_out <= data_in sla 1;
	  
  end architecture 	ARHITECTURA_SLX; 
  
  --- COMANDA SLA 
  
  entity SL_A is 
	  port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity SL_A;
  
  
  architecture ARHITECTURA_SL_A of SL_A is 
  
  begin 
	  cr<= data_in(7);
	  data_out <= data_in rol 1;
	  
end architecture 	ARHITECTURA_SL_A;

--- COMANDA RL 

   entity RL is 
	  port (data_in :in BIT_VECTOR (7 downto 0);
	       cr :out BIT ;
		 	   data_out :out BIT_VECTOR (7 downto 0));
	
  end entity RL; 
  
  architecture ARHITECTURA_RL of RL is  
  
  signal INTER:BIT_VECTOR (7 downto 0);	
  signal BITUL:BIT ;
  begin 
	  cr<=data_in(7);
	  BITUL<= data_in (6);
	  INTER (7)	<= data_in (6);
	  INTER (6)	<= data_in (5);
	  INTER (5)	<= data_in (4);
	  INTER (4)	<= data_in (3);
	  INTER (3)	<= data_in (2);
	  INTER (2)	<= data_in (1);
	  INTER (1)	<= data_in (0);
	  INTER (0)	<= BITUL; 
	  
	  data_out <= INTER;
	  
  end architecture 	ARHITECTURA_RL;
  
  
	  
