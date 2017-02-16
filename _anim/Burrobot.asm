# ---------------------------------------------------------------------------
# Animation script - Burrobot enemy
# ---------------------------------------------------------------------------
Ani_Burro:	dc.w AT_2_walk1-Ani_Burro
		dc.w AT_2_walk2-Ani_Burro
		dc.w AT_2_digging-Ani_Burro
		dc.w AT_2_fall-Ani_Burro
AT_2_walk1:		dc.b 3,	0, 6, afEnd
AT_2_walk2:		dc.b 3,	0, 1, afEnd
AT_2_digging:	dc.b 3,	2, 3, afEnd
AT_2_fall:		dc.b 3,	4, afEnd
		.align 2
