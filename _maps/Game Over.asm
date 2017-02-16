# ---------------------------------------------------------------------------
# Sprite mappings - "GAME OVER"	and "TIME OVER"
# ---------------------------------------------------------------------------
Map_Over:	dc.w byte_CBAC-Map_Over
		dc.w byte_CBB7-Map_Over
		dc.w byte_CBC2-Map_Over
		dc.w byte_CBCD-Map_Over
byte_CBAC:	dc.b 2			/* GAME */
		dc.b 0xF8, 0xD, 0, 0, 0xB8
		dc.b 0xF8, 0xD, 0, 8, 0xD8
byte_CBB7:	dc.b 2			/* OVER */
		dc.b 0xF8, 0xD, 0, 0x14, 8
		dc.b 0xF8, 0xD, 0, 0xC, 0x28
byte_CBC2:	dc.b 2			/* TIME */
		dc.b 0xF8, 9, 0,	0x1C, 0xC4
		dc.b 0xF8, 0xD, 0, 8, 0xDC
byte_CBCD:	dc.b 2			/* OVER */
		dc.b 0xF8, 0xD, 0, 0x14, 0xC
		dc.b 0xF8, 0xD, 0, 0xC, 0x2C
		.align 2
