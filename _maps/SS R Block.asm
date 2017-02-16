# ---------------------------------------------------------------------------
# Sprite mappings - special stage "R" block
# ---------------------------------------------------------------------------
Map_SS_R:	dc.w byte_1B912-Map_SS_R, byte_1B918-Map_SS_R
		dc.w byte_1B91E-Map_SS_R
byte_1B912:	dc.b 1
		dc.b 0xF4, 0xA, 0, 0, 0xF4
byte_1B918:	dc.b 1
		dc.b 0xF4, 0xA, 0, 9, 0xF4
byte_1B91E:	dc.b 0
		.align 2
