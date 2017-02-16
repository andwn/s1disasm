# ---------------------------------------------------------------------------
# Animation script - Yadrin enemy
# ---------------------------------------------------------------------------
Ani_Yad:	dc.w AT_8_stand-Ani_Yad
		dc.w AT_8_walk-Ani_Yad

AT_8_stand:		dc.b 7,	0, afEnd
		.align 2
AT_8_walk:		dc.b 7,	0, 3, 1, 4, 0, 3, 2, 5,	afEnd
		.align 2
