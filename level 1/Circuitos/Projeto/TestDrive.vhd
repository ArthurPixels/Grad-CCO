library ieee;
use ieee.std_logic_1164.all;
entity TestDrive is
port	( 	
			CLOCK_50: in std_logic;
			KEY : IN std_logic_vector(3 downto 0);
			SW : IN STD_LOGIC_VECTOR(9 downto 0);
			LEDR : OUT STD_LOGIC_VECTOR(9 downto 0);
			HEX0: OUT STD_LOGIC_VECTOR(6 downto 0);
			HEX1: OUT STD_LOGIC_VECTOR(6 downto 0);
			HEX2: OUT STD_LOGIC_VECTOR(6 downto 0);
			HEX3: OUT STD_LOGIC_VECTOR(6 downto 0);
			HEX4: OUT STD_LOGIC_VECTOR(6 downto 0);
			HEX5: OUT STD_LOGIC_VECTOR(6 downto 0)

		);
end TestDrive;

architecture TestDrive_estru of TestDrive is
	------Maps------
	--MAP1
	signal
	MAP1_0,MAP1_1,MAP1_2,MAP1_3,MAP1_4,
	MAP1_5,MAP1_6,MAP1_7,MAP1_8,MAP1_9,
	MAP1_10,MAP1_11,MAP1_12,MAP1_13,MAP1_14,MAP1_15
	: std_logic_vector (31 downto 0);
	--MAP2
	signal
	MAP2_0,MAP2_1,MAP2_2,MAP2_3,MAP2_4,
	MAP2_5,MAP2_6,MAP2_7,MAP2_8,MAP2_9,
	MAP2_10,MAP2_11,MAP2_12,MAP2_13,MAP2_14,MAP2_15
	: std_logic_vector (31 downto 0);
	--MAP3
	signal
	MAP3_0,MAP3_1,MAP3_2,MAP3_3,MAP3_4,
	MAP3_5,MAP3_6,MAP3_7,MAP3_8,MAP3_9,
	MAP3_10,MAP3_11,MAP3_12,MAP3_13,MAP3_14,MAP3_15
	: std_logic_vector (31 downto 0);
	--MAP4
	signal
	MAP4_0,MAP4_1,MAP4_2,MAP4_3,MAP4_4,
	MAP4_5,MAP4_6,MAP4_7,MAP4_8,MAP4_9,
	MAP4_10,MAP4_11,MAP4_12,MAP4_13,MAP4_14,MAP4_15
	: std_logic_vector (31 downto 0);
    --REG_IN
	signal
    REG_IN_0,REG_IN_1,REG_IN_2,REG_IN_3,REG_IN_4,
    REG_IN_5,REG_IN_6,REG_IN_7,REG_IN_8,REG_IN_9,
    REG_IN_10,REG_IN_11,REG_IN_12,REG_IN_13,REG_IN_14,REG_IN_15
	: std_logic_vector (31 downto 0);
	--REG_OUT
	signal
	REG_OUT,
	REG_OUT_0,REG_OUT_1,REG_OUT_2,REG_OUT_3,REG_OUT_4,
	REG_OUT_5,REG_OUT_6,REG_OUT_7,REG_OUT_8,REG_OUT_9,
	REG_OUT_10,REG_OUT_11,REG_OUT_12,REG_OUT_13,REG_OUT_14,REG_OUT_15
	: std_logic_vector (31 downto 0);
	--CLK
	signal SCREEN, HX : std_logic_vector (29 downto 0);
	signal CNT_D,CNT_U,POINT,LED_OUT : std_logic_vector (9 downto 0);
	signal CNT_B, STATES : std_logic_vector (4 downto 0);
	signal UP_DOWN,BTN : std_logic_vector (3 downto 0);
	signal SPEED : std_logic_vector (2 downto 0);
	signal SEL_DISP : std_logic_vector (1 downto 0);
	signal SEL_LED,EN_TIME,CLOCK_M,RST,SET_ROL,END_TIME,END_BONUS,TARGET,
		CLK1,CLK2,CLK3,CLK4,CLK5: std_logic;

--//////////////////Components///////////////////////////////////

	component FSM_Control
	port (
		RESET,ENTER,END_TIME,END_BONUS,TARGET,CLOCK: in std_logic;
		STATES: out std_logic_vector(4 downto 0);
		SEL_DISP: out std_logic_vector(1 downto 0);
		SEL_LED,SET_ROL,EN_TIME,RST: out std_logic
	);
	end component;

    ------registradores------

    component FSM_Position port (
        CHAVES: in std_logic_vector(1 downto 0);
        EN_TIME: in std_logic;
        SPEED: in std_logic_vector (2 downto 0);
        CLOCK_M: in std_logic;
        RST: in std_logic;
        UP_DOWN: out std_logic_vector (3 downto 0)
    );
    end component;

    component FSM_Speed port (
        ACC: in std_logic;
        BRK: in std_logic;
        EN_TIME: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;
        SPEED: out std_logic_vector(2 downto 0)
    );
    end component;

    component ROL1 port (
		  REG_IN: in std_logic_vector(31 downto 0);
        SET_ROL: in std_logic;
        EN_TIME: in std_logic;
        SPEED: in std_logic_vector (2 downto 0);
        CLOCK_M: in std_logic;
        RST: in std_logic;
        REG_OUT: out std_logic_vector (31 downto 0)
    );
    end component;

    -----Comparadores-------

    component COMPARADOR_10 port (
        a: in std_logic_vector(9 downto 0);
        b: in std_logic_vector(9 downto 0);
        s: out std_logic
    );
	end component;

    component COMPARADOR_5 port (
		a: in std_logic_vector(4 downto 0);
		b: in std_logic_vector(4 downto 0);
		s: out std_logic
    );
	end component;

    component SOMADOR port (
		a: in std_logic_vector(9 downto 0);
		b: in std_logic_vector(9 downto 0);
		s: out std_logic_vector(9 downto 0)
    );
	end component;

    --------MAPAS----------
    component map1
	port
	(
		F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15: out std_logic_vector(31 downto 0)
	);
    end component;

    component map2
	port
	(
		F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15: out std_logic_vector(31 downto 0)
	);
    end component;

    component map3
	port
	(
		F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15: out std_logic_vector(31 downto 0)
	);
    end component;

    component map4
	port
	(
		F0, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15: out std_logic_vector(31 downto 0)
	);
    end component;

    ------Contadores-------
    component FSM_clock port (
        CLK: in std_logic;
        CLK1: out std_logic;
        CLK2: out std_logic;
        CLK3: out std_logic;
        CLK4: out std_logic;
        CLK5: out std_logic
    );
	end component;

    component CONTA_DES port (
        EN_TIME: in std_logic;
        CLK1: in std_logic;
        RST: in std_logic;
        CNT_D: out std_logic_vector(9 downto 0)
    );
    end component;

    component CONTA_DESU port (
        REG_ROM31: in std_logic;
        EN_TIME: in std_logic;
        CLK_M: in std_logic;
        RST: in std_logic;
        CNT_B: out std_logic_vector(4 downto 0)
    );
    end component;

    component CONTA_ASC port (
        EN_TIME: in std_logic;
        SPEED: in std_logic_vector(2 downto 0);
        CLK_M: in std_logic;
        RST: in std_logic;
        CNT_U: out std_logic_vector(9 downto 0)
    );
    end component;

    -------MUX-----------
	component MUX_2x1_10
	port	(
			a: in std_logic_vector (9 downto 0);
			b: in std_logic_vector (9 downto 0);

			s: in std_logic;
			x: out std_logic_vector (9 downto 0)
		);
	end component;

	component MUX_2x1_30
	port	(
			a: in std_logic_vector (29 downto 0);
			b: in std_logic_vector (29 downto 0);

			s: in std_logic;
			x: out std_logic_vector (29 downto 0)
		);
	end component;

	component MUX_4x1_30
	port	(
			a: in std_logic_vector (29 downto 0);
			b: in std_logic_vector (29 downto 0);
			c: in std_logic_vector (29 downto 0);
			d: in std_logic_vector (29 downto 0);

			s: in std_logic_vector (1 downto 0);
			x: out std_logic_vector (29 downto 0)
		);
	end component;

	component MUX_4x1_32
	port	(
			a: in std_logic_vector (31 downto 0);
			b: in std_logic_vector (31 downto 0);
			c: in std_logic_vector (31 downto 0);
			d: in std_logic_vector (31 downto 0);

			s: in std_logic_vector (1 downto 0);
			x: out std_logic_vector (31 downto 0)
		);
	end component;

	component MUX_8x1
	port	(	a: in std_logic;
			b: in std_logic;
			c: in std_logic;
			d: in std_logic;

			e: in std_logic;
			f: in std_logic;
			g: in std_logic;
			h: in std_logic;

			s: in std_logic_vector (2 downto 0);
			x: out std_logic
		);
	end component;

	component MUX_16x1_32
	port	(
			a: in std_logic_vector (31 downto 0);
			b: in std_logic_vector (31 downto 0);
			c: in std_logic_vector (31 downto 0);
			d: in std_logic_vector (31 downto 0);

			e: in std_logic_vector (31 downto 0);
			f: in std_logic_vector (31 downto 0);
			g: in std_logic_vector (31 downto 0);
			h: in std_logic_vector (31 downto 0);

			i: in std_logic_vector (31 downto 0);
			j: in std_logic_vector (31 downto 0);
			k: in std_logic_vector (31 downto 0);
			l: in std_logic_vector (31 downto 0);

			m: in std_logic_vector (31 downto 0);
			n: in std_logic_vector (31 downto 0);
			o: in std_logic_vector (31 downto 0);
			p: in std_logic_vector (31 downto 0);

			s: in  std_logic_vector (3 downto 0);
			x: out std_logic_vector (31 downto 0)
		);
	end component;

	component Decodificador7seg
	port (C: in std_logic_vector(4 downto 0);
			F: out std_logic_vector(6 downto 0)
	);
	end component;
	
	--------Debouncer---------
	component ButtonSync
	port(
		-- Input ports
		key0	: in  std_logic;
		key1	: in  std_logic;
		key2	: in  std_logic;
		key3	: in  std_logic;	
		clk : in std_logic;
		-- Output ports
		btn0	: out std_logic;
		btn1	: out std_logic;
		btn2	: out std_logic;
		btn3	: out std_logic
	);
	end component;

--/////////////////PORT MAPs//////////////////////////////////////

begin
	C000: FSM_Control port map (BTN(0),BTN(1),END_TIME,END_BONUS,TARGET,CLOCK_50,STATES,
				SEL_DISP,SEL_LED,SET_ROL,EN_TIME,RST);
    ---------Registradores------------
    R500: ROL1 port map (REG_IN_0,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_0);
    R501: ROL1 port map (REG_IN_1,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_1);
    R502: ROL1 port map (REG_IN_2,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_2);
    R503: ROL1 port map (REG_IN_3,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_3);

    R504: ROL1 port map (REG_IN_4,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_4);
    R505: ROL1 port map (REG_IN_5,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_5);
    R506: ROL1 port map (REG_IN_6,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_6);
    R507: ROL1 port map (REG_IN_7,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_7);

    R508: ROL1 port map (REG_IN_8,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_8);
    R509: ROL1 port map (REG_IN_9,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_9);
    R510: ROL1 port map (REG_IN_10,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_10);
    R511: ROL1 port map (REG_IN_11,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_11);

    R512: ROL1 port map (REG_IN_12,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_12);
    R513: ROL1 port map (REG_IN_13,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_13);
    R514: ROL1 port map (REG_IN_14,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_14);
    R515: ROL1 port map (REG_IN_15,SET_ROL,EN_TIME,SPEED,CLOCK_M,RST,REG_OUT_15);

    R600: FSM_Position port map (SW(1 downto 0),EN_TIME,SPEED,CLOCK_M,RST,UP_DOWN);
    R601: FSM_Speed port map (BTN(2),BTN(3),EN_TIME,CLOCK_50,RST,SPEED);

    -----Comparadores---------
    C01: COMPARADOR_10 port map ("0000000000",CNT_D,END_TIME);
    C02: COMPARADOR_10 port map ("0010001000",CNT_U,TARGET); --bug adkfjsbhgalkjdgoa
    C03: COMPARADOR_5  port map ("00000",CNT_B,END_BONUS);
    C04: SOMADOR port map ("0000" & CNT_B & '0',CNT_U,POINT);

    -------Contadores---------
    C11: FSM_clock  port map (CLOCK_50,CLK1,CLK2,CLK3,CLK4,CLK5);
    C12: CONTA_DES  port map (EN_TIME,CLK1,RST,CNT_D);
    C13: CONTA_ASC  port map (EN_TIME,SPEED,CLOCK_M,RST,CNT_U);
    C14: CONTA_DESU port map (REG_OUT(31),EN_TIME,CLOCK_M,RST,CNT_B);

    ---------MAPAS---------
    M01: MAP1 port map (
			MAP1_0,MAP1_1,MAP1_2,MAP1_3,MAP1_4,
			MAP1_5,MAP1_6,MAP1_7,MAP1_8,MAP1_9,
			MAP1_10,MAP1_11,MAP1_12,MAP1_13,MAP1_14,MAP1_15);

    M02: MAP2 port map (
			MAP2_0,MAP2_1,MAP2_2,MAP2_3,MAP2_4,
			MAP2_5,MAP2_6,MAP2_7,MAP2_8,MAP2_9,
			MAP2_10,MAP2_11,MAP2_12,MAP2_13,MAP2_14,MAP2_15);

    M03: MAP3 port map (
			MAP3_0,MAP3_1,MAP3_2,MAP3_3,MAP3_4,
			MAP3_5,MAP3_6,MAP3_7,MAP3_8,MAP3_9,
			MAP3_10,MAP3_11,MAP3_12,MAP3_13,MAP3_14,MAP3_15);

    M04: MAP4 port map (
			MAP4_0,MAP4_1,MAP4_2,MAP4_3,MAP4_4,
			MAP4_5,MAP4_6,MAP4_7,MAP4_8,MAP4_9,
			MAP4_10,MAP4_11,MAP4_12,MAP4_13,MAP4_14,MAP4_15);

	------------MUX-------------------
	L00: MUX_2x1_10 	port map ("0000000000", CLK5 & REG_OUT(30 downto 22),SEL_LED,LED_OUT);
	L01: MUX_2x1_30 	port map ("01110"& STATES & "01011" & CNT_B & CNT_D,
			"11011" & "00" & SPEED & "00000" & "0" & UP_DOWN & CNT_U, SW(9),SCREEN);

	L02: MUX_4x1_30 	port map (SCREEN, "01110" & STATES & "101100101010111000" & SW(8) & SW(7),
			"01110" & STATES & "11111000000111101111", "01110" & STATES & "1011111010" & POINT,
			SEL_DISP, HX);

	R400: MUX_4x1_32 	port map (MAP1_0,MAP2_0,MAP3_0,MAP4_0,SW(8 downto 7), REG_IN_0);
	R401: MUX_4x1_32 	port map (MAP1_1,MAP2_1,MAP3_1,MAP4_1,SW(8 downto 7), REG_IN_1);
	R402: MUX_4x1_32 	port map (MAP1_2,MAP2_2,MAP3_2,MAP4_2,SW(8 downto 7), REG_IN_2);
	R403: MUX_4x1_32 	port map (MAP1_3,MAP2_3,MAP3_3,MAP4_3,SW(8 downto 7), REG_IN_3);

	R404: MUX_4x1_32 	port map (MAP1_4,MAP2_4,MAP3_4,MAP4_4,SW(8 downto 7), REG_IN_4);
	R405: MUX_4x1_32 	port map (MAP1_5,MAP2_5,MAP3_5,MAP4_5,SW(8 downto 7), REG_IN_5);
	R406: MUX_4x1_32 	port map (MAP1_6,MAP2_6,MAP3_6,MAP4_6,SW(8 downto 7), REG_IN_6);
	R407: MUX_4x1_32 	port map (MAP1_7,MAP2_7,MAP3_7,MAP4_7,SW(8 downto 7), REG_IN_7);

	R408: MUX_4x1_32 	port map (MAP1_8,MAP2_8,MAP3_8,MAP4_8,SW(8 downto 7), REG_IN_8);
	R409: MUX_4x1_32 	port map (MAP1_9,MAP2_9,MAP3_9,MAP4_9,SW(8 downto 7), REG_IN_9);
	R410: MUX_4x1_32 	port map (MAP1_10,MAP2_10,MAP3_10,MAP4_10,SW(8 downto 7), REG_IN_10);
	R411: MUX_4x1_32 	port map (MAP1_11,MAP2_11,MAP3_11,MAP4_11,SW(8 downto 7), REG_IN_11);

	R412: MUX_4x1_32 	port map (MAP1_12,MAP2_12,MAP3_12,MAP4_12,SW(8 downto 7), REG_IN_12);
	R413: MUX_4x1_32 	port map (MAP1_13,MAP2_13,MAP3_13,MAP4_13,SW(8 downto 7), REG_IN_13);
	R414: MUX_4x1_32 	port map (MAP1_14,MAP2_14,MAP3_14,MAP4_14,SW(8 downto 7), REG_IN_14);
	R415: MUX_4x1_32 	port map (MAP1_15,MAP2_15,MAP3_15,MAP4_15,SW(8 downto 7), REG_IN_15);


	L04: MUX_8x1 		port map (CLK1,CLK1,CLK2,CLK3,CLK4,CLK5,CLK1,CLK1,SPEED,CLOCK_M);
	L05: MUX_16x1_32 	port map (
			REG_OUT_0,REG_OUT_1,REG_OUT_2,REG_OUT_3,REG_OUT_4,
			REG_OUT_5,REG_OUT_6,REG_OUT_7,REG_OUT_8,REG_OUT_9,
			REG_OUT_10,REG_OUT_11,REG_OUT_12,REG_OUT_13,REG_OUT_14,REG_OUT_15,
			UP_DOWN,REG_OUT);

	--------------Decodificadores-----------------
	D00: Decodificador7seg 	port map (HX(4 downto 0), HEX0);
	D01: Decodificador7seg 	port map (HX(9 downto 5), HEX1);
	D02: Decodificador7seg 	port map (HX(14 downto 10), HEX2);
	D03: Decodificador7seg 	port map (HX(19 downto 15), HEX3);
	D04: Decodificador7seg 	port map (HX(24 downto 20), HEX4);
	D05: Decodificador7seg 	port map (HX(29 downto 25), HEX5);

	LEDR <= LED_OUT;
	
	--------Debouncer---------
	D10: ButtonSync port map (KEY(0),KEY(1),KEY(2),KEY(3),CLOCK_50,BTN(0),BTN(1),BTN(2),BTN(3));
	
end TestDrive_estru;
