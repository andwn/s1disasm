# ---------------------------------------------------------------------------
# Sprite mappings - GHZ	bridge
# ---------------------------------------------------------------------------
Map_Bri:	dc.w M_Bri_Log-Map_Bri
		dc.w M_Bri_Stump-Map_Bri
		dc.w M_Bri_Rope-Map_Bri
M_Bri_Log:	dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8	/* log */
M_Bri_Stump:	dc.b 2
		dc.b 0xF8, 4, 0,	4, 0xF0	/* stump & rope */
		dc.b 0,	0xC, 0, 6, 0xF0
M_Bri_Rope:	dc.b 1
		dc.b 0xFC, 4, 0,	8, 0xF8	/* rope only */
		.align 2


