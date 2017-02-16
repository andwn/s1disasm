# ---------------------------------------------------------------------------
# Animation script - flamethrower (SBZ)
# ---------------------------------------------------------------------------
Ani_Flame:	dc.w AT_44_pipe1-Ani_Flame
		dc.w AT_44_pipe2-Ani_Flame
		dc.w AT_44_valve1-Ani_Flame
		dc.w AT_44_valve2-Ani_Flame
AT_44_pipe1:		dc.b 3,	0, 1, 2, 3, 4, 5, 6, 7,	8, 9, 0xA, afBack, 2
AT_44_pipe2:		dc.b 0,	9, 7, 5, 3, 1, 0, afBack, 1
		.align 2
AT_44_valve1:	dc.b 3,	0xB, 0xC,	0xD, 0xE,	0xF, 0x10, 0x11, 0x12, 0x13,	0x14, 0x15, afBack, 2
AT_44_valve2:	dc.b 0,	0x14, 0x12, 0x11, 0xF, 0xD, 0xB, afBack, 1
		.align 2
