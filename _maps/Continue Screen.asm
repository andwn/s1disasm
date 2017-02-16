# ---------------------------------------------------------------------------
# Sprite mappings - Continue screen
# ---------------------------------------------------------------------------
Map_ContScr:	dc.w M_Cont_text-Map_ContScr, M_Cont_Sonic1-Map_ContScr
		dc.w M_Cont_Sonic2-Map_ContScr, M_Cont_Sonic3-Map_ContScr
		dc.w M_Cont_oval-Map_ContScr, M_Cont_Mini1-Map_ContScr
		dc.w M_Cont_Mini1-Map_ContScr, M_Cont_Mini2-Map_ContScr
M_Cont_text:	dc.b 0xB
		dc.b 0xF8, 5, 0,	0x88, 0xC4 /* "CONTINUE", stars and countdown */
		dc.b 0xF8, 5, 0,	0xB2, 0xD4
		dc.b 0xF8, 5, 0,	0xAE, 0xE4
		dc.b 0xF8, 5, 0,	0xC2, 0xF4
		dc.b 0xF8, 1, 0,	0xA0, 4
		dc.b 0xF8, 5, 0,	0xAE, 0xC
		dc.b 0xF8, 5, 0,	0xC6, 0x1C
		dc.b 0xF8, 5, 0,	0x90, 0x2C
		dc.b 0x38, 5, 0x20, 0x21, 0xE8
		dc.b 0x38, 5, 0x20, 0x21, 8
		dc.b 0x36, 5, 1,	0xFC, 0xF8
M_Cont_Sonic1:	dc.b 3
		dc.b 4,	5, 0, 0x15, 0xFC	/* Sonic	on floor */
		dc.b 0xF4, 0xA, 0, 6, 0xEC
		dc.b 0xF4, 6, 0,	0xF, 4
M_Cont_Sonic2:	dc.b 3
		dc.b 4,	5, 0, 0x19, 0xFC	/* Sonic	on floor #2 */
		dc.b 0xF4, 0xA, 0, 6, 0xEC
		dc.b 0xF4, 6, 0,	0xF, 4
M_Cont_Sonic3:	dc.b 3
		dc.b 4,	5, 0, 0x1D, 0xFC	/* Sonic	on floor #3 */
		dc.b 0xF4, 0xA, 0, 6, 0xEC
		dc.b 0xF4, 6, 0,	0xF, 4
M_Cont_oval:	dc.b 2
		dc.b 0x60, 9, 0x20, 0, 0xE8 /* circle on the floor */
		dc.b 0x60, 9, 0x28, 0, 0
M_Cont_Mini1:	dc.b 1
		dc.b 0,	6, 0, 0x12, 0	/* mini Sonic */
M_Cont_Mini2:	dc.b 1
		dc.b 0,	6, 0, 0x18, 0	/* mini Sonic #2 */
		.align 2
