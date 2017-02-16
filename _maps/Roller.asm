# ---------------------------------------------------------------------------
# Sprite mappings - Roller enemy (SYZ)
# ---------------------------------------------------------------------------
Map_Roll:	dc.w M_Roll_Stand-Map_Roll
		dc.w M_Roll_Fold-Map_Roll
		dc.w M_Roll_Roll1-Map_Roll
		dc.w M_Roll_Roll2-Map_Roll
		dc.w M_Roll_Roll3-Map_Roll
M_Roll_Stand:	dc.b 2
		dc.b 0xDE, 0xE, 0, 0, 0xF0	/* standing */
		dc.b 0xF6, 0xE, 0, 0xC, 0xF0
M_Roll_Fold:	dc.b 2
		dc.b 0xE6, 0xE, 0, 0, 0xF0	/* folding */
		dc.b 0xFE, 0xD, 0, 0x18, 0xF0
M_Roll_Roll1:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x20, 0xF0 /* rolling */
M_Roll_Roll2:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x30, 0xF0 /* rolling */
M_Roll_Roll3:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x40, 0xF0 /* rolling */
		.align 2


