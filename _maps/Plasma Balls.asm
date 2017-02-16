# ---------------------------------------------------------------------------
# Sprite mappings - energy balls (FZ)
# ---------------------------------------------------------------------------
Map_Plasma:	dc.w AT_115_fuzzy1-Map_Plasma, AT_115_fuzzy2-Map_Plasma
		dc.w AT_115_white1-Map_Plasma, AT_115_white2-Map_Plasma
		dc.w AT_115_white3-Map_Plasma, AT_115_white4-Map_Plasma
		dc.w AT_115_fuzzy3-Map_Plasma, AT_115_fuzzy4-Map_Plasma
		dc.w AT_115_fuzzy5-Map_Plasma, AT_115_fuzzy6-Map_Plasma
		dc.w AT_115_blank-Map_Plasma
AT_115_fuzzy1:	dc.b 2
		dc.b 0xF0, 0xD, 0, 0x7A, 0xF0
		dc.b 0,	0xD, 0x18, 0x7A, 0xF0
AT_115_fuzzy2:	dc.b 2
		dc.b 0xF4, 6, 0,	0x82, 0xF4
		dc.b 0xF4, 2, 0x18, 0x82, 4
AT_115_white1:	dc.b 2
		dc.b 0xF8, 4, 0,	0x88, 0xF8
		dc.b 0,	4, 0x10,	0x88, 0xF8
AT_115_white2:	dc.b 2
		dc.b 0xF8, 4, 0,	0x8A, 0xF8
		dc.b 0,	4, 0x10,	0x8A, 0xF8
AT_115_white3:	dc.b 2
		dc.b 0xF8, 4, 0,	0x8C, 0xF8
		dc.b 0,	4, 0x10,	0x8C, 0xF8
AT_115_white4:	dc.b 2
		dc.b 0xF4, 6, 0,	0x8E, 0xF4
		dc.b 0xF4, 2, 0x18, 0x8E, 4
AT_115_fuzzy3:	dc.b 1
		dc.b 0xF8, 5, 0,	0x94, 0xF8
AT_115_fuzzy4:	dc.b 1
		dc.b 0xF8, 5, 0,	0x98, 0xF8
AT_115_fuzzy5:	dc.b 2
		dc.b 0xF0, 0xD, 8, 0x7A, 0xF0
		dc.b 0,	0xD, 0x10, 0x7A, 0xF0
AT_115_fuzzy6:	dc.b 2
		dc.b 0xF4, 6, 0x10, 0x82, 0xF4
		dc.b 0xF4, 2, 8,	0x82, 4
AT_115_blank:		dc.b 0
		.align 2
