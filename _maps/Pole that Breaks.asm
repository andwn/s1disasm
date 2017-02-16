# ---------------------------------------------------------------------------
# Sprite mappings - pole that breaks (LZ)
# ---------------------------------------------------------------------------
Map_Pole:	dc.w AT_12_normal-Map_Pole
		dc.w AT_12_broken-Map_Pole
AT_12_normal:	dc.b 2			/* normal pole */
		dc.b 0xE0, 3, 0,	0, 0xFC
		dc.b 0,	3, 0x10,	0, 0xFC
AT_12_broken:	dc.b 4			/* broken pole */
		dc.b 0xE0, 1, 0,	0, 0xFC
		dc.b 0xF0, 5, 0,	4, 0xFC
		dc.b 0,	5, 0x10,	4, 0xFC
		dc.b 0x10, 1, 0x10, 0, 0xFC
		.align 2
