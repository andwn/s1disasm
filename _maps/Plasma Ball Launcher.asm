# ---------------------------------------------------------------------------
# Sprite mappings - energy ball	launcher (FZ)
# ---------------------------------------------------------------------------
Map_PLaunch:	dc.w AT_110_red-Map_PLaunch
		dc.w AT_110_white-Map_PLaunch
		dc.w AT_110_sparking1-Map_PLaunch
		dc.w AT_110_sparking2-Map_PLaunch
AT_110_red:		dc.b 1
		dc.b 0xF8, 5, 0,	0x6E, 0xF8
AT_110_white:		dc.b 1
		dc.b 0xF8, 5, 0,	0x76, 0xF8
AT_110_sparking1:	dc.b 1
		dc.b 0xF8, 5, 0,	0x72, 0xF8
AT_110_sparking2:	dc.b 1
		dc.b 0xF8, 5, 0x10, 0x72, 0xF8
		.align 2
