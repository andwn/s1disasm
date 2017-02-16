# ---------------------------------------------------------------------------
# Sprite mappings - doors (SBZ)
# ---------------------------------------------------------------------------
Map_ADoor:	dc.w AT_26_closed-Map_ADoor, AT_26_01-Map_ADoor
		dc.w AT_26_02-Map_ADoor, AT_26_03-Map_ADoor
		dc.w AT_26_04-Map_ADoor, AT_26_05-Map_ADoor
		dc.w AT_26_06-Map_ADoor, AT_26_07-Map_ADoor
		dc.w AT_26_open-Map_ADoor
AT_26_closed:	dc.b 2
		dc.b 0xE0, 7, 8,	0, 0xF8	/* door closed */
		dc.b 0,	7, 8, 0, 0xF8
AT_26_01:		dc.b 2
		dc.b 0xDC, 7, 8,	0, 0xF8
		dc.b 4,	7, 8, 0, 0xF8
AT_26_02:		dc.b 2
		dc.b 0xD8, 7, 8,	0, 0xF8
		dc.b 8,	7, 8, 0, 0xF8
AT_26_03:		dc.b 2
		dc.b 0xD4, 7, 8,	0, 0xF8
		dc.b 0xC, 7, 8, 0, 0xF8
AT_26_04:		dc.b 2
		dc.b 0xD0, 7, 8,	0, 0xF8
		dc.b 0x10, 7, 8,	0, 0xF8
AT_26_05:		dc.b 2
		dc.b 0xCC, 7, 8,	0, 0xF8
		dc.b 0x14, 7, 8,	0, 0xF8
AT_26_06:		dc.b 2
		dc.b 0xC8, 7, 8,	0, 0xF8
		dc.b 0x18, 7, 8,	0, 0xF8
AT_26_07:		dc.b 2
		dc.b 0xC4, 7, 8,	0, 0xF8
		dc.b 0x1C, 7, 8,	0, 0xF8
AT_26_open:		dc.b 2
		dc.b 0xC0, 7, 8,	0, 0xF8	/* door fully open */
		dc.b 0x20, 7, 8,	0, 0xF8
		.align 2
