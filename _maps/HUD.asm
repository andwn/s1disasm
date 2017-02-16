# ---------------------------------------------------------------------------
# Sprite mappings - SCORE, TIME, RINGS
# ---------------------------------------------------------------------------
Map_HUD:	dc.w AT_1_allyellow-Map_HUD, AT_1_ringred-Map_HUD
		dc.w AT_1_timered-Map_HUD, AT_1_allred-Map_HUD
AT_1_allyellow:	dc.b 0xA
		dc.b 0x80, 0xD, 0x80, 0, 0
		dc.b 0x80, 0xD, 0x80, 0x18,	0x20
		dc.b 0x80, 0xD, 0x80, 0x20,	0x40
		dc.b 0x90, 0xD, 0x80, 0x10,	0
		dc.b 0x90, 0xD, 0x80, 0x28,	0x28
		dc.b 0xA0, 0xD, 0x80, 8, 0
		dc.b 0xA0, 1, 0x80, 0, 0x20
		dc.b 0xA0, 9, 0x80, 0x30, 0x30
		dc.b 0x40, 5, 0x81, 0xA, 0
		dc.b 0x40, 0xD, 0x81, 0xE, 0x10
		dc.b 0
AT_1_ringred:	dc.b 0xA
		dc.b 0x80, 0xD, 0x80, 0, 0
		dc.b 0x80, 0xD, 0x80, 0x18,	0x20
		dc.b 0x80, 0xD, 0x80, 0x20,	0x40
		dc.b 0x90, 0xD, 0x80, 0x10,	0
		dc.b 0x90, 0xD, 0x80, 0x28,	0x28
		dc.b 0xA0, 0xD, 0xA0, 8, 0
		dc.b 0xA0, 1, 0xA0, 0, 0x20
		dc.b 0xA0, 9, 0x80, 0x30, 0x30
		dc.b 0x40, 5, 0x81, 0xA, 0
		dc.b 0x40, 0xD, 0x81, 0xE, 0x10
		dc.b 0
AT_1_timered:	dc.b 0xA
		dc.b 0x80, 0xD, 0x80, 0, 0
		dc.b 0x80, 0xD, 0x80, 0x18,	0x20
		dc.b 0x80, 0xD, 0x80, 0x20,	0x40
		dc.b 0x90, 0xD, 0xA0, 0x10,	0
		dc.b 0x90, 0xD, 0x80, 0x28,	0x28
		dc.b 0xA0, 0xD, 0x80, 8, 0
		dc.b 0xA0, 1, 0x80, 0, 0x20
		dc.b 0xA0, 9, 0x80, 0x30, 0x30
		dc.b 0x40, 5, 0x81, 0xA, 0
		dc.b 0x40, 0xD, 0x81, 0xE, 0x10
		dc.b 0
AT_1_allred:	dc.b 0xA
		dc.b 0x80, 0xD, 0x80, 0, 0
		dc.b 0x80, 0xD, 0x80, 0x18,	0x20
		dc.b 0x80, 0xD, 0x80, 0x20,	0x40
		dc.b 0x90, 0xD, 0xA0, 0x10,	0
		dc.b 0x90, 0xD, 0x80, 0x28,	0x28
		dc.b 0xA0, 0xD, 0xA0, 8, 0
		dc.b 0xA0, 1, 0xA0, 0, 0x20
		dc.b 0xA0, 9, 0x80, 0x30, 0x30
		dc.b 0x40, 5, 0x81, 0xA, 0
		dc.b 0x40, 0xD, 0x81, 0xE, 0x10
		.align 2


