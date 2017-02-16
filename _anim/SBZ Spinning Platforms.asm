# ---------------------------------------------------------------------------
# Animation script - trapdoor (SBZ)
# ---------------------------------------------------------------------------
Ani_Spin:	dc.w AT_25_trapopen-Ani_Spin
		dc.w AT_25_trapclose-Ani_Spin
		dc.w AT_25_spin1-Ani_Spin
		dc.w AT_25_spin2-Ani_Spin
AT_25_trapopen:	dc.b 3,	0, 1, 2, afBack, 1
AT_25_trapclose:	dc.b 3,	2, 1, 0, afBack, 1
AT_25_spin1:		dc.b 1,	0, 1, 2, 3, 4, 0x43, 0x42, 0x41, 0x40, 0x61,	0x62, 0x63, 0x64, 0x23, 0x22, 0x21, 0, afBack, 1
AT_25_spin2:		dc.b 1,	0, 1, 2, 3, 4, 0x43, 0x42, 0x41, 0x40, 0x61,	0x62, 0x63, 0x64, 0x23, 0x22, 0x21, 0, afBack, 1
		.align 2
