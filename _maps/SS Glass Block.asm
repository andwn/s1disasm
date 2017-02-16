# ---------------------------------------------------------------------------
# Sprite mappings - special stage breakable glass blocks and red-white blocks
# ---------------------------------------------------------------------------
Map_SS_Glass:	dc.w byte_1B928-Map_SS_Glass, byte_1B92E-Map_SS_Glass
		dc.w byte_1B934-Map_SS_Glass, byte_1B93A-Map_SS_Glass
byte_1B928:	dc.b 1
		dc.b 0xF4, 0xA, 0, 0, 0xF4
byte_1B92E:	dc.b 1
		dc.b 0xF4, 0xA, 8, 0, 0xF4
byte_1B934:	dc.b 1
		dc.b 0xF4, 0xA, 0x18, 0, 0xF4
byte_1B93A:	dc.b 1
		dc.b 0xF4, 0xA, 0x10, 0, 0xF4
		.align 2
