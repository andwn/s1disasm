# ---------------------------------------------------------------------------
# Sprite mappings - Moto Bug enemy (GHZ)
# ---------------------------------------------------------------------------
Map_Moto:	dc.w AT_120_moto1-Map_Moto, AT_120_moto2-Map_Moto
		dc.w AT_120_moto3-Map_Moto, AT_120_smoke1-Map_Moto
		dc.w AT_120_smoke2-Map_Moto, AT_120_smoke3-Map_Moto
		dc.w AT_120_blank-Map_Moto
AT_120_moto1:		dc.b 4
		dc.b 0xF0, 0xD, 0, 0, 0xEC
		dc.b 0,	0xC, 0, 8, 0xEC
		dc.b 0xF8, 1, 0,	0xC, 0xC
		dc.b 8,	8, 0, 0xE, 0xF4
AT_120_moto2:		dc.b 4
		dc.b 0xF1, 0xD, 0, 0, 0xEC
		dc.b 1,	0xC, 0, 8, 0xEC
		dc.b 0xF9, 1, 0,	0xC, 0xC
		dc.b 9,	8, 0, 0x11, 0xF4
AT_120_moto3:		dc.b 5
		dc.b 0xF0, 0xD, 0, 0, 0xEC
		dc.b 0,	0xC, 0, 0x14, 0xEC
		dc.b 0xF8, 1, 0,	0xC, 0xC
		dc.b 8,	4, 0, 0x18, 0xEC
		dc.b 8,	4, 0, 0x12, 0xFC
AT_120_smoke1:	dc.b 1
		dc.b 0xFA, 0, 0,	0x1A, 0x10
AT_120_smoke2:	dc.b 1
		dc.b 0xFA, 0, 0,	0x1B, 0x10
AT_120_smoke3:	dc.b 1
		dc.b 0xFA, 0, 0,	0x1C, 0x10
AT_120_blank:		dc.b 0
		.align 2
