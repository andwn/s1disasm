# ---------------------------------------------------------------------------
# Sprite mappings - platforms on a conveyor belt (LZ)
# ---------------------------------------------------------------------------
Map_LConv:	dc.w AT_123_wheel1-Map_LConv, AT_123_wheel2-Map_LConv
		dc.w AT_123_wheel3-Map_LConv, AT_123_wheel4-Map_LConv
		dc.w AT_123_platform-Map_LConv
AT_123_wheel1:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0, 0xF0
AT_123_wheel2:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x10, 0xF0
AT_123_wheel3:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x20, 0xF0
AT_123_wheel4:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x30, 0xF0
AT_123_platform:	dc.b 1
		dc.b 0xF8, 0xD, 0, 0x40, 0xF0
		.align 2
