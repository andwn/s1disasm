# ---------------------------------------------------------------------------
# Sprite mappings - chaos emeralds on the ending sequence
# ---------------------------------------------------------------------------
Map_ECha:	dc.w M_ECha_1-Map_ECha, M_ECha_2-Map_ECha
		dc.w M_ECha_3-Map_ECha, M_ECha_4-Map_ECha
		dc.w M_ECha_5-Map_ECha, M_ECha_6-Map_ECha
		dc.w M_ECha_7-Map_ECha
M_ECha_1:	dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8
M_ECha_2:	dc.b 1
		dc.b 0xF8, 5, 0,	4, 0xF8
M_ECha_3:	dc.b 1
		dc.b 0xF8, 5, 0x40, 0x10, 0xF8
M_ECha_4:	dc.b 1
		dc.b 0xF8, 5, 0x20, 0x18, 0xF8
M_ECha_5:	dc.b 1
		dc.b 0xF8, 5, 0x40, 0x14, 0xF8
M_ECha_6:	dc.b 1
		dc.b 0xF8, 5, 0,	8, 0xF8
M_ECha_7:	dc.b 1
		dc.b 0xF8, 5, 0,	0xC, 0xF8
		.align 2
