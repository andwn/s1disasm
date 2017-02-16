# ---------------------------------------------------------------------------
# Animation script - Motobug enemy
# ---------------------------------------------------------------------------
Ani_Moto:	dc.w AT_45_stand-Ani_Moto
		dc.w AT_45_walk-Ani_Moto
		dc.w AT_45_smoke-Ani_Moto

AT_45_stand:		dc.b 0xF, 2, afEnd
		.align 2
AT_45_walk:		dc.b 7,	0, 1, 0, 2, afEnd
AT_45_smoke:		dc.b 1,	3, 6, 3, 6, 4, 6, 4, 6,	4, 6, 5, afRoutine
		.align 2
