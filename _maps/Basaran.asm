# ---------------------------------------------------------------------------
# Sprite mappings - Basaran enemy (MZ)
# ---------------------------------------------------------------------------
Map_Bas:	dc.w AT_129_still-Map_Bas, AT_129_fly1-Map_Bas
		dc.w AT_129_fly2-Map_Bas, AT_129_fly3-Map_Bas
AT_129_still:		dc.b 1
		dc.b 0xF4, 6, 0,	0, 0xF8
AT_129_fly1:		dc.b 3
		dc.b 0xF2, 0xE, 0, 6, 0xF4
		dc.b 0xA, 4, 0, 0x12, 0xFC
		dc.b 2,	0, 0, 0x27, 0xC
AT_129_fly2:		dc.b 4
		dc.b 0xF8, 4, 0,	0x14, 0xF8
		dc.b 0,	0xC, 0, 0x16, 0xF0
		dc.b 8,	4, 0, 0x1A, 0
		dc.b 0,	0, 0, 0x28, 0xC
AT_129_fly3:		dc.b 4
		dc.b 0xF6, 9, 0,	0x1C, 0xF5
		dc.b 6,	8, 0, 0x22, 0xF4
		dc.b 0xE, 4, 0, 0x25, 0xF4
		dc.b 0xFE, 0, 0,	0x27, 0xC
		.align 2


