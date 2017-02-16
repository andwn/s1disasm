# ---------------------------------------------------------------------------
# Sprite mappings - water splash (LZ)
# ---------------------------------------------------------------------------
Map_Splash:	dc.w AT_42_splash1-Map_Splash
		dc.w AT_42_splash2-Map_Splash
		dc.w AT_42_splash3-Map_Splash
AT_42_splash1:	dc.b 2
		dc.b 0xF2, 4, 0,	0x6D, 0xF8
		dc.b 0xFA, 0xC, 0, 0x6F, 0xF0
AT_42_splash2:	dc.b 2
		dc.b 0xE2, 0, 0,	0x73, 0xF8
		dc.b 0xEA, 0xE, 0, 0x74, 0xF0
AT_42_splash3:	dc.b 1
		dc.b 0xE2, 0xF, 0, 0x80, 0xF0
		.align 2
