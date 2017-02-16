# ---------------------------------------------------------------------------
# Sprite mappings - springs
# ---------------------------------------------------------------------------
Map_Spring:	dc.w M_Spg_Up-Map_Spring
		dc.w M_Spg_UpFlat-Map_Spring
		dc.w M_Spg_UpExt-Map_Spring
		dc.w M_Spg_Left-Map_Spring
		dc.w M_Spg_LeftFlat-Map_Spring
		dc.w M_Spg_LeftExt-Map_Spring
M_Spg_Up:	dc.b 2			/* facing up */
		dc.b 0xF8, 0xC, 0, 0, 0xF0
		dc.b 0,	0xC, 0, 4, 0xF0
M_Spg_UpFlat:	dc.b 1			/* facing up, flattened */
		dc.b 0,	0xC, 0, 0, 0xF0
M_Spg_UpExt:	dc.b 3			/* facing up, extended */
		dc.b 0xE8, 0xC, 0, 0, 0xF0
		dc.b 0xF0, 5, 0,	8, 0xF8
		dc.b 0,	0xC, 0, 0xC, 0xF0
M_Spg_Left:	dc.b 1			/* facing left */
		dc.b 0xF0, 7, 0,	0, 0xF8
M_Spg_LeftFlat:	dc.b 1			/* facing left, flattened */
		dc.b 0xF0, 3, 0,	4, 0xF8
M_Spg_LeftExt:	dc.b 4			/* facing left, extended */
		dc.b 0xF0, 3, 0,	4, 0x10
		dc.b 0xF8, 9, 0,	8, 0xF8
		dc.b 0xF0, 0, 0,	0, 0xF8
		dc.b 8,	0, 0, 3, 0xF8
		.align 2


