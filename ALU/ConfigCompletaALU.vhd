
library ALU; 
-- Operatia XOR pe 8 biti
entity XOR_logic is
	port(R1:in BIT_VECTOR (7 downto 0);
         R2:in BIT_VECTOR (7 downto 0);
		 Y: out BIT_VECTOR (7 downto 0));
end entity XOR_logic;

architecture ARHITECTURA_XOR of XOR_logic is
begin
	Y(7)<=R1(7) xor R2(7);
	Y(6)<=R1(6) xor R2(6);
	Y(5)<=R1(5) xor R2(5);
	Y(4)<=R1(4) xor R2(4);
	Y(3)<=R1(3) xor R2(3);
	Y(2)<=R1(2) xor R2(2);
	Y(1)<=R1(1) xor R2(1);
	Y(0)<=R1(0) xor R2(0); 
	
end architecture ARHITECTURA_XOR; 

--Operatia AND pe 8 biti
entity AND_logic is
	   port(R1:in BIT_VECTOR (7 downto 0);
         R2:in BIT_VECTOR (7 downto 0);
		 Y: out BIT_VECTOR (7 downto 0));
end entity AND_logic;

architecture ARHITECTURA_AND OF AND_LOGIC is
begin	
	Y(7)<=R1(7) and R2(7);
	Y(6)<=R1(6) and R2(6);
	Y(5)<=R1(5) and R2(5);
	Y(4)<=R1(4) and R2(4);
	Y(3)<=R1(3) and R2(3);
	Y(2)<=R1(2) and R2(2);
	Y(1)<=R1(1) and R2(1);
	Y(0)<=R1(0) and R2(0);	 
end architecture ARHITECTURA_AND;

--Operatia OR pe 8 biti
entity OR_logic is
	port(R1:in BIT_VECTOR (7 downto 0);
         R2:in BIT_VECTOR (7 downto 0);
		 Y: out BIT_VECTOR (7 downto 0));
end entity OR_logic; 

architecture ARHITECTURA_OR of OR_logic is
  begin	
	Y(7)<=R1(7) or R2(7);
	Y(6)<=R1(6) or R2(6);
	Y(5)<=R1(5) or R2(5);
	Y(4)<=R1(4) or R2(4);
	Y(3)<=R1(3) or R2(3);
	Y(2)<=R1(2) or R2(2);
	Y(1)<=R1(1) or R2(1);
	Y(0)<=R1(0) or R2(0);	 
end architecture ARHITECTURA_OR	 ;

--Configuratie ALU 
library ALU;
entity ALUconfig is
	port(
			R1:in BIT_VECTOR (7 downto 0);
	       	R2:in BIT_VECTOR (7 downto 0);
	  	   	Const:in BIT_VECTOR (7 downto 0);
			 Sel:in BIT_vector (4 downto 0);
			 Rez:out BIT_vector (7 downto 0);
			 CR:out BIT;
			 ZR:out BIT
			 --REG_CS : out BIT
			 );
  end entity ALUconfig;
  
  architecture ARHITECTURA_ALU of ALUconfig is
  
  component XOR_logic
	  port(R1:in BIT_VECTOR (7 downto 0) ;
	      R2:in BIT_VECTOR (7 downto 0);
	       Y:out BIT_VECTOR (7 downto 0)) ;	  
  end component ;
  
  component AND_logic  
	  port(R1:in BIT_VECTOR (7 downto 0);
	     R2:in BIT_VECTOR (7 downto 0);
	     Y:out BIT_VECTOR (7 downto 0));
 end component;
 
 component OR_logic
	   port(R1:in BIT_VECTOR (7 downto 0);
	     R2:in BIT_VECTOR (7 downto 0);
		 Y:out BIT_VECTOR (7 downto 0));	 
 end component ;
 
 
 signal INTERMEDIAR:BIT_VECTOR (7 downto 0);
 signal REZADD,REZADDCY,REZSUB,REZSUBCY,REZADD_CON,REZADDCY_CON,REZSUB_CON,REZSUBCY_CON:BIT_VECTOR (7 downto 0);
 signal CRADD,CRADDCY,CRSUB,CRSUBCY,CRADD_CON,CRADDCY_CON,CRSUB_CON,CRSUBCY_CON:BIT;
 signal XOR_REG,AND_REG,OR_REG,XOR_CON,AND_CON,OR_CON:BIT_VECTOR (7 downto 0);
 signal REZSR0,REZSR1,REZSRX,REZSRA,REZRR:BIT_VECTOR (7 downto 0);
 signal REZSL0,REZSL1,REZSLX,REZSLA,REZRL:BIT_VECTOR (7 downto 0);
 signal cr1,cr2,cr3,cr4,cr5,cr6,cr7,cr8,cr9,cr10:BIT;
 signal LOAD_OUT1, LOAD_OUT2 : BIT_VECTOR (7 downto 0);
 

 begin
	 BOX1:entity ALU.ADD(ARHITECTURA_ADD_8_bite)port map(R1,R2,REZADD,CRADD);
	 BOX2:entity ALU.ADDCY(ARHITECTURA_ADDCY_8_bite) port map (R1,R2,REZADDCY,CRADDCY);
	 BOX3:entity ALU.SUB(ARHITECTURA_SUB_8_bit) port map (R1,R2,REZSUB,CRSUB);
	 BOX4:entity ALU.SUBCY(ARHITECTURA_SUBCY_8_bit) port map (R1,R2,REZSUBCY,CRSUBCY);
	 BOX5:entity ALU.ADD(ARHITECTURA_ADD_8_bite)port map(R1,Const,REZADD_CON,CRADD_CON);
	 BOX6:entity ALU.ADDCY(ARHITECTURA_ADDCY_8_bite) port map (R1,Const,REZADDCY_CON,CRADDCY_CON);
	 BOX7:entity ALU.SUB(ARHITECTURA_SUB_8_bit) port map (R1,Const,REZSUB_CON,CRSUB_CON);
	 BOX8:entity ALU.SUBCY(ARHITECTURA_SUBCY_8_bit) port map (R1,Const,REZSUBCY_CON,CRSUBCY_CON);
	 BOX9:OR_logic port map (R1,R2,OR_REG);
	 BOX10:OR_logic port map (R1,Const,OR_CON);
	 BOX11:AND_logic port map (R1,R2,AND_REG);
	 BOX12:AND_logic port map (R1,Const,AND_CON);
	 BOX13:XOR_logic port map (R1,R2,XOR_REG);
	 BOX14:XOR_logic port map (R1,Const,XOR_CON);  
	 ---OPERATII DE ROTATIE
	 BOX15:entity ALU.SL0(ARHITECTURA_SL0)port map(R1,cr1,REZSL0);
     BOX16:entity ALU.SL1(ARHITECTURA_SL1)port map(R1,cr2,REZSL1);
	 BOX17:entity ALU.SLX(ARHITECTURA_SLX)port map(R1,cr3,REZSLX);
	 BOX18:entity ALU.SL_A(ARHITECTURA_SL_A)port map(R1,cr4,REZSLA);
	 BOX19:entity ALU.RL(ARHITECTURA_RL)port map(R1,cr5,REZRL);
     BOX20:entity ALU.SR0(ARHITECTURA_SR0)port map(R1,cr6,REZSR0);	 
     BOX21:entity ALU.SR1(ARHITECTURA_SR1)port map(R1,cr7,REZSR1);	 
     BOX22:entity ALU.SRX(ARHITECTURA_SRX)port map(R1,cr8,REZSRX);	 
     BOX23:entity ALU.SR_A(ARHITECTURA_SR_A)port map(R1,cr9,REZSRA);     
     BOX24:entity ALU.RR(ARHITECTURA_RR)port map(R1,cr10,REZRR);
	 BOX25:entity ALU.LOAD(AR_LOAD)port map(R1, LOAD_OUT1);
	 BOX26:entity ALU.LOAD(AR_LOAD)port map(Const, LOAD_OUT2);
		 					
OPPR:process(Sel, LOAD_OUT1, LOAD_OUT2, REZADD,REZADDCY,REZSUB,REZSUBCY,REZADD_CON,REZADDCY_CON,REZSUB_CON,REZSUBCY_CON,CRADD,CRADDCY,CRSUB,CRSUBCY,CRADD_CON,CRADDCY_CON,
        CRSUB_CON,CRSUBCY_CON,XOR_REG,AND_REG,OR_REG,XOR_CON,AND_CON,OR_CON,REZSR0,REZSR1,REZSRX,REZSRA,REZRR,REZSL0,REZSL1,REZSLX,REZSLA,REZRL)is
	begin
			
		case Sel is
			when "00000" =>
			Rez <= LOAD_OUT1;
			when "00001" =>
			Rez <= LOAD_OUT2;
				when "01000" =>
				   Rez <= REZADD;
				   CR <= CRADD;
				   INTERMEDIAR<=REZADD;
				   
				 when "01001" =>
				    Rez <= REZADD_CON;
				 	CR <= CRADD_CON;
					 INTERMEDIAR<=REZADD_CON;
					 
				 when "01010" =>
				   Rez <= REZADDCY;
				   CR <= CRADDCY; 
				   INTERMEDIAR<=REZADDCY;
				   
				   when "01011" =>
				      Rez <= REZADDCY_CON;
		 			  CR <=  CRADDCY_CON;
					  INTERMEDIAR<=REZADDCY_CON;
					  
					when "01100" =>
					    Rez <= REZSUB;
						CR <= CRSUB;
						INTERMEDIAR<=REZSUB;
						
					when "01101" =>
					   Rez <= REZSUB_CON;
					   CR <=  CRSUB_CON;
					   INTERMEDIAR<=REZSUB_CON;
					   
					 when "01110" =>
					     Rez <= REZSUBCY;
	 					 CR <= CRSUBCY;
						 INTERMEDIAR<=REZSUBCY;
						 
					 when "01111" =>
					   Rez <= REZSUBCY_CON;
					   CR <= CRSUBCY_CON; 
					   INTERMEDIAR<=REZSUBCY_CON;
					   
					   when "00010" => 
					     Rez <= AND_REG;
					  	 CR <='0';
						 INTERMEDIAR<= AND_REG;	
						 
						when "00011" =>
						  Rez <=AND_CON;
						  CR <='0';
						  INTERMEDIAR<=AND_CON;
						  
						 when "00100" =>
						  Rez <= OR_REG;
						  CR <='0';
						  INTERMEDIAR<= OR_REG;
						  
						  when "00101" =>
						   Rez <=OR_CON;
						   CR<='0';
						   INTERMEDIAR<=OR_CON;
						   
						  when "00110"=>
						     Rez<=XOR_REG;
						     CR<='0';
							INTERMEDIAR<=XOR_REG;	
							
						   when "00111" =>
						      Rez<=XOR_CON;
						      CR<='0';
						      INTERMEDIAR<=XOR_CON;
							  
							  when "10000" =>
							  Rez<= REZSR0;
							  CR <=cr6;
							  INTERMEDIAR<= REZSR0;
							  
							  when "10001" =>
							  Rez <=REZSR1;
							  CR<=cr7;
							  INTERMEDIAR<=REZSR1;
							  
							  when "10010"=>
							  Rez <=REZSRX;
							  CR<=cr8;
							  INTERMEDIAR<=REZSRX; 
							  
							  when "10011"=>
							  Rez <=REZSRA;
							  CR<=cr9;
							  INTERMEDIAR<=REZSRA;
							  
							  when "10100"=>
							  Rez <=REZRR;
							  CR<=cr10;
							  INTERMEDIAR<=REZRR;
							  
							  when "10101"=>
							  Rez<=REZSL0;
							  CR<=cr1;
							  INTERMEDIAR<=REZSL0;
							  
							  when "10110" =>
							  Rez <=REZSL1;
							  CR<=cr2;
							  INTERMEDIAR<=REZSL1;
							  
							  when "10111"=>
							  Rez<=REZSLX;
							  CR <= cr3;
							  INTERMEDIAR<=REZSLX; 
							  
							  when "11000"=>
							  Rez<=REZSLA;
							  CR<=cr4;
							  INTERMEDIAR<=REZSLA;
							  
							  when "11001"=>
							  Rez<=REZRL;
							  CR<=cr5;
							  INTERMEDIAR<=REZRL;
					   
					   when others => 
					    null;
					    
			end case;
			
	end process;
	
	ZEROFLAGPRO:process (INTERMEDIAR)
	  begin
	    if INTERMEDIAR="00000000" then 
		   ZR<='1';
	    else
		  ZR<='0';
		end if;
	end process;	
					   
	 end ARHITECTURA_ALU;
	 
	 
	 
		 
	  
	  