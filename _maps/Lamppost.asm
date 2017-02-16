# ---------------------------------------------------------------------------
# Sprite mappings - lamppost
# ---------------------------------------------------------------------------
Map_Lamp:	dc.w AT_90_blue-Map_Lamp, AT_90_poleonly-Map_Lamp
		dc.w AT_90_redballonly-Map_Lamp, AT_90_red-Map_Lamp
AT_90_blue:		dc.b 6
		dc.b 0xE4, 1, 0,	0, 0xF8
		dc.b 0xE4, 1, 8,	0, 0
		dc.b 0xF4, 3, 0x20, 2, 0xF8
		dc.b 0xF4, 3, 0x28, 2, 0
		dc.b 0xD4, 1, 0,	6, 0xF8
		dc.b 0xD4, 1, 8,	6, 0
AT_90_poleonly:	dc.b 4
		dc.b 0xE4, 1, 0,	0, 0xF8
		dc.b 0xE4, 1, 8,	0, 0
		dc.b 0xF4, 3, 0x20, 2, 0xF8
		dc.b 0xF4, 3, 0x28, 2, 0
AT_90_redballonly:	dc.b 2
		dc.b 0xF8, 1, 0,	8, 0xF8
		dc.b 0xF8, 1, 8,	8, 0
AT_90_red:		dc.b 6
		dc.b 0xE4, 1, 0,	0, 0xF8
		dc.b 0xE4, 1, 8,	0, 0
		dc.b 0xF4, 3, 0x20, 2, 0xF8
		dc.b 0xF4, 3, 0x28, 2, 0
		dc.b 0xD4, 1, 0,	8, 0xF8
		dc.b 0xD4, 1, 8,	8, 0
		.align 2


