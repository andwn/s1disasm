# ---------------------------------------------------------------------------
# Sprite mappings - switches (MZ, SYZ, LZ, SBZ)
# ---------------------------------------------------------------------------
Map_But:	dc.w byte_BEAC-Map_But
		dc.w byte_BEB7-Map_But
		dc.w byte_BEC2-Map_But
		dc.w byte_BEB7-Map_But
byte_BEAC:	dc.b 2
		dc.b 0xF5, 5, 0,	0, 0xF0
		dc.b 0xF5, 5, 8,	0, 0
byte_BEB7:	dc.b 2
		dc.b 0xF5, 5, 0,	4, 0xF0
		dc.b 0xF5, 5, 8,	4, 0
byte_BEC2:	dc.b 2
		dc.b 0xF5, 5, 0xFF, 0xFC, 0xF0
		dc.b 0xF5, 5, 7,	0xFC, 0
		dc.b 0xF8, 5, 0,	0, 0xF8
		.align 2


