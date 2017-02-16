# ---------------------------------------------------------------------------
# Sprite mappings - pinball bumper (SYZ)
# ---------------------------------------------------------------------------
Map_Bump:	dc.w AT_92_normal-Map_Bump
		dc.w AT_92_bumped1-Map_Bump
		dc.w AT_92_bumped2-Map_Bump
AT_92_normal:	dc.b 2
		dc.b 0xF0, 7, 0,	0, 0xF0
		dc.b 0xF0, 7, 8,	0, 0
AT_92_bumped1:	dc.b 2
		dc.b 0xF4, 6, 0,	8, 0xF4
		dc.b 0xF4, 2, 8,	8, 4
AT_92_bumped2:	dc.b 2
		dc.b 0xF0, 7, 0,	0xE, 0xF0
		dc.b 0xF0, 7, 8,	0xE, 0
		.align 2


