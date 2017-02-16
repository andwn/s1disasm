# ---------------------------------------------------------------------------
# Sprite mappings - Crabmeat enemy (GHZ, SYZ)
# ---------------------------------------------------------------------------
Map_Crab:	dc.w AT_39_stand-Map_Crab, AT_39_walk-Map_Crab
		dc.w AT_39_slope1-Map_Crab, AT_39_slope2-Map_Crab
		dc.w AT_39_firing-Map_Crab, AT_39_ball1-Map_Crab
		dc.w AT_39_ball2-Map_Crab
AT_39_stand:		dc.b 4
		dc.b 0xF0, 9, 0,	0, 0xE8	/* standing/middle walking frame */
		dc.b 0xF0, 9, 8,	0, 0
		dc.b 0,	5, 0, 6, 0xF0
		dc.b 0,	5, 8, 6, 0
AT_39_walk:		dc.b 4
		dc.b 0xF0, 9, 0,	0xA, 0xE8	/* walking */
		dc.b 0xF0, 9, 0,	0x10, 0
		dc.b 0,	5, 0, 0x16, 0xF0
		dc.b 0,	9, 0, 0x1A, 0
AT_39_slope1:	dc.b 4
		dc.b 0xEC, 9, 0,	0, 0xE8	/* walking on slope */
		dc.b 0xEC, 9, 8,	0, 0
		dc.b 0xFC, 5, 8,	6, 0
		dc.b 0xFC, 6, 0,	0x20, 0xF0
AT_39_slope2:	dc.b 4
		dc.b 0xEC, 9, 0,	0xA, 0xE8	/* walking on slope */
		dc.b 0xEC, 9, 0,	0x10, 0
		dc.b 0xFC, 9, 0,	0x26, 0
		dc.b 0xFC, 6, 0,	0x2C, 0xF0
AT_39_firing:	dc.b 6
		dc.b 0xF0, 4, 0,	0x32, 0xF0 /* firing projectiles */
		dc.b 0xF0, 4, 8,	0x32, 0
		dc.b 0xF8, 9, 0,	0x34, 0xE8
		dc.b 0xF8, 9, 8,	0x34, 0
		dc.b 8,	4, 0, 0x3A, 0xF0
		dc.b 8,	4, 8, 0x3A, 0
AT_39_ball1:		dc.b 1
		dc.b 0xF8, 5, 0,	0x3C, 0xF8 /* projectile */
AT_39_ball2:		dc.b 1
		dc.b 0xF8, 5, 0,	0x40, 0xF8 /* projectile */
		.align 2


