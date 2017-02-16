# ---------------------------------------------------------------------------
# Animation script - lava balls
# ---------------------------------------------------------------------------
Ani_Fire:	dc.w AT_22_vertical-Ani_Fire
		dc.w AT_22_vertcollide-Ani_Fire
		dc.w AT_22_horizontal-Ani_Fire
		dc.w AT_22_horicollide-Ani_Fire
AT_22_vertical:	dc.b 5,	0, 0x20,	1, 0x21,	afEnd
AT_22_vertcollide:	dc.b 5,	2, afRoutine
		.align 2
AT_22_horizontal:	dc.b 5,	3, 0x43,	4, 0x44,	afEnd
AT_22_horicollide:	dc.b 5,	5, afRoutine
		.align 2
