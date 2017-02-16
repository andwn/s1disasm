# ---------------------------------------------------------------------------
# Sprite mappings - SLZ	swinging platforms
# ---------------------------------------------------------------------------
Map_Swing_SLZ:	dc.w AT_16_block-Map_Swing_SLZ
		dc.w AT_16_chain-Map_Swing_SLZ
		dc.w AT_16_anchor-Map_Swing_SLZ
AT_16_block:		dc.b 8
		dc.b 0xF0, 0xF, 0, 4, 0xE0
		dc.b 0xF0, 0xF, 8, 4, 0
		dc.b 0xF0, 5, 0,	0x14, 0xD0
		dc.b 0xF0, 5, 8,	0x14, 0x20
		dc.b 0x10, 4, 0,	0x18, 0xE0
		dc.b 0x10, 4, 8,	0x18, 0x10
		dc.b 0x10, 1, 0,	0x1A, 0xF8
		dc.b 0x10, 1, 8,	0x1A, 0
AT_16_chain:		dc.b 1
		dc.b 0xF8, 5, 0x40, 0, 0xF8
AT_16_anchor:	dc.b 1
		dc.b 0xF8, 5, 0,	0x1C, 0xF8
		.align 2
