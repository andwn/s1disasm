# ---------------------------------------------------------------------------
# Sprite mappings - smashable green block (MZ)
# ---------------------------------------------------------------------------
Map_Smab:	dc.w AT_13_two-Map_Smab
		dc.w AT_13_four-Map_Smab
AT_13_two:		dc.b 2
		dc.b 0xF0, 0xD, 0, 0, 0xF0	/* two fragments, arranged vertically */
		dc.b 0,	0xD, 0, 0, 0xF0
AT_13_four:		dc.b 4
		dc.b 0xF0, 5, 0x80, 0, 0xF0 /* four fragments */
		dc.b 0,	5, 0x80,	0, 0xF0
		dc.b 0xF0, 5, 0x80, 0, 0
		dc.b 0,	5, 0x80,	0, 0
		.align 2
