# ---------------------------------------------------------------------------
# Sprite mappings - pushable blocks (MZ, LZ)
# ---------------------------------------------------------------------------
Map_Push:	dc.w AT_46_single-Map_Push
		dc.w AT_46_four-Map_Push
AT_46_single:	dc.b 1
		dc.b 0xF0, 0xF, 0, 8, 0xF0	/* single block */
AT_46_four:		dc.b 4
		dc.b 0xF0, 0xF, 0, 8, 0xC0	/* row of 4 blocks */
		dc.b 0xF0, 0xF, 0, 8, 0xE0
		dc.b 0xF0, 0xF, 0, 8, 0
		dc.b 0xF0, 0xF, 0, 8, 0x20
		.align 2
