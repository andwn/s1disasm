# ---------------------------------------------------------------------------
# Sprite mappings - blocks (LZ)
# ---------------------------------------------------------------------------
Map_LBlock:	dc.w AT_97_sinkblock-Map_LBlock, AT_97_riseplatform-Map_LBlock
		dc.w AT_97_cork-Map_LBlock, AT_97_block-Map_LBlock
AT_97_sinkblock:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0, 0xF0	/* block, sinks when stood on */
AT_97_riseplatform:	dc.b 2
		dc.b 0xF4, 0xE, 0, 0x69, 0xE0 /* platform, rises when stood on */
		dc.b 0xF4, 0xE, 0, 0x75, 0
AT_97_cork:		dc.b 1
		dc.b 0xF0, 0xF, 1, 0x1A, 0xF0 /* cork, floats on water */
AT_97_block:		dc.b 1
		dc.b 0xF0, 0xF, 0xFD, 0xFA,	0xF0 /* block */
		.align 2
