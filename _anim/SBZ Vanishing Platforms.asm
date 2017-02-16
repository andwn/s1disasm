# ---------------------------------------------------------------------------
# Animation script - vanishing platforms (SBZ)
# ---------------------------------------------------------------------------
Ani_Van:	dc.w AT_13_vanish-Ani_Van
		dc.w AT_13_appear-Ani_Van
AT_13_vanish:	dc.b 7,	0, 1, 2, 3, afBack, 1
		.align 2
AT_13_appear:	dc.b 7,	3, 2, 1, 0, afBack, 1
		.align 2
