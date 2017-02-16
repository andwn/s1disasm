# ---------------------------------------------------------------------------
# Animation script - doors (SBZ)
# ---------------------------------------------------------------------------
Ani_ADoor:	dc.w AT_10_close-Ani_ADoor
		dc.w AT_10_open-Ani_ADoor
AT_10_close:		dc.b 0,	8, 7, 6, 5, 4, 3, 2, 1,	0, afBack, 1
AT_10_open:		dc.b 0,	0, 1, 2, 3, 4, 5, 6, 7,	8, afBack, 1
		.align 2
