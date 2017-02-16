# ---------------------------------------------------------------------------
# Sprite mappings - collapsing floors (MZ, SLZ,	SBZ)
# ---------------------------------------------------------------------------
Map_CFlo:	dc.w byte_874E-Map_CFlo, byte_8763-Map_CFlo
		dc.w byte_878C-Map_CFlo, byte_87A1-Map_CFlo
byte_874E:	dc.b 4
		dc.b 0xF8, 0xD, 0, 0, 0xE0	/* MZ and SBZ blocks */
		dc.b 8,	0xD, 0, 0, 0xE0
		dc.b 0xF8, 0xD, 0, 0, 0
		dc.b 8,	0xD, 0, 0, 0
byte_8763:	dc.b 8
		dc.b 0xF8, 5, 0,	0, 0xE0
		dc.b 0xF8, 5, 0,	0, 0xF0
		dc.b 0xF8, 5, 0,	0, 0
		dc.b 0xF8, 5, 0,	0, 0x10
		dc.b 8,	5, 0, 0, 0xE0
		dc.b 8,	5, 0, 0, 0xF0
		dc.b 8,	5, 0, 0, 0
		dc.b 8,	5, 0, 0, 0x10
byte_878C:	dc.b 4
		dc.b 0xF8, 0xD, 0, 0, 0xE0	/* SLZ blocks */
		dc.b 8,	0xD, 0, 8, 0xE0
		dc.b 0xF8, 0xD, 0, 0, 0
		dc.b 8,	0xD, 0, 8, 0
byte_87A1:	dc.b 8
		dc.b 0xF8, 5, 0,	0, 0xE0
		dc.b 0xF8, 5, 0,	4, 0xF0
		dc.b 0xF8, 5, 0,	0, 0
		dc.b 0xF8, 5, 0,	4, 0x10
		dc.b 8,	5, 0, 8, 0xE0
		dc.b 8,	5, 0, 0xC, 0xF0
		dc.b 8,	5, 0, 8, 0
		dc.b 8,	5, 0, 0xC, 0x10
		.align 2
