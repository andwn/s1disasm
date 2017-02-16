# ---------------------------------------------------------------------------
# Sprite mappings - hidden points at the end of	a level
# ---------------------------------------------------------------------------
Map_Bonus:	dc.w AT_6_blank-Map_Bonus, AT_6_10000-Map_Bonus
		dc.w AT_6_1000-Map_Bonus, AT_6_100-Map_Bonus
AT_6_blank:		dc.b 0
AT_6_10000:		dc.b 1
		dc.b 0xF4, 0xE, 0, 0, 0xF0
AT_6_1000:		dc.b 1
		dc.b 0xF4, 0xE, 0, 0xC, 0xF0
AT_6_100:		dc.b 1
		dc.b 0xF4, 0xE, 0, 0x18, 0xF0
		.align 2
