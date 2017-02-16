# ---------------------------------------------------------------------------
# Animation script - energy balls (FZ)
# ---------------------------------------------------------------------------
Ani_Plasma:	dc.w AT_43_full-Ani_Plasma
		dc.w AT_043_short-Ani_Plasma
AT_43_full:		dc.b 1,	0, 0xA, 8, 0xA, 1, 0xA, 9,	0xA, 6, 0xA, 7, 0xA, 0, 0xA
		dc.b 8,	0xA, 1, 0xA, 9, 0xA, 6, 0xA, 7, 0xA,	2, 0xA, 3, 0xA, 4
		dc.b 0xA, 5, afEnd
		.align 2
AT_043_short:		dc.b 0,	6, 5, 1, 5, 7, 5, 1, 5,	afEnd
		.align 2
