;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _ball_movement
	.globl _ai_movement
	.globl _movement
	.globl _init_ball
	.globl _init_AI
	.globl _init_player
	.globl _update_score
	.globl _init_score
	.globl _moveCharacter
	.globl _start_game
	.globl _init_map
	.globl _init_min_font
	.globl _flashy_start
	.globl _play_score
	.globl _play_jumpy_sound
	.globl _sound_init
	.globl _initGame
	.globl _make_show_win_map
	.globl _toString
	.globl _strlen
	.globl _rand
	.globl _initrand
	.globl _free
	.globl _malloc
	.globl _puts
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _get_bkg_data
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpad
	.globl _joypad
	.globl _timer
	.globl _canAImove
	.globl _yBall
	.globl _xBall
	.globl _gamePaused
	.globl _screenTitleMap
	.globl _clearBKGTiles
	.globl _ball_alive
	.globl _ballCentre
	.globl _AICentre
	.globl _speed_x
	.globl _speed_y
	.globl _AI
	.globl _player
	.globl _ball
	.globl _low
	.globl _mid
	.globl _top
	.globl _TileLabel
	.globl _pressStartMap
	.globl _character
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_player::
	.ds 14
_AI::
	.ds 14
_speed_y::
	.ds 1
_speed_x::
	.ds 1
_AICentre::
	.ds 1
_ballCentre::
	.ds 1
_ball_alive::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_clearBKGTiles::
	.ds 360
_screenTitleMap::
	.ds 360
_gamePaused::
	.ds 1
_xBall::
	.ds 2
_yBall::
	.ds 2
_canAImove::
	.ds 1
_timer::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;utils/tools.c:81: char* toString(uint8 num)
;	---------------------------------
; Function toString
; ---------------------------------
_toString::
	dec	sp
;utils/tools.c:86: uint8_t size = number_count_minimal(num);
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x0a
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00111$
	ld	e, #0x00
	jr	00113$
00111$:
	ld	a, c
	sub	a, #0x64
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00109$
	ld	e, #0x01
	jr	00113$
00109$:
	ld	a, c
	sub	a, #0xe8
	ld	a, b
	sbc	a, #0x03
	jr	NC, 00107$
	ld	e, #0x02
	jr	00113$
00107$:
	ld	e, #0x03
00113$:
;utils/tools.c:88: char *a = malloc((size + 1) * sizeof(char));
	ld	c, e
	ld	b, #0x00
	inc	bc
	push	de
	push	bc
	call	_malloc
	pop	hl
	ld	c, e
	ld	b, d
	pop	de
;utils/tools.c:93: uint8_t i = size + 1;
;utils/tools.c:94: a[i --] = '\0';
	inc	e
	ld	a, e
	dec	a
	ldhl	sp,	#0
	ld	(hl), a
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0x00
;utils/tools.c:96: while(num)
00101$:
	ldhl	sp,	#4
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00103$
;utils/tools.c:98: a[i --] = digits[num%10];
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	dec	(hl)
	push	bc
	push	de
	ld	hl, #0x000a
	push	hl
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	call	__moduint
	add	sp, #4
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	push	de
	ld	de, #_toString_digits_65536_153
	add	hl, de
	pop	de
	ld	a, (hl)
	ld	(de), a
;utils/tools.c:99: num /=10;
	push	bc
	ld	de, #0x000a
	push	de
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	__divuint
	add	sp, #4
	pop	bc
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	jr	00101$
00103$:
;utils/tools.c:102: return a;
	ld	e, c
	ld	d, b
;utils/tools.c:104: }
	inc	sp
	ret
_character:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0xfd	; 253
	.db #0x83	; 131
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0xe9	; 233
	.db #0x97	; 151
	.db #0xd1	; 209
	.db #0xaf	; 175
	.db #0xe9	; 233
	.db #0x97	; 151
	.db #0xd1	; 209
	.db #0xaf	; 175
	.db #0x62	; 98	'b'
	.db #0x5e	; 94
	.db #0x3c	; 60
	.db #0x3c	; 60
_pressStartMap:
	.db #0x1a	; 26
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x1c	; 28
	.db #0x1e	; 30
_clear_map:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_toString_digits_65536_153:
	.ascii "0123456789"
	.db 0x00
;utils/tools.c:206: void make_show_win_map(int x, int y, int h, char text[])
;	---------------------------------
; Function make_show_win_map
; ---------------------------------
_make_show_win_map::
	add	sp, #-8
;utils/tools.c:209: int w = strlen(text);
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_strlen
	add	sp, #4
	push	de
;utils/tools.c:211: unsigned char* win_map = malloc(sizeof(unsigned char) * w * h);
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	__mulint
	add	sp, #4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_malloc
	pop	hl
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;utils/tools.c:213: for(int i = 0; i < w * h; ++i)
	ld	bc, #0x0000
00142$:
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00167$
	bit	7, d
	jr	NZ, 00168$
	cp	a, a
	jr	00168$
00167$:
	bit	7, d
	jr	Z, 00168$
	scf
00168$:
	jp	NC, 00101$
;utils/tools.c:215: win_map[i] = transform_text(text[i]);
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
;utils/tools.c:109: switch(text)
	ld	l, a
	xor	a, #0x80
	sub	a, #0xb0
	jp	C, 00138$
	ld	e, l
	ld	a,#0x5a
	ld	d,a
	sub	a, l
	bit	7, e
	jr	Z, 00169$
	bit	7, d
	jr	NZ, 00170$
	cp	a, a
	jr	00170$
00169$:
	bit	7, d
	jr	Z, 00170$
	scf
00170$:
	jp	C, 00138$
	ld	a, l
	add	a, #0xd0
	ld	e, a
	ld	d, #0x00
	ld	hl, #00171$
	add	hl, de
	add	hl, de
	add	hl, de
	jp	(hl)
00171$:
	jp	00128$
	jp	00129$
	jp	00130$
	jp	00131$
	jp	00132$
	jp	00133$
	jp	00134$
	jp	00135$
	jp	00136$
	jp	00137$
	jp	00138$
	jp	00138$
	jp	00138$
	jp	00138$
	jp	00138$
	jp	00138$
	jp	00138$
	jp	00102$
	jp	00103$
	jp	00104$
	jp	00105$
	jp	00106$
	jp	00107$
	jp	00108$
	jp	00109$
	jp	00110$
	jp	00111$
	jp	00112$
	jp	00113$
	jp	00114$
	jp	00115$
	jp	00116$
	jp	00117$
	jp	00118$
	jp	00119$
	jp	00120$
	jp	00121$
	jp	00122$
	jp	00123$
	jp	00124$
	jp	00125$
	jp	00126$
	jp	00127$
;utils/tools.c:111: case 'A':
00102$:
;utils/tools.c:112: return A;
	ld	a, #0x0b
	jp	00140$
;utils/tools.c:113: case 'B':
00103$:
;utils/tools.c:114: return B;
	ld	a, #0x0c
	jp	00140$
;utils/tools.c:115: case 'C':
00104$:
;utils/tools.c:116: return C;
	ld	a, #0x0d
	jp	00140$
;utils/tools.c:117: case 'D':
00105$:
;utils/tools.c:118: return D;
	ld	a, #0x0e
	jp	00140$
;utils/tools.c:119: case 'E':
00106$:
;utils/tools.c:120: return E;
	ld	a, #0x0f
	jp	00140$
;utils/tools.c:121: case 'F':
00107$:
;utils/tools.c:122: return F;
	ld	a, #0x10
	jr	00140$
;utils/tools.c:123: case 'G':
00108$:
;utils/tools.c:124: return G;
	ld	a, #0x11
	jr	00140$
;utils/tools.c:125: case 'H':
00109$:
;utils/tools.c:126: return H;
	ld	a, #0x12
	jr	00140$
;utils/tools.c:127: case 'I':
00110$:
;utils/tools.c:128: return I;
	ld	a, #0x13
	jr	00140$
;utils/tools.c:129: case 'J':
00111$:
;utils/tools.c:130: return J;
	ld	a, #0x14
	jr	00140$
;utils/tools.c:131: case 'K':
00112$:
;utils/tools.c:132: return K;
	ld	a, #0x15
	jr	00140$
;utils/tools.c:133: case 'L':
00113$:
;utils/tools.c:134: return L;
	ld	a, #0x16
	jr	00140$
;utils/tools.c:135: case 'M':
00114$:
;utils/tools.c:136: return M;
	ld	a, #0x17
	jr	00140$
;utils/tools.c:137: case 'N':
00115$:
;utils/tools.c:138: return N;
	ld	a, #0x18
	jr	00140$
;utils/tools.c:139: case 'O':
00116$:
;utils/tools.c:140: return O;
	ld	a, #0x19
	jr	00140$
;utils/tools.c:141: case 'P':
00117$:
;utils/tools.c:142: return P;
	ld	a, #0x1a
	jr	00140$
;utils/tools.c:143: case 'Q':
00118$:
;utils/tools.c:144: return Q;
	ld	a, #0x1b
	jr	00140$
;utils/tools.c:145: case 'R':
00119$:
;utils/tools.c:146: return R;
	ld	a, #0x1c
	jr	00140$
;utils/tools.c:147: case 'S':
00120$:
;utils/tools.c:148: return S;
	ld	a, #0x1d
	jr	00140$
;utils/tools.c:149: case 'T':
00121$:
;utils/tools.c:150: return T;
	ld	a, #0x1e
	jr	00140$
;utils/tools.c:151: case 'U':
00122$:
;utils/tools.c:152: return U;
	ld	a, #0x1f
	jr	00140$
;utils/tools.c:153: case 'V':
00123$:
;utils/tools.c:154: return V;
	ld	a, #0x20
	jr	00140$
;utils/tools.c:155: case 'W':
00124$:
;utils/tools.c:156: return W;
	ld	a, #0x21
	jr	00140$
;utils/tools.c:157: case 'X':
00125$:
;utils/tools.c:158: return X;
	ld	a, #0x22
	jr	00140$
;utils/tools.c:159: case 'Y':
00126$:
;utils/tools.c:160: return Y;
	ld	a, #0x23
	jr	00140$
;utils/tools.c:161: case 'Z':
00127$:
;utils/tools.c:162: return Z;
	ld	a, #0x24
	jr	00140$
;utils/tools.c:163: case '0':
00128$:
;utils/tools.c:164: return ZERO;
	ld	a, #0x01
	jr	00140$
;utils/tools.c:165: case '1':
00129$:
;utils/tools.c:166: return ONE;
	ld	a, #0x02
	jr	00140$
;utils/tools.c:167: case '2':
00130$:
;utils/tools.c:168: return TWO;
	ld	a, #0x03
	jr	00140$
;utils/tools.c:169: case '3':
00131$:
;utils/tools.c:170: return THREE;
	ld	a, #0x04
	jr	00140$
;utils/tools.c:171: case '4':
00132$:
;utils/tools.c:172: return FOUR;
	ld	a, #0x05
	jr	00140$
;utils/tools.c:173: case '5':
00133$:
;utils/tools.c:174: return FIVE;
	ld	a, #0x06
	jr	00140$
;utils/tools.c:175: case '6':
00134$:
;utils/tools.c:176: return SIX;
	ld	a, #0x07
	jr	00140$
;utils/tools.c:177: case '7':
00135$:
;utils/tools.c:178: return SEVEN;
	ld	a, #0x08
	jr	00140$
;utils/tools.c:179: case '8':
00136$:
;utils/tools.c:180: return EIGHT;
	ld	a, #0x09
	jr	00140$
;utils/tools.c:181: case '9':
00137$:
;utils/tools.c:182: return NINE;
	ld	a, #0x0a
	jr	00140$
;utils/tools.c:183: default:
00138$:
;utils/tools.c:184: return 0x00;
	xor	a, a
;utils/tools.c:215: win_map[i] = transform_text(text[i]);
00140$:
	ldhl	sp,	#6
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils/tools.c:213: for(int i = 0; i < w * h; ++i)
	inc	bc
	jp	00142$
00101$:
;utils/tools.c:218: set_win_tiles(x, y, w, h, win_map);
	ldhl	sp,	#14
	ld	c, (hl)
	ldhl	sp,	#0
	ld	b, (hl)
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ld	a, c
	push	af
	inc	sp
	ld	c, e
	push	bc
	push	de
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;utils/tools.c:220: free(win_map);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_free
	pop	hl
;utils/tools.c:222: }
	add	sp, #8
	ret
;utils/tools.c:241: void initGame() {
;	---------------------------------
; Function initGame
; ---------------------------------
_initGame::
;utils/tools.c:249: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;utils/tools.c:251: printf("\n\n\n\n\n\n\n      PRESS START!\n");
	ld	de, #___str_2
	push	de
	call	_puts
	pop	hl
;utils/tools.c:252: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;utils/tools.c:233: uint16_t seed = LY_REG;
	ldh	a, (_LY_REG + 0)
	ld	c, a
	ld	b, #0x00
;utils/tools.c:234: seed |= (uint16_t)DIV_REG << 8;
	ldh	a, (_DIV_REG + 0)
	ld	e, a
	xor	a, a
	or	a, c
	ld	c, a
	ld	a, e
	or	a, b
	ld	b, a
;utils/tools.c:235: initrand(seed);
	push	bc
	call	_initrand
	pop	hl
;utils/tools.c:254: printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	ld	de, #___str_4
	push	de
	call	_puts
	pop	hl
;utils/tools.c:255: }
	ret
___str_2:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "      PRESS START!"
	.db 0x00
___str_4:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x00
;utils/Sound/sound.c:4: void sound_init() {
;	---------------------------------
; Function sound_init
; ---------------------------------
_sound_init::
;utils/Sound/sound.c:6: NR52_REG = 0x80;                //  Turns on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;utils/Sound/sound.c:7: NR50_REG = 0x77;                //  Sets the volume to max
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;utils/Sound/sound.c:8: NR51_REG = 0xFF;                
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;utils/Sound/sound.c:9: }
	ret
;utils/Sound/sound.c:11: void play_jumpy_sound() {
;	---------------------------------
; Function play_jumpy_sound
; ---------------------------------
_play_jumpy_sound::
;utils/Sound/sound.c:20: NR10_REG = 0x06;
	ld	a, #0x06
	ldh	(_NR10_REG + 0), a
;utils/Sound/sound.c:28: NR11_REG = 0x88;
	ld	a, #0x88
	ldh	(_NR11_REG + 0), a
;utils/Sound/sound.c:38: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;utils/Sound/sound.c:44: NR13_REG = 0x01;
	ld	a, #0x01
	ldh	(_NR13_REG + 0), a
;utils/Sound/sound.c:54: NR14_REG = 0xC7;
	ld	a, #0xc7
	ldh	(_NR14_REG + 0), a
;utils/Sound/sound.c:57: }
	ret
;utils/Sound/sound.c:59: void play_score()
;	---------------------------------
; Function play_score
; ---------------------------------
_play_score::
;utils/Sound/sound.c:69: NR10_REG = 0x06;
	ld	a, #0x06
	ldh	(_NR10_REG + 0), a
;utils/Sound/sound.c:77: NR11_REG = 0x88;
	ld	a, #0x88
	ldh	(_NR11_REG + 0), a
;utils/Sound/sound.c:87: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;utils/Sound/sound.c:93: NR13_REG = 0x01;
	ld	a, #0x01
	ldh	(_NR13_REG + 0), a
;utils/Sound/sound.c:103: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;utils/Sound/sound.c:108: }
	ret
;main.c:49: void flashy_start(uint8_t frames)
;	---------------------------------
; Function flashy_start
; ---------------------------------
_flashy_start::
	dec	sp
;main.c:51: for(uint8_t i = 0; i < frames; ++i)
	ldhl	sp,	#0
	ld	(hl), #0x00
00113$:
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#3
	sub	a, (hl)
	jr	NC, 00115$
;main.c:53: set_bkg_tiles(5, 12, 11, 1, pressStartMap);
	ld	de, #_pressStartMap
	push	de
	ld	hl, #0x10b
	push	hl
	ld	hl, #0xc05
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;main.c:52: {
	ld	bc, #0x0000
00107$:
	ld	a, c
	sub	a, #0x03
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00103$
;utils/tools.c:53: wait_vbl_done();
	call	_wait_vbl_done
;utils/tools.c:52: for(i = 0; i < loops; i++){
	inc	bc
	jr	00107$
;main.c:54: performanceDelay(3);
00103$:
;main.c:55: set_bkg_tiles(5, 12, 11, 1, clear_map);
	ld	de, #_clear_map
	push	de
	ld	hl, #0x10b
	push	hl
	ld	hl, #0xc05
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;main.c:52: {
	ld	bc, #0x0000
00110$:
	ld	a, c
	sub	a, #0x03
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00105$
;utils/tools.c:53: wait_vbl_done();
	call	_wait_vbl_done
;utils/tools.c:52: for(i = 0; i < loops; i++){
	inc	bc
	jr	00110$
;main.c:56: performanceDelay(3);
00105$:
;main.c:51: for(uint8_t i = 0; i < frames; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	00113$
00115$:
;main.c:59: }
	inc	sp
	ret
_TileLabel:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0x9b	; 155
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x76	; 118	'v'
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x63	; 99	'c'
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xcc	; 204
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0xd9	; 217
	.db #0x00	; 0
	.db #0xdd	; 221
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x00	; 0
	.db #0xd9	; 217
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x00	; 0
	.db #0xb3	; 179
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_top:
	.db #0x00	; 0
_mid:
	.db #0x01	; 1
_low:
	.db #0x02	; 2
_ball:
	.db #0x03	; 3
;main.c:61: void init_min_font()
;	---------------------------------
; Function init_min_font
; ---------------------------------
_init_min_font::
;main.c:67: font_init();
	call	_font_init
;main.c:68: min_font = font_load(font_min);
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:70: font_set(min_font);
	push	de
	call	_font_set
	pop	hl
;main.c:77: }
	ret
;main.c:82: void init_map()
;	---------------------------------
; Function init_map
; ---------------------------------
_init_map::
;main.c:86: get_bkg_data(0, 14, TileLabel);   //  Ignores the 'air' tile
	ld	bc, #_TileLabel+0
	push	bc
	ld	hl, #0xe00
	push	hl
	call	_get_bkg_data
	add	sp, #4
;main.c:87: set_bkg_data(MAP_START, 14, TileLabel);
	push	bc
	ld	hl, #0xe25
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:88: set_bkg_tiles(3, 0, 20, 18, screenTitleMap);
	ld	de, #_screenTitleMap
	push	de
	ld	hl, #0x1214
	push	hl
	ld	hl, #0x03
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;main.c:90: set_bkg_tiles(5, 12, 11, 1, pressStartMap);
	ld	de, #_pressStartMap
	push	de
	ld	hl, #0x10b
	push	hl
	ld	hl, #0xc05
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;main.c:92: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:98: }
	ret
;main.c:101: void start_game()
;	---------------------------------
; Function start_game
; ---------------------------------
_start_game::
;main.c:103: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:105: init_min_font();
	call	_init_min_font
;main.c:106: sound_init();
	call	_sound_init
;main.c:108: init_map();
	call	_init_map
;main.c:110: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:112: flashy_start(5);
	ld	a, #0x05
	push	af
	inc	sp
	call	_flashy_start
	inc	sp
;main.c:113: gamePaused = 0;
	ld	hl, #_gamePaused
	ld	(hl), #0x00
;main.c:115: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;main.c:118: }
	ret
;main.c:124: void moveCharacter(Character* charac, uint8 x, uint8 y)
;	---------------------------------
; Function moveCharacter
; ---------------------------------
_moveCharacter::
	add	sp, #-6
;main.c:126: move_sprite(charac->spriteids[0], x, y);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	c, l
	ld	b, h
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl+)
	inc	hl
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:127: move_sprite(charac->spriteids[1], x, y + SPRITE_HEIGHT);
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
;main.c:128: move_sprite(charac->spriteids[2], x, y + 2 * SPRITE_HEIGHT);
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	a, (hl)
	add	a, #0x10
	ld	c, a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;main.c:128: move_sprite(charac->spriteids[2], x, y + 2 * SPRITE_HEIGHT);
;main.c:129: }
	add	sp, #6
	ret
;main.c:134: void init_score()
;	---------------------------------
; Function init_score
; ---------------------------------
_init_score::
;main.c:136: make_show_win_map(AI_TILE_LOCATION, 1, 1, "0");
	ld	de, #___str_5
	push	de
	ld	de, #0x0001
	push	de
	push	de
	ld	de, #0x0001
	push	de
	call	_make_show_win_map
	add	sp, #8
;main.c:138: make_show_win_map(PLAYER_TILE_LOCATION, 1, 1, "0");
	ld	de, #___str_5
	push	de
	ld	de, #0x0001
	push	de
	push	de
	ld	de, #0x0011
	push	de
	call	_make_show_win_map
	add	sp, #8
;main.c:140: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;main.c:141: }
	ret
___str_5:
	.ascii "0"
	.db 0x00
;main.c:144: void update_score(uint8 score, uint8_t tile)
;	---------------------------------
; Function update_score
; ---------------------------------
_update_score::
	add	sp, #-5
;main.c:146: clear_portion(tile);
	ldhl	sp,	#9
	ld	b, (hl)
;utils/tools.c:41: set_win_tiles(x, 1, 8, 1, clear_map);    
	ld	de, #_clear_map
	push	de
	ld	hl, #0x108
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;main.c:150: : tile + number_count_minimal(score), 1, 1, toString(score));
	push	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_toString
	pop	hl
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	pop	bc
;main.c:149: ? tile - number_count_minimal(score)
	ldhl	sp,	#2
	ld	a, b
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
	ld	d, (hl)
;utils/tools.c:60: if(score < 10)
	ld	a, c
	sub	a, #0x0a
	ld	a, d
	sbc	a, #0x00
	ld	a, #0x00
	rla
;	spillPairReg hl
;	spillPairReg hl
;utils/tools.c:64: else if(score < 100)
	ld	a, c
	sub	a, #0x64
	ld	a, d
	sbc	a, #0x00
	ld	a, #0x00
	rla
	ld	e, a
;utils/tools.c:68: else if(score < 1000)
	ld	a, c
	sub	a, #0xe8
	ld	a, d
	sbc	a, #0x03
	ld	a, #0x00
	rla
	ldhl	sp,	#4
	ld	(hl), a
;main.c:149: ? tile - number_count_minimal(score)
	ld	a, b
;utils/tools.c:60: if(score < 10)
	sub	a,#0x11
	jr	NZ, 00124$
	or	a,l
	jr	Z, 00109$
;utils/tools.c:62: return 0;
	ld	e, #0x00
	jr	00111$
00109$:
;utils/tools.c:64: else if(score < 100)
	ld	a, e
	or	a, a
	jr	Z, 00107$
;utils/tools.c:66: return 1;
	ld	e, #0x01
	jr	00111$
00107$:
;utils/tools.c:68: else if(score < 1000)
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
;utils/tools.c:70: return 2;
;utils/tools.c:72: else return 3;
;main.c:149: ? tile - number_count_minimal(score)
	ld	e, #0x02
	jr	NZ, 00111$
	ld	e, #0x03
00111$:
	ld	c, e
	ld	b, #0x00
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	c, e
	jr	00125$
00124$:
;utils/tools.c:60: if(score < 10)
	ld	a, l
	or	a, a
	jr	Z, 00119$
;utils/tools.c:62: return 0;
	ld	c, #0x00
	jr	00121$
00119$:
;utils/tools.c:64: else if(score < 100)
	ld	a, e
	or	a, a
	jr	Z, 00117$
;utils/tools.c:66: return 1;
	ld	c, #0x01
	jr	00121$
00117$:
;utils/tools.c:68: else if(score < 1000)
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
;utils/tools.c:70: return 2;
;utils/tools.c:72: else return 3;
;main.c:150: : tile + number_count_minimal(score), 1, 1, toString(score));
	ld	c, #0x02
	jr	NZ, 00121$
	ld	c, #0x03
00121$:
	ld	b, #0x00
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	a, h
00125$:
	pop	de
	push	de
	push	de
	ld	de, #0x0001
	push	de
	push	de
	ld	b, a
	push	bc
	call	_make_show_win_map
;main.c:152: }
	add	sp, #13
	ret
;main.c:155: void init_player()
;	---------------------------------
; Function init_player
; ---------------------------------
_init_player::
;main.c:157: player.width = 8;
	ld	hl, #(_player + 10)
	ld	a, #0x08
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:158: player.height = 24;
	ld	hl, #(_player + 8)
	ld	a, #0x18
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:160: player.x = 140;
	ld	bc, #_player + 6
	ld	a, #0x8c
	ld	(bc), a
;main.c:161: player.y = MIDY;
	ld	hl, #(_player + 7)
	ld	(hl), #0x48
;main.c:163: player.score = 0;
	ld	hl, #(_player + 12)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:166: player.spriteids[0] = 0;
	ld	hl, #_player
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
;main.c:168: player.spriteids[1] = 1;
	ld	hl, #(_player + 2)
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
;main.c:170: player.spriteids[2] = 2;
	ld	hl, #(_player + 4)
	ld	a, #0x02
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:172: moveCharacter(&player, player.x, player.y);
	ld	a, (#(_player + 7) + 0)
	ld	e, a
	ld	d, #0x00
	ld	a, (bc)
	ld	b, #0x00
	push	de
	ld	c, a
	push	bc
	ld	de, #_player
	push	de
	call	_moveCharacter
	add	sp, #6
;main.c:174: }
	ret
;main.c:176: void init_AI()
;	---------------------------------
; Function init_AI
; ---------------------------------
_init_AI::
;main.c:178: AI.width = 8;
	ld	hl, #(_AI + 10)
	ld	a, #0x08
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:179: AI.height = 24;
	ld	hl, #(_AI + 8)
	ld	a, #0x18
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:181: AI.x = 20;
	ld	hl, #(_AI + 6)
	ld	(hl), #0x14
;main.c:182: AI.y = MIDY;
	ld	hl, #(_AI + 7)
	ld	(hl), #0x48
;main.c:184: AI.score = 0;
	ld	hl, #(_AI + 12)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x00
;main.c:187: AI.spriteids[0] = 3;
	ld	hl, #_AI
	ld	a, #0x03
	ld	(hl+), a
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x01
;main.c:189: AI.spriteids[1] = 4;
	ld	hl, #(_AI + 2)
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x02
;main.c:191: AI.spriteids[2] = 5;
	ld	hl, #(_AI + 4)
	ld	a, #0x05
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:193: AICentre = AI.y + AI.height/2;
	ld	hl, #(_AI + 7)
	ld	c, (hl)
	ld	hl, #(_AI + 8)
	ld	a, (hl+)
	ld	b, a
	ld	l, (hl)
;	spillPairReg hl
	srl	l
	rr	b
	ld	a, b
	add	a, c
	ld	(#_AICentre),a
;main.c:195: moveCharacter(&AI, AI.x, AI.y);
	ld	a, (#(_AI + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	a, (#(_AI + 6) + 0)
	ld	d, #0x00
	push	bc
	ld	e, a
	push	de
	ld	de, #_AI
	push	de
	call	_moveCharacter
	add	sp, #6
;main.c:197: }
	ret
;main.c:199: void init_ball()
;	---------------------------------
; Function init_ball
; ---------------------------------
_init_ball::
;main.c:201: xBall = MIDX;
	ld	hl, #_xBall
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:202: yBall = MIDY + SPRITE_HEIGHT;
	ld	hl, #_yBall
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:204: ballCentre = yBall + 4;
	ld	hl, #_ballCentre
	ld	(hl), #0x54
;main.c:207: speed_y = 3;
	ld	hl, #_speed_y
	ld	(hl), #0x03
;main.c:208: speed_x = 1;
	ld	hl, #_speed_x
	ld	(hl), #0x01
;main.c:210: ball_alive = 1;
	ld	hl, #_ball_alive
	ld	(hl), #0x01
;main.c:215: set_sprite_tile(BALL_SPRITE, ball);
	ld	hl, #_ball
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), c
;main.c:216: move_sprite(BALL_SPRITE, xBall, yBall);
	ld	hl, #_yBall
	ld	b, (hl)
	ld	hl, #_xBall
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:216: move_sprite(BALL_SPRITE, xBall, yBall);
;main.c:217: }
	ret
;main.c:266: void movement()
;	---------------------------------
; Function movement
; ---------------------------------
_movement::
;main.c:268: if(UP)
	call	_joypad
	bit	2, e
	jr	Z, 00102$
;main.c:270: player.y -= 4;
	ld	bc, #_player+7
	ld	a, (bc)
	add	a, #0xfc
	ld	(bc), a
00102$:
;main.c:274: if(DOWN)
	call	_joypad
	bit	3, e
	jr	Z, 00104$
;main.c:276: player.y += 4;
	ld	bc, #_player+7
	ld	a, (bc)
	add	a, #0x04
	ld	(bc), a
00104$:
;main.c:280: if(player.y <= 20)
	ld	hl, #_player + 7
	ld	c, (hl)
	ld	a, #0x14
	sub	a, c
	jr	C, 00108$
;main.c:281: player.y = 20;
	ld	(hl), #0x14
	jr	00109$
00108$:
;main.c:282: else if(player.y >= SCREENHEIGHT - 20)
	ld	a, c
	sub	a, #0x7c
	jr	C, 00109$
;main.c:283: player.y = SCREENHEIGHT - 20;
	ld	(hl), #0x7c
00109$:
;main.c:285: moveCharacter(&player, player.x, player.y);
	ld	c, (hl)
	ld	b, #0x00
	ld	a, (#(_player + 6) + 0)
	ld	d, #0x00
	push	bc
	ld	e, a
	push	de
	ld	de, #_player
	push	de
	call	_moveCharacter
	add	sp, #6
;main.c:287: }
	ret
;main.c:289: void ai_movement(uint8_t offset, uint8_t speed)
;	---------------------------------
; Function ai_movement
; ---------------------------------
_ai_movement::
	add	sp, #-6
;main.c:294: if(AICentre + offset < ballCentre)
	ld	a, (#_AICentre)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_ballCentre)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00133$
	bit	7, d
	jr	NZ, 00134$
	cp	a, a
	jr	00134$
00133$:
	bit	7, d
	jr	Z, 00134$
	scf
00134$:
	jr	NC, 00104$
;main.c:296: AI.y += speed;
	ld	bc, #_AI+7
	ld	a, (bc)
	ldhl	sp,	#9
	add	a, (hl)
	ld	(bc), a
	jr	00105$
00104$:
;main.c:298: else if(AICentre - offset > ballCentre)
	pop	de
	push	de
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	b, a
	ld	c, e
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00135$
	bit	7, d
	jr	NZ, 00136$
	cp	a, a
	jr	00136$
00135$:
	bit	7, d
	jr	Z, 00136$
	scf
00136$:
	jr	NC, 00105$
;main.c:300: AI.y -= speed;
	ld	a, (#(_AI + 7) + 0)
	ldhl	sp,	#9
	sub	a, (hl)
	ld	(#(_AI + 7)),a
00105$:
;main.c:303: if(AI.y <= 20)
	ld	hl, #(_AI + 7)
	ld	c, (hl)
	ld	a, #0x14
	sub	a, c
	jr	C, 00109$
;main.c:304: AI.y = 20;
	ld	hl, #(_AI + 7)
	ld	(hl), #0x14
	jr	00110$
00109$:
;main.c:305: else if(AI.y >= SCREENHEIGHT - 20)
	ld	a, c
	sub	a, #0x7c
	jr	C, 00110$
;main.c:306: AI.y = SCREENHEIGHT - 20;
	ld	hl, #(_AI + 7)
	ld	(hl), #0x7c
00110$:
;main.c:308: AICentre = AI.y + AI.height/2;
	ld	a, (#(_AI + 7) + 0)
	ldhl	sp,	#3
	ld	(hl), a
	ld	de, #(_AI + 8)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	add	a, (hl)
	ld	(#_AICentre),a
;main.c:310: moveCharacter(&AI, AI.x, AI.y);
	ld	a, (#(_AI + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	a, (#(_AI + 6) + 0)
	ld	d, #0x00
	push	bc
	ld	e, a
	push	de
	ld	de, #_AI
	push	de
	call	_moveCharacter
;main.c:312: }
	add	sp, #12
	ret
;main.c:346: void ball_movement()
;	---------------------------------
; Function ball_movement
; ---------------------------------
_ball_movement::
	add	sp, #-16
;main.c:349: UBYTE collisioned = collision(&player) || collision(&AI);
	ld	a, (#(_player + 6) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_xBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #_yBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #_xBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_xBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ld	hl, #_yBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ld	hl, #_yBall
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	a, (#(_player + 6) + 0)
	ld	(hl+), a
	ld	(hl), #0x00
	inc	hl
	ld	e, a
	ld	d, #0x00
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	hl, #_xBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00124$
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00124$
	ld	a, (#(_player + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_yBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00124$
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	NC, 00139$
00124$:
	ld	de, #_xBall
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00128$
	ld	hl, #(_player + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_xBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00128$
	ld	hl, #(_player + 7)
	ld	c, (hl)
	ld	b, c
	ld	e, #0x00
	ld	hl, #_yBall
	ld	a, (hl+)
	sub	a, b
	ld	a, (hl)
	sbc	a, e
	jr	C, 00128$
	ld	b, #0x00
	ld	hl, #(_player + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_yBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00139$
00128$:
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00140$
	ld	hl, #(_player + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00140$
	ld	hl, #(_player + 7)
	ld	c, (hl)
	ld	b, c
	ld	e, #0x00
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, b
	ld	a, (hl)
	sbc	a, e
	jp	C, 00140$
	ld	b, #0x00
	ld	hl, #(_player + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00140$
00139$:
	ld	hl, #(_player + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_xBall
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00136$
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(#_xBall),a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(#_xBall + 1),a
	jp	00174$
00136$:
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ld	hl, #_xBall
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00134$
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_xBall),a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_xBall + 1),a
	jp	00174$
00134$:
	ld	a, (#(_player + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #(_player + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_yBall
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00132$
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_yBall),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_yBall + 1),a
	jp	00174$
00132$:
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_yBall),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_yBall + 1),a
	jp	00174$
00140$:
	ld	a, (#(_AI + 6) + 0)
	ld	c, a
	ld	b, #0x00
	ld	a, (#(_AI + 6) + 0)
	ldhl	sp,	#12
	ld	(hl+), a
	ld	(hl), #0x00
	inc	hl
	ld	e, a
	ld	d, #0x00
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	hl, #_xBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00148$
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00148$
	ld	a, (#(_AI + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_yBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00148$
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jp	NC, 00163$
00148$:
	ld	de, #_xBall
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00152$
	ld	hl, #(_AI + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_xBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00152$
	ld	hl, #(_AI + 7)
	ld	c, (hl)
	ld	b, c
	ld	e, #0x00
	ld	hl, #_yBall
	ld	a, (hl+)
	sub	a, b
	ld	a, (hl)
	sbc	a, e
	jr	C, 00152$
	ld	b, #0x00
	ld	hl, #(_AI + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_yBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00163$
00152$:
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00164$
	ld	hl, #(_AI + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C, 00164$
	ld	hl, #(_AI + 7)
	ld	c, (hl)
	ld	b, c
	ld	e, #0x00
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, b
	ld	a, (hl)
	sbc	a, e
	jp	C, 00164$
	ld	b, #0x00
	ld	hl, #(_AI + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00164$
00163$:
	ld	hl, #(_AI + 10)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_xBall
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00160$
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(#_xBall),a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(#_xBall + 1),a
	jr	00174$
00160$:
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ld	hl, #_xBall
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00158$
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_xBall),a
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_xBall + 1),a
	jr	00174$
00158$:
	ld	a, (#(_AI + 7) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #(_AI + 8)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_yBall
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00156$
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_yBall),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_yBall + 1),a
	jr	00174$
00156$:
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_yBall),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_yBall + 1),a
	jr	00174$
00164$:
	xor	a, a
	jr	00175$
00174$:
	ld	a, #0x01
00175$:
;main.c:351: if(collisioned)
	or	a, a
	jp	Z, 00107$
;main.c:355: speed_y = (rand() % 10 - 5) * -1;
	call	_rand
	ld	d, #0x00
	ld	bc, #0x000a
	push	bc
	push	de
	call	__modsint
	add	sp, #4
	ld	a, e
	add	a, #0xfb
	ld	c, a
	xor	a, a
	sub	a, c
	ld	(#_speed_y),a
;main.c:356: if((speed_x > -4 && speed_x < 0) || (speed_x < 4 && speed_x > 0))
	ld	hl, #_speed_x
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00338$
	bit	7, d
	jr	NZ, 00339$
	cp	a, a
	jr	00339$
00338$:
	bit	7, d
	jr	Z, 00339$
	scf
00339$:
	ld	a, #0x00
	rla
	ld	c, a
	ld	hl, #_speed_x
	ld	e, (hl)
	ld	a,#0xfc
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00340$
	bit	7, d
	jr	NZ, 00341$
	cp	a, a
	jr	00341$
00340$:
	bit	7, d
	jr	Z, 00341$
	scf
00341$:
	jr	NC, 00105$
	ld	a, (#_speed_x)
	bit	7, a
	jr	NZ, 00101$
00105$:
	ld	a, (#_speed_x)
	xor	a, #0x80
	sub	a, #0x84
	jr	NC, 00102$
	ld	a, c
	or	a, a
	jr	Z, 00102$
00101$:
;main.c:358: speed_x > 0 ? ++speed_x : --speed_x;        //  Acceleration
	ld	a, c
	or	a, a
	jr	Z, 00176$
	ld	hl, #_speed_x
	inc	(hl)
	jr	00102$
00176$:
	ld	hl, #_speed_x
	dec	(hl)
00102$:
;main.c:361: speed_x *= -1;
	xor	a, a
	ld	hl, #_speed_x
	sub	a, (hl)
	ld	(hl), a
;main.c:363: canAImove = !canAImove;
	ld	hl, #_canAImove
	ld	a, (hl)
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;main.c:367: play_jumpy_sound();
	call	_play_jumpy_sound
00107$:
;main.c:372: speed_y *= -1;
	xor	a, a
	ld	hl, #_speed_y
	sub	a, (hl)
	ld	c, a
;main.c:370: if(yBall <= 20)
	ld	hl, #_yBall
	ld	a, #0x14
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	C, 00111$
;main.c:372: speed_y *= -1;
	ld	hl, #_speed_y
	ld	(hl), c
	jr	00112$
00111$:
;main.c:374: else if(yBall >= SCREENHEIGHT)
	ld	hl, #_yBall
	ld	a, (hl+)
	sub	a, #0x90
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00112$
;main.c:376: speed_y *= -1;
	ld	hl, #_speed_y
	ld	(hl), c
00112$:
;main.c:381: if((xBall >= player.x + player.width + 2))
	ld	a, (#(_player + 6) + 0)
	ld	c, a
	ld	b, #0x00
	ld	hl, #_player + 10
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ld	hl, #_xBall
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00116$
;main.c:383: AI.score++;
	ld	hl, #(_AI + 12)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_AI + 12)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:384: update_score(AI.score, AI_TILE_LOCATION);
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	call	_update_score
	add	sp, #3
;main.c:385: play_score();
	call	_play_score
;main.c:320: timer = FRAMES_TO_WAIT;
	ld	hl, #_timer
	ld	(hl), #0x0a
;main.c:321: ball_alive = 0;
	ld	hl, #_ball_alive
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0xff
;main.c:387: kill_ball();
	jr	00117$
00116$:
;main.c:391: else if((xBall <= AI.x - 2))
	ld	a, (#(_AI + 6) + 0)
	ld	b, #0x00
	ld	c, a
	dec	bc
	dec	bc
	ld	hl, #_xBall
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00117$
;main.c:393: player.score++;
	ld	hl, #(_player + 12)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_player + 12)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:394: update_score(player.score, PLAYER_TILE_LOCATION);
	ld	a, #0x11
	push	af
	inc	sp
	push	bc
	call	_update_score
	add	sp, #3
;main.c:395: play_score();
	call	_play_score
;main.c:320: timer = FRAMES_TO_WAIT;
	ld	hl, #_timer
	ld	(hl), #0x0a
;main.c:321: ball_alive = 0;
	ld	hl, #_ball_alive
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0xff
;main.c:397: kill_ball();
00117$:
;main.c:402: xBall += speed_x;
	ld	a, (#_speed_x)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_xBall
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
	ld	(hl), a
;main.c:403: yBall += speed_y;
	ld	a, (#_speed_y)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	hl, #_yBall
	ld	a, (hl)
	add	a, c
	ld	(hl+), a
	ld	a, (hl)
	adc	a, b
;main.c:404: ballCentre = yBall + 4;
	ld	(hl-), a
	ld	c, (hl)
	ld	a, c
	add	a, #0x04
	ld	(#_ballCentre),a
;main.c:406: move_sprite(BALL_SPRITE, xBall, yBall);
	ld	hl, #_xBall
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:407: wait_vbl_done();
	call	_wait_vbl_done
;main.c:408: }
	add	sp, #16
	ret
;main.c:411: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:414: start_game();
	call	_start_game
;main.c:417: init_score();
	call	_init_score
;main.c:419: set_sprite_data(0, 4, character);
	ld	de, #_character
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;main.c:421: init_player();
	call	_init_player
;main.c:422: init_AI();
	call	_init_AI
;main.c:423: init_ball();
	call	_init_ball
;main.c:426: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:428: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:430: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;utils/tools.c:233: uint16_t seed = LY_REG;
	ldh	a, (_LY_REG + 0)
	ld	c, a
	ld	b, #0x00
;utils/tools.c:234: seed |= (uint16_t)DIV_REG << 8;
	ldh	a, (_DIV_REG + 0)
	ld	e, a
	xor	a, a
	or	a, c
	ld	c, a
	ld	a, e
	or	a, b
	ld	b, a
;utils/tools.c:235: initrand(seed);
	push	bc
	call	_initrand
	pop	hl
;main.c:433: while(1)
00115$:
;main.c:436: if(ball_alive)
	ld	a, (#_ball_alive)
	or	a, a
	jr	Z, 00109$
;main.c:438: ball_movement();
	call	_ball_movement
	jr	00110$
00109$:
;main.c:440: else if(!ball_alive && !timer)
	ld	a, (#_ball_alive)
	or	a, a
	jr	NZ, 00105$
	ld	a, (#_timer)
	or	a, a
	jr	NZ, 00105$
;main.c:330: xBall = MIDX;
	ld	hl, #_xBall
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:331: yBall = MIDY + SPRITE_HEIGHT;
	ld	hl, #_yBall
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:333: ballCentre = yBall + 4;
	ld	hl, #_ballCentre
	ld	(hl), #0x54
;main.c:335: speed_y = (rand() % 10 - 5);
	call	_rand
	ld	d, #0x00
	ld	bc, #0x000a
	push	bc
	push	de
	call	__modsint
	add	sp, #4
	ld	a, e
	add	a, #0xfb
	ld	(#_speed_y),a
;main.c:336: speed_x = 1;
	ld	hl, #_speed_x
	ld	(hl), #0x01
;main.c:338: canAImove = 0;
	ld	hl, #_canAImove
	ld	(hl), #0x00
;main.c:340: set_sprite_tile(BALL_SPRITE, ball);
	ld	hl, #_ball
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), c
;main.c:342: move_sprite(BALL_SPRITE, xBall, yBall);
	ld	hl, #_yBall
	ld	b, (hl)
	ld	hl, #_xBall
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;c:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:443: ball_alive = 1;
	ld	hl, #_ball_alive
	ld	(hl), #0x01
	jr	00110$
00105$:
;main.c:445: else if(!ball_alive && timer)
	ld	a, (#_ball_alive)
	or	a, a
	jr	NZ, 00110$
	ld	hl, #_timer
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
;main.c:447: --timer;
	dec	(hl)
00110$:
;main.c:450: movement();
	call	_movement
;main.c:452: if(ball_alive && canAImove)
	ld	a, (#_ball_alive)
	or	a, a
	jr	Z, 00137$
	ld	a, (#_canAImove)
	or	a, a
	jr	Z, 00137$
;main.c:454: ai_movement(0, 4);
	ld	hl, #0x400
	push	hl
	call	_ai_movement
	pop	hl
;main.c:52: {
00137$:
	ld	bc, #0x0000
00124$:
	ld	a, c
	sub	a, #0x01
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00115$
;utils/tools.c:53: wait_vbl_done();
	call	_wait_vbl_done
;utils/tools.c:52: for(i = 0; i < loops; i++){
	inc	bc
;main.c:465: performanceDelay(1);        //  More fluid but you gotta modify the speeds
;main.c:470: }
	jr	00124$
	.area _CODE
	.area _INITIALIZER
__xinit__clearBKGTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__screenTitleMap:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__gamePaused:
	.db #0x01	; 1
__xinit__xBall:
	.dw #0x0050
__xinit__yBall:
	.dw #0x0048
__xinit__canAImove:
	.db #0x00	; 0
__xinit__timer:
	.db #0x00	; 0
	.area _CABS (ABS)
