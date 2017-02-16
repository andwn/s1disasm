# ---------------------------------------------------------------------------
# Sprite mappings - chaos emeralds from	the special stage results screen
# ---------------------------------------------------------------------------
Map_SSRC:	dc.w byte_CE02-Map_SSRC
		dc.w byte_CE08-Map_SSRC
		dc.w byte_CE0E-Map_SSRC
		dc.w byte_CE14-Map_SSRC
		dc.w byte_CE1A-Map_SSRC
		dc.w byte_CE20-Map_SSRC
		dc.w byte_CE26-Map_SSRC
byte_CE02:	dc.b 1
		dc.b 0xF8, 5, 0x20, 4, 0xF8
byte_CE08:	dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8
byte_CE0E:	dc.b 1
		dc.b 0xF8, 5, 0x40, 4, 0xF8
byte_CE14:	dc.b 1
		dc.b 0xF8, 5, 0x60, 4, 0xF8
byte_CE1A:	dc.b 1
		dc.b 0xF8, 5, 0x20, 8, 0xF8
byte_CE20:	dc.b 1
		dc.b 0xF8, 5, 0x20, 0xC, 0xF8
byte_CE26:	dc.b 0			/* Blank frame */
		.align 2
