# ---------------------------------------------------------------------------
# Sprite mappings - gargoyle head (LZ)
# ---------------------------------------------------------------------------
Map_Gar:	dc.w AT_25_head-Map_Gar
		dc.w AT_25_head-Map_Gar
		dc.w AT_25_fireball1-Map_Gar
		dc.w AT_25_fireball2-Map_Gar
AT_25_head:		dc.b 3
		dc.b 0xF0, 4, 0,	0, 0
		dc.b 0xF8, 0xD, 0, 2, 0xF0
		dc.b 8,	8, 0, 0xA, 0xF8
AT_25_fireball1:	dc.b 1
		dc.b 0xFC, 4, 0,	0xD, 0xF8
AT_25_fireball2:	dc.b 1
		dc.b 0xFC, 4, 0,	0xF, 0xF8
		.align 2


