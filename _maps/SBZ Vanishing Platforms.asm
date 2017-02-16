# ---------------------------------------------------------------------------
# Sprite mappings - vanishing platforms	(SBZ)
# ---------------------------------------------------------------------------
Map_VanP:	dc.w AT_34_whole-Map_VanP, AT_34_half-Map_VanP
		dc.w AT_34_quarter-Map_VanP, AT_34_gone-Map_VanP
AT_34_whole:		dc.b 1
		dc.b 0xF8, 0xF, 0, 0, 0xF0
AT_34_half:		dc.b 1
		dc.b 0xF8, 7, 0,	0x10, 0xF8
AT_34_quarter:	dc.b 1
		dc.b 0xF8, 3, 0,	0x18, 0xFC
AT_34_gone:		dc.b 0
		.align 2
