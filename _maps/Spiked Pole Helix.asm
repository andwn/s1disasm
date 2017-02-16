# ---------------------------------------------------------------------------
# Sprite mappings - helix of spikes on a pole (GHZ)
# ---------------------------------------------------------------------------
Map_Hel:	dc.w byte_7E08-Map_Hel, byte_7E0E-Map_Hel
		dc.w byte_7E14-Map_Hel, byte_7E1A-Map_Hel
		dc.w byte_7E20-Map_Hel, byte_7E26-Map_Hel
		dc.w byte_7E2D+2-Map_Hel, byte_7E2C-Map_Hel
byte_7E08:	dc.b 1
		dc.b 0xF0, 1, 0,	0, 0xFC	/* points straight up (harmful) */
byte_7E0E:	dc.b 1
		dc.b 0xF5, 5, 0,	2, 0xF8	/* 45 degree */
byte_7E14:	dc.b 1
		dc.b 0xF8, 5, 0,	6, 0xF8	/* 90 degree */
byte_7E1A:	dc.b 1
		dc.b 0xFB, 5, 0,	0xA, 0xF8	/* 45 degree */
byte_7E20:	dc.b 1
		dc.b 0,	1, 0, 0xE, 0xFC	/* straight down */
byte_7E26:	dc.b 1
		dc.b 4,	0, 0, 0x10, 0xFD	/* 45 degree */
byte_7E2D:	/* reads the 0 below	; not visible */
byte_7E2C:	dc.b 1
		dc.b 0xF4, 0, 0,	0x11, 0xFD /* 45 degree */
		.align 2
