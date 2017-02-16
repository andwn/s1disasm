# ---------------------------------------------------------------------------
# Sprite mappings - Eggman (boss levels)
# ---------------------------------------------------------------------------
Map_Eggman:	dc.w AT_14_ship-Map_Eggman, AT_14_facenormal1-Map_Eggman
		dc.w AT_14_facenormal2-Map_Eggman, AT_14_facelaugh1-Map_Eggman
		dc.w AT_14_facelaugh2-Map_Eggman, AT_14_facehit-Map_Eggman
		dc.w AT_14_facepanic-Map_Eggman, AT_14_facedefeat-Map_Eggman
		dc.w AT_14_flame1-Map_Eggman, AT_14_flame2-Map_Eggman
		dc.w AT_14_blank-Map_Eggman, AT_14_escapeflame1-Map_Eggman
		dc.w AT_14_escapeflame2-Map_Eggman
AT_14_ship:		dc.b 6
		dc.b 0xEC, 1, 0,	0xA, 0xE4
		dc.b 0xEC, 5, 0,	0xC, 0xC
		dc.b 0xFC, 0xE, 0x20, 0x10,	0xE4
		dc.b 0xFC, 0xE, 0x20, 0x1C,	4
		dc.b 0x14, 0xC, 0x20, 0x28,	0xEC
		dc.b 0x14, 0, 0x20, 0x2C, 0xC
AT_14_facenormal1:	dc.b 2
		dc.b 0xE4, 4, 0,	0, 0xF4
		dc.b 0xEC, 0xD, 0, 2, 0xEC
AT_14_facenormal2:	dc.b 2
		dc.b 0xE4, 4, 0,	0, 0xF4
		dc.b 0xEC, 0xD, 0, 0x35, 0xEC
AT_14_facelaugh1:	dc.b 3
		dc.b 0xE4, 8, 0,	0x3D, 0xF4
		dc.b 0xEC, 9, 0,	0x40, 0xEC
		dc.b 0xEC, 5, 0,	0x46, 4
AT_14_facelaugh2:	dc.b 3
		dc.b 0xE4, 8, 0,	0x4A, 0xF4
		dc.b 0xEC, 9, 0,	0x4D, 0xEC
		dc.b 0xEC, 5, 0,	0x53, 4
AT_14_facehit:	dc.b 3
		dc.b 0xE4, 8, 0,	0x57, 0xF4
		dc.b 0xEC, 9, 0,	0x5A, 0xEC
		dc.b 0xEC, 5, 0,	0x60, 4
AT_14_facepanic:	dc.b 3
		dc.b 0xE4, 4, 0,	0x64, 4
		dc.b 0xE4, 4, 0,	0, 0xF4
		dc.b 0xEC, 0xD, 0, 0x35, 0xEC
AT_14_facedefeat:	dc.b 4
		dc.b 0xE4, 9, 0,	0x66, 0xF4
		dc.b 0xE4, 8, 0,	0x57, 0xF4
		dc.b 0xEC, 9, 0,	0x5A, 0xEC
		dc.b 0xEC, 5, 0,	0x60, 4
AT_14_flame1:	dc.b 1
		dc.b 4,	5, 0, 0x2D, 0x22
AT_14_flame2:	dc.b 1
		dc.b 4,	5, 0, 0x31, 0x22
AT_14_blank:		dc.b 0
AT_14_escapeflame1:	dc.b 2
		dc.b 0,	8, 1, 0x2A, 0x22
		dc.b 8,	8, 0x11,	0x2A, 0x22
AT_14_escapeflame2:	dc.b 2
		dc.b 0xF8, 0xB, 1, 0x2D, 0x22
		dc.b 0,	1, 1, 0x39, 0x3A
		.align 2


