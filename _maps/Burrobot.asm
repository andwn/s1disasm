# ---------------------------------------------------------------------------
# Sprite mappings - Burrobot enemy (LZ)
# ---------------------------------------------------------------------------
Map_Burro:	dc.w AT_4_walk1-Map_Burro
		dc.w AT_4_walk2-Map_Burro
		dc.w AT_4_digging1-Map_Burro
		dc.w AT_4_digging2-Map_Burro
		dc.w AT_4_fall-Map_Burro
		dc.w AT_4_facedown-Map_Burro
		dc.w AT_4_walk3-Map_Burro
AT_4_walk1:		dc.b 2
		dc.b 0xEC, 0xA, 0, 0, 0xF0	/* walking */
		dc.b 4,	9, 0, 9, 0xF4
AT_4_walk2:		dc.b 2
		dc.b 0xEC, 0xA, 0, 0xF, 0xF0
		dc.b 4,	9, 0, 0x18, 0xF4
AT_4_digging1:	dc.b 2
		dc.b 0xE8, 0xA, 0, 0x1E, 0xF4 /* digging */
		dc.b 0,	0xA, 0, 0x27, 0xF4
AT_4_digging2:	dc.b 2
		dc.b 0xE8, 0xA, 0, 0x30, 0xF4
		dc.b 0,	0xA, 0, 0x39, 0xF4
AT_4_fall:		dc.b 2
		dc.b 0xE8, 0xA, 0, 0xF, 0xF0 /* falling after jumping up */
		dc.b 0,	0xA, 0, 0x42, 0xF4
AT_4_facedown:	dc.b 2
		dc.b 0xF4, 6, 0,	0x4B, 0xE8 /* facing down (unused) */
		dc.b 0xF4, 0xA, 0, 0x51, 0xF8
AT_4_walk3:		dc.b 2
		dc.b 0xEC, 0xA, 0, 0xF, 0xF0
		dc.b 4,	9, 0, 9, 0xF4
		.align 2


