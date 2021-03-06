# ---------------------------------------------------------------------------
# Sprite mappings - giant ring
# ---------------------------------------------------------------------------
Map_GRing:	dc.w byte_9FDA-Map_GRing, byte_A00D-Map_GRing
		dc.w byte_A036-Map_GRing, byte_A04B-Map_GRing
byte_9FDA:	dc.b 0xA
		dc.b 0xE0, 8, 0,	0, 0xE8	/* ring front */
		dc.b 0xE0, 8, 0,	3, 0
		dc.b 0xE8, 0xC, 0, 6, 0xE0
		dc.b 0xE8, 0xC, 0, 0xA, 0
		dc.b 0xF0, 7, 0,	0xE, 0xE0
		dc.b 0xF0, 7, 0,	0x16, 0x10
		dc.b 0x10, 0xC, 0, 0x1E, 0xE0
		dc.b 0x10, 0xC, 0, 0x22, 0
		dc.b 0x18, 8, 0,	0x26, 0xE8
		dc.b 0x18, 8, 0,	0x29, 0
byte_A00D:	dc.b 8
		dc.b 0xE0, 0xC, 0, 0x2C, 0xF0 /* ring angle */
		dc.b 0xE8, 8, 0,	0x30, 0xE8
		dc.b 0xE8, 9, 0,	0x33, 0
		dc.b 0xF0, 7, 0,	0x39, 0xE8
		dc.b 0xF8, 5, 0,	0x41, 8
		dc.b 8,	9, 0, 0x45, 0
		dc.b 0x10, 8, 0,	0x4B, 0xE8
		dc.b 0x18, 0xC, 0, 0x4E, 0xF0
byte_A036:	dc.b 4
		dc.b 0xE0, 7, 0,	0x52, 0xF4 /* ring perpendicular */
		dc.b 0xE0, 3, 8,	0x52, 4
		dc.b 0,	7, 0, 0x5A, 0xF4
		dc.b 0,	3, 8, 0x5A, 4
byte_A04B:	dc.b 8
		dc.b 0xE0, 0xC, 8, 0x2C, 0xF0 /* ring angle */
		dc.b 0xE8, 8, 8,	0x30, 0
		dc.b 0xE8, 9, 8,	0x33, 0xE8
		dc.b 0xF0, 7, 8,	0x39, 8
		dc.b 0xF8, 5, 8,	0x41, 0xE8
		dc.b 8,	9, 8, 0x45, 0xE8
		dc.b 0x10, 8, 8,	0x4B, 0
		dc.b 0x18, 0xC, 8, 0x4E, 0xF0
		.align 2
