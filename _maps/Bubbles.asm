# ---------------------------------------------------------------------------
# Sprite mappings - bubbles (LZ)
# ---------------------------------------------------------------------------
Map_Bub:	dc.w AT_20_bubble1-Map_Bub, AT_20_bubble2-Map_Bub
		dc.w AT_20_bubble3-Map_Bub, AT_20_bubble4-Map_Bub
		dc.w AT_20_bubble5-Map_Bub, AT_20_bubble6-Map_Bub
		dc.w AT_20_bubblefull-Map_Bub, AT_20_burst1-Map_Bub
		dc.w AT_20_burst2-Map_Bub, AT_20_zero_sm-Map_Bub
		dc.w AT_20_five_sm-Map_Bub, AT_20_three_sm-Map_Bub
		dc.w AT_20_one_sm-Map_Bub, AT_20_zero-Map_Bub
		dc.w AT_20_five-Map_Bub, AT_20_four-Map_Bub
		dc.w AT_20_three-Map_Bub, AT_20_two-Map_Bub
		dc.w AT_20_one-Map_Bub, AT_20_bubmaker1-Map_Bub
		dc.w AT_20_bubmaker2-Map_Bub, AT_20_bubmaker3-Map_Bub
		dc.w AT_20_blank-Map_Bub
AT_20_bubble1:	dc.b 1
		dc.b 0xFC, 0, 0,	0, 0xFC	/* bubbles, increasing in size */
AT_20_bubble2:	dc.b 1
		dc.b 0xFC, 0, 0,	1, 0xFC
AT_20_bubble3:	dc.b 1
		dc.b 0xFC, 0, 0,	2, 0xFC
AT_20_bubble4:	dc.b 1
		dc.b 0xF8, 5, 0,	3, 0xF8
AT_20_bubble5:	dc.b 1
		dc.b 0xF8, 5, 0,	7, 0xF8
AT_20_bubble6:	dc.b 1
		dc.b 0xF4, 0xA, 0, 0xB, 0xF4
AT_20_bubblefull:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x14, 0xF0
AT_20_burst1:	dc.b 4
		dc.b 0xF0, 5, 0,	0x24, 0xF0 /* large bubble bursting */
		dc.b 0xF0, 5, 8,	0x24, 0
		dc.b 0,	5, 0x10,	0x24, 0xF0
		dc.b 0,	5, 0x18,	0x24, 0
AT_20_burst2:	dc.b 4
		dc.b 0xF0, 5, 0,	0x28, 0xF0
		dc.b 0xF0, 5, 8,	0x28, 0
		dc.b 0,	5, 0x10,	0x28, 0xF0
		dc.b 0,	5, 0x18,	0x28, 0
AT_20_zero_sm:	dc.b 1
		dc.b 0xF4, 6, 0,	0x2C, 0xF8 /* small, partially-formed countdown numbers */
AT_20_five_sm:	dc.b 1
		dc.b 0xF4, 6, 0,	0x32, 0xF8
AT_20_three_sm:	dc.b 1
		dc.b 0xF4, 6, 0,	0x38, 0xF8
AT_20_one_sm:	dc.b 1
		dc.b 0xF4, 6, 0,	0x3E, 0xF8
AT_20_zero:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x44, 0xF8 /* fully-formed countdown numbers */
AT_20_five:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x4A, 0xF8
AT_20_four:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x50, 0xF8
AT_20_three:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x56, 0xF8
AT_20_two:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x5C, 0xF8
AT_20_one:		dc.b 1
		dc.b 0xF4, 6, 0x20, 0x62, 0xF8
AT_20_bubmaker1:	dc.b 1
		dc.b 0xF8, 5, 0,	0x68, 0xF8
AT_20_bubmaker2:	dc.b 1
		dc.b 0xF8, 5, 0,	0x6C, 0xF8
AT_20_bubmaker3:	dc.b 1
		dc.b 0xF8, 5, 0,	0x70, 0xF8
AT_20_blank:		dc.b 0
		.align 2


