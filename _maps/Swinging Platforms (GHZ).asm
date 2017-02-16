# ---------------------------------------------------------------------------
# Sprite mappings - GHZ	and MZ swinging	platforms
# ---------------------------------------------------------------------------
Map_Swing_GHZ:	dc.w AT_128_block-Map_Swing_GHZ
		dc.w AT_128_chain-Map_Swing_GHZ
		dc.w AT_128_anchor-Map_Swing_GHZ
AT_128_block:		dc.b 2
		dc.b 0xF8, 9, 0,	4, 0xE8
		dc.b 0xF8, 9, 0,	4, 0
AT_128_chain:		dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8
AT_128_anchor:	dc.b 1
		dc.b 0xF8, 5, 0,	0xA, 0xF8
		.align 2
