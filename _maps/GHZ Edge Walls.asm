# ---------------------------------------------------------------------------
# Sprite mappings - walls (GHZ)
# ---------------------------------------------------------------------------
Map_Edge:	dc.w M_Edge_Shadow-Map_Edge
		dc.w M_Edge_Light-Map_Edge
		dc.w M_Edge_Dark-Map_Edge
M_Edge_Shadow:	dc.b 4
		dc.b 0xE0, 5, 0,	4, 0xF8	/* light with shadow */
		dc.b 0xF0, 5, 0,	8, 0xF8
		dc.b 0,	5, 0, 8, 0xF8
		dc.b 0x10, 5, 0,	8, 0xF8
M_Edge_Light:	dc.b 4
		dc.b 0xE0, 5, 0,	8, 0xF8	/* light with no shadow */
		dc.b 0xF0, 5, 0,	8, 0xF8
		dc.b 0,	5, 0, 8, 0xF8
		dc.b 0x10, 5, 0,	8, 0xF8
M_Edge_Dark:	dc.b 4
		dc.b 0xE0, 5, 0,	0, 0xF8	/* all shadow */
		dc.b 0xF0, 5, 0,	0, 0xF8
		dc.b 0,	5, 0, 0, 0xF8
		dc.b 0x10, 5, 0,	0, 0xF8
		.align 2
