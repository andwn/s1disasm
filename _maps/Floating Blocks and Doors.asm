# ---------------------------------------------------------------------------
# Sprite mappings - moving blocks (SYZ/SLZ/LZ)
# ---------------------------------------------------------------------------
Map_FBlock:	dc.w AT_100_syz1x1-Map_FBlock, AT_100_syz2x2-Map_FBlock
		dc.w AT_100_syz1x2-Map_FBlock, AT_100_syzrect2x2-Map_FBlock
		dc.w AT_100_syzrect1x3-Map_FBlock, AT_100_slz-Map_FBlock
		dc.w AT_100_lzvert-Map_FBlock, AT_100_lzhoriz-Map_FBlock
AT_100_syz1x1:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x61, 0xF0 /* SYZ - 1x1 square block */
AT_100_syz2x2:	dc.b 4
		dc.b 0xE0, 0xF, 0, 0x61, 0xE0 /* SYZ - 2x2 square blocks */
		dc.b 0xE0, 0xF, 0, 0x61, 0
		dc.b 0,	0xF, 0, 0x61, 0xE0
		dc.b 0,	0xF, 0, 0x61, 0
AT_100_syz1x2:	dc.b 2
		dc.b 0xE0, 0xF, 0, 0x61, 0xF0 /* SYZ - 1x2 square blocks */
		dc.b 0,	0xF, 0, 0x61, 0xF0
AT_100_syzrect2x2:	dc.b 4
		dc.b 0xE6, 0xF, 0, 0x81, 0xE0 /* SYZ - 2x2 rectangular blocks */
		dc.b 0xE6, 0xF, 0, 0x81, 0
		dc.b 0,	0xF, 0, 0x81, 0xE0
		dc.b 0,	0xF, 0, 0x81, 0
AT_100_syzrect1x3:	dc.b 3
		dc.b 0xD9, 0xF, 0, 0x81, 0xF0 /* SYZ - 1x3 rectangular blocks */
		dc.b 0xF3, 0xF, 0, 0x81, 0xF0
		dc.b 0xD, 0xF, 0,	0x81, 0xF0
AT_100_slz:		dc.b 1
		dc.b 0xF0, 0xF, 0, 0x21, 0xF0 /* SLZ - 1x1 square block */
AT_100_lzvert:	dc.b 2
		dc.b 0xE0, 7, 0,	0, 0xF8	/* LZ - small vertical door */
		dc.b 0,	7, 0x10,	0, 0xF8
AT_100_lzhoriz:	dc.b 4
		dc.b 0xF0, 0xF, 0, 0x22, 0xC0 /* LZ - large horizontal door */
		dc.b 0xF0, 0xF, 0, 0x22, 0xE0
		dc.b 0xF0, 0xF, 0, 0x22, 0
		dc.b 0xF0, 0xF, 0, 0x22, 0x20
		.align 2
