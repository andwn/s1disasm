# ---------------------------------------------------------------------------
# Sprite mappings - Eggman (SBZ2)
# ---------------------------------------------------------------------------
Map_SEgg:	dc.w AT_52_stand-Map_SEgg, AT_52_laugh1-Map_SEgg
		dc.w AT_52_laugh2-Map_SEgg, AT_52_jump1-Map_SEgg
		dc.w AT_52_jump2-Map_SEgg, AT_52_surprise-Map_SEgg
		dc.w AT_52_starjump-Map_SEgg, AT_52_running1-Map_SEgg
		dc.w AT_52_running2-Map_SEgg, AT_52_intube-Map_SEgg
		dc.w AT_52_cockpit-Map_SEgg
AT_52_stand:		dc.b 3
		dc.b 0xFC, 0, 0,	0x8F, 0xE8
		dc.b 0xE8, 0xE, 0, 0, 0xF0
		dc.b 0,	0xF, 0, 0x6F, 0xF0
AT_52_laugh1:	dc.b 4
		dc.b 0xE8, 0xD, 0, 0xE, 0xF0
		dc.b 0xE8, 0xE, 0, 0, 0xF0
		dc.b 0,	0xF, 0, 0x6F, 0xF0
		dc.b 0xFC, 0, 0,	0x8F, 0xE8
		dc.b 0
AT_52_laugh2:	dc.b 4
		dc.b 0xE9, 0xD, 0, 0xE, 0xF0
		dc.b 0xE9, 0xE, 0, 0, 0xF0
		dc.b 1,	0xF, 0, 0x7F, 0xF0
		dc.b 0xFD, 0, 0,	0x8F, 0xE8
		dc.b 0
AT_52_jump1:		dc.b 4
		dc.b 0xF4, 0xF, 8, 0x20, 0xF0
		dc.b 0xF5, 4, 8,	0x30, 0x10
		dc.b 8,	9, 8, 0x4E, 0xF0
		dc.b 0xEC, 0xE, 0, 0, 0xF0
		dc.b 0
AT_52_jump2:		dc.b 4
		dc.b 0xF0, 0xF, 8, 0x20, 0xF0
		dc.b 0xF1, 4, 8,	0x30, 0x10
		dc.b 8,	6, 8, 0x3E, 0xF8
		dc.b 0xE8, 0xE, 0, 0, 0xF0
		dc.b 0
AT_52_surprise:	dc.b 4
		dc.b 0xE8, 0xD, 0, 0x16, 0xEC
		dc.b 0xE8, 1, 0,	0x1E, 0xC
		dc.b 0xE8, 0xE, 0, 0, 0xF0
		dc.b 0,	0xF, 0, 0x6F, 0xF0
		dc.b 0
AT_52_starjump:	dc.b 7
		dc.b 0xE8, 0xD, 0, 0x16, 0xEC
		dc.b 0xE8, 1, 0,	0x1E, 0xC
		dc.b 4,	9, 8, 0x34, 0
		dc.b 4,	5, 8, 0x3A, 0xE8
		dc.b 0xF0, 0xF, 8, 0x20, 0xF0
		dc.b 0xF1, 4, 8,	0x54, 0x10
		dc.b 0xF1, 4, 0,	0x54, 0xE0
AT_52_running1:	dc.b 5
		dc.b 0xF0, 0xF, 8, 0x20, 0xF0
		dc.b 0xF1, 4, 8,	0x30, 0x10
		dc.b 4,	9, 8, 0x34, 0
		dc.b 4,	5, 8, 0x3A, 0xE8
		dc.b 0xE8, 0xE, 0, 0, 0xF0
AT_52_running2:	dc.b 6
		dc.b 0xEE, 0xF, 8, 0x20, 0xF0
		dc.b 0xEF, 4, 8,	0x30, 0x10
		dc.b 9,	5, 8, 0x44, 0
		dc.b 3,	1, 8, 0x48, 0xF8
		dc.b 0xB, 5, 8, 0x4A, 0xE8
		dc.b 0xE6, 0xE, 0, 0, 0xF0
		dc.b 0
AT_52_intube:	dc.b 8
		dc.b 0xE8, 0xD, 0, 0x16, 0xEC /* Eggman inside tube in Final Zone */
		dc.b 0xE8, 1, 0,	0x1E, 0xC
		dc.b 0xE8, 0xE, 0, 0, 0xF0
		dc.b 0,	0xF, 0, 0x6F, 0xF0
		dc.b 0xE0, 0xD, 0x3E, 0xF0,	0xF0
		dc.b 0xF0, 0xD, 0x3E, 0xF0,	0xF0
		dc.b 0,	0xD, 0x3E, 0xF0, 0xF0
		dc.b 0x10, 0xD, 0x3E, 0xF0,	0xF0
AT_52_cockpit:	dc.b 3
		dc.b 0xEC, 0xD, 0, 0x56, 0xE4 /* empty cockpit of Eggmobile in Final Zone */
		dc.b 0xF4, 8, 0,	0x5E, 4
		dc.b 0xEC, 0xD, 0, 0x61, 0xFC
		.align 2
