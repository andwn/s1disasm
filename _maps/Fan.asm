# ---------------------------------------------------------------------------
# Sprite mappings - fans (SLZ)
# ---------------------------------------------------------------------------
Map_Fan:	dc.w AT_105_fan1-Map_Fan, AT_105_fan2-Map_Fan
		dc.w AT_105_fan3-Map_Fan, AT_105_fan2-Map_Fan
		dc.w AT_105_fan1-Map_Fan
AT_105_fan1:		dc.b 2
		dc.b 0xF0, 9, 0,	0, 0xF8
		dc.b 0,	0xD, 0, 6, 0xF0
AT_105_fan2:		dc.b 2
		dc.b 0xF0, 0xD, 0, 0xE, 0xF0
		dc.b 0,	0xD, 0, 0x16, 0xF0
AT_105_fan3:		dc.b 2
		dc.b 0xF0, 0xD, 0, 0x1E, 0xF0
		dc.b 0,	9, 0, 0x26, 0xF8
		.align 2


