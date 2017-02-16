# ---------------------------------------------------------------------------
# Animation script - flapping door (LZ)
# ---------------------------------------------------------------------------
Ani_Flap:	dc.w AT_21_opening-Ani_Flap
		dc.w AT_21_closing-Ani_Flap
AT_21_opening:	dc.b 3,	0, 1, 2, afBack, 1
AT_21_closing:	dc.b 3,	2, 1, 0, afBack, 1
		.align 2
