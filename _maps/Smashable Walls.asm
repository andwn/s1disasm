# ---------------------------------------------------------------------------
# Sprite mappings - smashable walls (GHZ, SLZ)
# ---------------------------------------------------------------------------
Map_Smash:	dc.w AT_64_left-Map_Smash
		dc.w AT_64_middle-Map_Smash
		dc.w AT_64_right-Map_Smash
AT_64_left:		dc.b 8
		dc.b 0xE0, 5, 0,	0, 0xF0
		dc.b 0xF0, 5, 0,	0, 0xF0
		dc.b 0,	5, 0, 0, 0xF0
		dc.b 0x10, 5, 0,	0, 0xF0
		dc.b 0xE0, 5, 0,	4, 0
		dc.b 0xF0, 5, 0,	4, 0
		dc.b 0,	5, 0, 4, 0
		dc.b 0x10, 5, 0,	4, 0
AT_64_middle:	dc.b 8
		dc.b 0xE0, 5, 0,	4, 0xF0
		dc.b 0xF0, 5, 0,	4, 0xF0
		dc.b 0,	5, 0, 4, 0xF0
		dc.b 0x10, 5, 0,	4, 0xF0
		dc.b 0xE0, 5, 0,	4, 0
		dc.b 0xF0, 5, 0,	4, 0
		dc.b 0,	5, 0, 4, 0
		dc.b 0x10, 5, 0,	4, 0
AT_64_right:		dc.b 8
		dc.b 0xE0, 5, 0,	4, 0xF0
		dc.b 0xF0, 5, 0,	4, 0xF0
		dc.b 0,	5, 0, 4, 0xF0
		dc.b 0x10, 5, 0,	4, 0xF0
		dc.b 0xE0, 5, 0,	8, 0
		dc.b 0xF0, 5, 0,	8, 0
		dc.b 0,	5, 0, 8, 0
		dc.b 0x10, 5, 0,	8, 0
		.align 2
