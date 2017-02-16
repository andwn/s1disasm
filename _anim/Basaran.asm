# ---------------------------------------------------------------------------
# Animation script - Basaran enemy
# ---------------------------------------------------------------------------
Ani_Bas:	dc.w AT_50_still-Ani_Bas
		dc.w AT_50_fall-Ani_Bas
		dc.w AT_50_fly-Ani_Bas
AT_50_still:		dc.b 0xF, 0, afEnd
		.align 2
AT_50_fall:		dc.b 0xF, 1, afEnd
		.align 2
AT_50_fly:		dc.b 3,	1, 2, 3, 2, afEnd
		.align 2
