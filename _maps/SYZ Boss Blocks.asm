# ---------------------------------------------------------------------------
# Sprite mappings - blocks that	Robotnik picks up (SYZ)
# ---------------------------------------------------------------------------
Map_BossBlock:	dc.w AT_78_wholeblock-Map_BossBlock, AT_78_topleft-Map_BossBlock
		dc.w AT_78_topright-Map_BossBlock, AT_78_bottomleft-Map_BossBlock
		dc.w AT_78_bottomright-Map_BossBlock
AT_78_wholeblock:	dc.b 2
		dc.b 0xF0, 0xD, 0, 0x71, 0xF0
		dc.b 0,	0xD, 0, 0x79, 0xF0
		dc.b 0
AT_78_topleft:	dc.b 1
		dc.b 0xF8, 5, 0,	0x71, 0xF8
AT_78_topright:	dc.b 1
		dc.b 0xF8, 5, 0,	0x75, 0xF8
AT_78_bottomleft:	dc.b 1
		dc.b 0xF8, 5, 0,	0x79, 0xF8
AT_78_bottomright:	dc.b 1
		dc.b 0xF8, 5, 0,	0x7D, 0xF8
		.align 2
