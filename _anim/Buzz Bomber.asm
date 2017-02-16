# ---------------------------------------------------------------------------
# Animation script - Buzz Bomber enemy
# ---------------------------------------------------------------------------
Ani_Buzz:	dc.w AT_20_fly1-Ani_Buzz
		dc.w AT_20_fly2-Ani_Buzz
		dc.w AT_20_fires-Ani_Buzz
AT_20_fly1:		dc.b 1,	0, 1, afEnd
AT_20_fly2:		dc.b 1,	2, 3, afEnd
AT_20_fires:		dc.b 1,	4, 5, afEnd
		.align 2
