# ---------------------------------------------------------------------------
# Animation script - Chopper enemy
# ---------------------------------------------------------------------------
Ani_Chop:	dc.w AT_37_slow-Ani_Chop
		dc.w AT_37_fast-Ani_Chop
		dc.w AT_37_still-Ani_Chop
AT_37_slow:		dc.b 7,	0, 1, afEnd
AT_37_fast:		dc.b 3,	0, 1, afEnd
AT_37_still:		dc.b 7,	0, afEnd
		.align 2
