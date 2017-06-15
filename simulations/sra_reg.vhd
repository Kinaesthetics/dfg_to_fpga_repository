library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.opcodes.all;


entity sra_reg is
	generic(bits : integer := 32);
	port (
		A     : in std_logic_vector(31 downto 0);
		B     : in std_logic_vector(31 downto 0);
		clk   : in std_logic; 
		rst   : in std_logic; 
		input_ready : in std_logic; 
		output_ready : out std_logic; 
		Result : out std_logic_vector(31 downto 0)
		);
end;

architecture behavioral of sra_reg is 

	component sra_n is 
	generic ( bits   : integer :=  bits);
	port ( 
			clk  : in std_logic; 
			A    : in std_logic_vector(31 downto 0);
			B    : in std_logic_vector(31 downto 0);
			result : out std_logic_vector(31 downto 0));
	end component;

	component shift_reg_sra is 
		port(clk      	: in std_logic;
		 	rst	  		: in std_logic;
		 data_in   		: in std_logic;
	     data_out  		: out std_logic);
	end component;

	begin 
		PM_NOR_READY_SIGNAL : shift_reg_sra
		 port map( clk => clk, rst => rst, data_in => input_ready, data_out => output_ready);

		PM_NOR  : sra_n 
		 port map(clk => clk, A => A, B => B, result => Result);

end architecture;  
