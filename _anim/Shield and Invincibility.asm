# ---------------------------------------------------------------------------
# Animation script - shield and invincibility stars
# ---------------------------------------------------------------------------
Ani_Shield:	dc.w AT_11_shield-Ani_Shield
		dc.w AT_11_stars1-Ani_Shield
		dc.w AT_11_stars2-Ani_Shield
		dc.w AT_11_stars3-Ani_Shield
		dc.w AT_11_stars4-Ani_Shield
AT_11_shield:	dc.b 1,	1, 0, 2, 0, 3, 0, afEnd
AT_11_stars1:	dc.b 5,	4, 5, 6, 7, afEnd
AT_11_stars2:	dc.b 0,	4, 4, 0, 4, 4, 0, 5, 5,	0, 5, 5, 0, 6, 6, 0, 6
		dc.b 6,	0, 7, 7, 0, 7, 7, 0, afEnd
AT_11_stars3:	dc.b 0,	4, 4, 0, 4, 0, 0, 5, 5,	0, 5, 0, 0, 6, 6, 0, 6
		dc.b 0,	0, 7, 7, 0, 7, 0, 0, afEnd
AT_11_stars4:	dc.b 0,	4, 0, 0, 4, 0, 0, 5, 0,	0, 5, 0, 0, 6, 0, 0, 6
		dc.b 0,	0, 7, 0, 0, 7, 0, 0, afEnd
		.align 2
