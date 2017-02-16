# ---------------------------------------------------------------------------
# Sprite mappings - Jaws enemy (LZ)
# ---------------------------------------------------------------------------
Map_Jaws:	dc.w AT_89_open1-Map_Jaws
		dc.w AT_89_shut1-Map_Jaws
		dc.w AT_89_open2-Map_Jaws
		dc.w AT_89_shut2-Map_Jaws
AT_89_open1:		dc.b 2
		dc.b 0xF4, 0xE, 0, 0, 0xF0	/* mouth open */
		dc.b 0xF5, 5, 0,	0x18, 0x10
AT_89_shut1:		dc.b 2
		dc.b 0xF4, 0xE, 0, 0xC, 0xF0 /* mouth shut */
		dc.b 0xF5, 5, 0,	0x1C, 0x10
AT_89_open2:		dc.b 2
		dc.b 0xF4, 0xE, 0, 0, 0xF0
		dc.b 0xF5, 5, 0x10, 0x18, 0x10
AT_89_shut2:		dc.b 2
		dc.b 0xF4, 0xE, 0, 0xC, 0xF0
		dc.b 0xF5, 5, 0x10, 0x1C, 0x10
		.align 2


