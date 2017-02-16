# ---------------------------------------------------------------------------
# Sprite mappings - moving blocks (MZ, SBZ)
# ---------------------------------------------------------------------------
Map_MBlock:	dc.w AT_82_mz1-Map_MBlock, AT_82_mz2-Map_MBlock
		dc.w AT_82_sbz-Map_MBlock, AT_82_sbzwide-Map_MBlock
		dc.w AT_82_mz3-Map_MBlock
AT_82_mz1:		dc.b 1
		dc.b 0xF8, 0xF, 0, 8, 0xF0
AT_82_mz2:		dc.b 2
		dc.b 0xF8, 0xF, 0, 8, 0xE0
		dc.b 0xF8, 0xF, 0, 8, 0
AT_82_sbz:		dc.b 4
		dc.b 0xF8, 0xC, 0x20, 0, 0xE0
		dc.b 0,	0xD, 0, 4, 0xE0
		dc.b 0xF8, 0xC, 0x20, 0, 0
		dc.b 0,	0xD, 0, 4, 0
AT_82_sbzwide:	dc.b 4
		dc.b 0xF8, 0xE, 0, 0, 0xC0
		dc.b 0xF8, 0xE, 0, 3, 0xE0
		dc.b 0xF8, 0xE, 0, 3, 0
		dc.b 0xF8, 0xE, 8, 0, 0x20
AT_82_mz3:		dc.b 3
		dc.b 0xF8, 0xF, 0, 8, 0xD0
		dc.b 0xF8, 0xF, 0, 8, 0xF0
		dc.b 0xF8, 0xF, 0, 8, 0x10
		.align 2
