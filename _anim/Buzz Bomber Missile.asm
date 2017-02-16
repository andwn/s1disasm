# ---------------------------------------------------------------------------
# Animation script - missile that Buzz Bomber throws
# ---------------------------------------------------------------------------
Ani_Missile:	dc.w AT_14_flare-Ani_Missile
		dc.w AT_14_missile-Ani_Missile
AT_14_flare:		dc.b 7,	0, 1, afRoutine
AT_14_missile:	dc.b 1,	2, 3, afEnd
		.align 2
