# ---------------------------------------------------------------------------
# Sprite mappings - invisible solid blocks
# ---------------------------------------------------------------------------
Map_Invis:	dc.w AT_21_solid-Map_Invis
		dc.w AT_21_unused1-Map_Invis
		dc.w AT_21_unused2-Map_Invis
AT_21_solid:		dc.b 4
		dc.b 0xF0, 5, 0,	0x18, 0xF0
		dc.b 0xF0, 5, 0,	0x18, 0
		dc.b 0,	5, 0, 0x18, 0xF0
		dc.b 0,	5, 0, 0x18, 0
AT_21_unused1:	dc.b 4
		dc.b 0xE0, 5, 0,	0x18, 0xC0
		dc.b 0xE0, 5, 0,	0x18, 0x30
		dc.b 0x10, 5, 0,	0x18, 0xC0
		dc.b 0x10, 5, 0,	0x18, 0x30
AT_21_unused2:	dc.b 4
		dc.b 0xE0, 5, 0,	0x18, 0x80
		dc.b 0xE0, 5, 0,	0x18, 0x70
		dc.b 0x10, 5, 0,	0x18, 0x80
		dc.b 0x10, 5, 0,	0x18, 0x70
		.align 2
