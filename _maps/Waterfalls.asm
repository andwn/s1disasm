# ---------------------------------------------------------------------------
# Sprite mappings - waterfalls (LZ)
# ---------------------------------------------------------------------------
Map_WFall:	dc.w AT_66_vertnarrow-Map_WFall, AT_66_cornerwide-Map_WFall
		dc.w AT_66_cornermedium-Map_WFall, AT_66_cornernarrow-Map_WFall
		dc.w AT_66_cornermedium2-Map_WFall, AT_66_cornernarrow2-Map_WFall
		dc.w AT_66_cornernarrow3-Map_WFall, AT_66_vertwide-Map_WFall
		dc.w AT_66_diagonal-Map_WFall, AT_66_splash1-Map_WFall
		dc.w AT_66_splash2-Map_WFall, AT_66_splash3-Map_WFall
AT_66_vertnarrow:	dc.b 1
		dc.b 0xF0, 7, 0,	0, 0xF8
AT_66_cornerwide:	dc.b 2
		dc.b 0xF8, 4, 0,	8, 0xFC
		dc.b 0,	8, 0, 0xA, 0xF4
AT_66_cornermedium:	dc.b 2
		dc.b 0xF8, 0, 0,	8, 0
		dc.b 0,	4, 0, 0xD, 0xF8
AT_66_cornernarrow:	dc.b 1
		dc.b 0xF8, 1, 0,	0xF, 0
AT_66_cornermedium2:	dc.b 2
		dc.b 0xF8, 0, 0,	8, 0
		dc.b 0,	4, 0, 0xD, 0xF8
AT_66_cornernarrow2:	dc.b 1
		dc.b 0xF8, 1, 0,	0x11, 0
AT_66_cornernarrow3:	dc.b 1
		dc.b 0xF8, 1, 0,	0x13, 0
AT_66_vertwide:	dc.b 1
		dc.b 0xF0, 7, 0,	0x15, 0xF8
AT_66_diagonal:	dc.b 2
		dc.b 0xF8, 0xC, 0, 0x1D, 0xF6
		dc.b 0,	0xC, 0, 0x21, 0xE8
AT_66_splash1:	dc.b 2
		dc.b 0xF0, 0xB, 0, 0x25, 0xE8
		dc.b 0xF0, 0xB, 0, 0x31, 0
AT_66_splash2:	dc.b 2
		dc.b 0xF0, 0xB, 0, 0x3D, 0xE8
		dc.b 0xF0, 0xB, 0, 0x49, 0
AT_66_splash3:	dc.b 2
		dc.b 0xF0, 0xB, 0, 0x55, 0xE8
		dc.b 0xF0, 0xB, 0, 0x61, 0
		.align 2


