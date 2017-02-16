# ---------------------------------------------------------------------------
# Sprite mappings - Chopper enemy (GHZ)
# ---------------------------------------------------------------------------
Map_Chop:	dc.w AT_101_mouthshut-Map_Chop
		dc.w AT_101_mouthopen-Map_Chop
AT_101_mouthshut:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0, 0xF0
AT_101_mouthopen:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x10, 0xF0
		.align 2


