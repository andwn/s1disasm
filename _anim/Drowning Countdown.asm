# ---------------------------------------------------------------------------
# Animation script - countdown numbers and bubbles (LZ)
# ---------------------------------------------------------------------------
Ani_Drown:	dc.w AT_46_zeroappear-Ani_Drown
		dc.w AT_46_oneappear-Ani_Drown
		dc.w AT_46_twoappear-Ani_Drown
		dc.w AT_46_threeappear-Ani_Drown
		dc.w AT_46_fourappear-Ani_Drown
		dc.w AT_46_fiveappear-Ani_Drown
		dc.w AT_46_smallbubble-Ani_Drown
		dc.w AT_46_zeroflash-Ani_Drown
		dc.w AT_46_oneflash-Ani_Drown
		dc.w AT_46_twoflash-Ani_Drown
		dc.w AT_46_threeflash-Ani_Drown
		dc.w AT_46_fourflash-Ani_Drown
		dc.w AT_46_fiveflash-Ani_Drown
		dc.w AT_46_blank-Ani_Drown
		dc.w AT_46_mediumbubble-Ani_Drown
AT_46_zeroappear:	dc.b 5,	0, 1, 2, 3, 4, 9, 0xD, afRoutine
		.align 2
AT_46_oneappear:	dc.b 5,	0, 1, 2, 3, 4, 0xC, 0x12,	afRoutine
		.align 2
AT_46_twoappear:	dc.b 5,	0, 1, 2, 3, 4, 0xC, 0x11,	afRoutine
		.align 2
AT_46_threeappear:	dc.b 5,	0, 1, 2, 3, 4, 0xB, 0x10,	afRoutine
		.align 2
AT_46_fourappear:	dc.b 5,	0, 1, 2, 3, 4, 9, 0xF, afRoutine
		.align 2
AT_46_fiveappear:	dc.b 5,	0, 1, 2, 3, 4, 0xA, 0xE, afRoutine
		.align 2
AT_46_smallbubble:	dc.b 0xE, 0, 1, 2, afRoutine
		.align 2
AT_46_zeroflash:	dc.b 7,	0x16, 0xD, 0x16, 0xD, 0x16, 0xD, afRoutine
AT_46_oneflash:	dc.b 7,	0x16, 0x12, 0x16, 0x12, 0x16, 0x12, afRoutine
AT_46_twoflash:	dc.b 7,	0x16, 0x11, 0x16, 0x11, 0x16, 0x11, afRoutine
AT_46_threeflash:	dc.b 7,	0x16, 0x10, 0x16, 0x10, 0x16, 0x10, afRoutine
AT_46_fourflash:	dc.b 7,	0x16, 0xF, 0x16, 0xF, 0x16, 0xF, afRoutine
AT_46_fiveflash:	dc.b 7,	0x16, 0xE, 0x16, 0xE, 0x16, 0xE, afRoutine
AT_46_blank:		dc.b 0xE, afRoutine
AT_46_mediumbubble:	dc.b 0xE, 1, 2, 3, 4, afRoutine
		.align 2
