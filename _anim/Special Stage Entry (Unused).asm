# ---------------------------------------------------------------------------
# Animation script - special stage entry effect from beta
# ---------------------------------------------------------------------------
Ani_Vanish:	dc.w AT_1_vanish-Ani_Vanish
AT_1_vanish:	dc.b 5,	0, 1, 0, 1, 0, 7, 1, 7,	2, 7, 3, 7, 4, 7, 5, 7, 6, 7, afRoutine
		.align 2
