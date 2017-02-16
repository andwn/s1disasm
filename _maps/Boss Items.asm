# ---------------------------------------------------------------------------
# Sprite mappings - extra boss items (e.g. swinging ball on a chain in GHZ)
# ---------------------------------------------------------------------------
Map_BossItems:	dc.w AT_77_chainanchor1-Map_BossItems, AT_77_chainanchor2-Map_BossItems
		dc.w AT_77_cross-Map_BossItems, AT_77_widepipe-Map_BossItems
		dc.w AT_77_pipe-Map_BossItems, AT_77_spike-Map_BossItems
		dc.w AT_77_legmask-Map_BossItems, AT_77_legs-Map_BossItems
AT_77_chainanchor1:	dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8	/* GHZ boss */
AT_77_chainanchor2:	dc.b 2
		dc.b 0xFC, 4, 0,	4, 0xF8	/* GHZ boss */
		dc.b 0xF8, 5, 0,	0, 0xF8
		.align 2
AT_77_cross:		dc.b 1
		dc.b 0xFC, 0, 0,	6, 0xFC	/* unknown */
AT_77_widepipe:	dc.b 1
		dc.b 0x14, 9, 0,	7, 0xF4	/* SLZ boss */
AT_77_pipe:		dc.b 1
		dc.b 0x14, 5, 0,	0xD, 0xF8	/* MZ boss */
AT_77_spike:		dc.b 4
		dc.b 0xF0, 4, 0,	0x11, 0xF8 /* SYZ boss */
		dc.b 0xF8, 1, 0,	0x13, 0xF8
		dc.b 0xF8, 1, 8,	0x13, 0
		dc.b 8,	4, 0, 0x15, 0xF8
		.align 2
AT_77_legmask:	dc.b 2
		dc.b 0,	5, 0, 0x17, 0	/* FZ post-boss: sprite covering part of legs */
		dc.b 0,	0, 0, 0x1B, 0x10
		.align 2
AT_77_legs:		dc.b 2
		dc.b 0x18, 4, 0,	0x1C, 0	/* FZ post-boss */
		dc.b 0,	0xB, 0, 0x1E, 0x10
		.align 2
