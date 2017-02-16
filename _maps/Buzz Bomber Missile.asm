# ---------------------------------------------------------------------------
# Sprite mappings - missile that Buzz Bomber throws
# ---------------------------------------------------------------------------
Map_Missile:	dc.w AT_37_Flare1-Map_Missile, AT_37_Flare2-Map_Missile
		dc.w AT_37_Ball1-Map_Missile, AT_37_Ball2-Map_Missile
AT_37_Flare1:	dc.b 1
		dc.b 0xF8, 5, 0,	0x24, 0xF8 /* buzz bomber firing flare */
AT_37_Flare2:	dc.b 1
		dc.b 0xF8, 5, 0,	0x28, 0xF8
AT_37_Ball1:		dc.b 1
		dc.b 0xF8, 5, 0,	0x2C, 0xF8 /* missile itself */
AT_37_Ball2:		dc.b 1
		dc.b 0xF8, 5, 0,	0x33, 0xF8
		.align 2
