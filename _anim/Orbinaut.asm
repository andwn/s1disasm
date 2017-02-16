# ---------------------------------------------------------------------------
# Animation script - Orbinaut enemy
# ---------------------------------------------------------------------------
Ani_Orb:	dc.w AT_4_normal-Ani_Orb
		dc.w AT_4_angers-Ani_Orb
AT_4_normal:	dc.b 0xF, 0, afEnd
		.align 2
AT_4_angers:	dc.b 0xF, 1, 2, afBack, 1
		.align 2
