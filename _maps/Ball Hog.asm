# ---------------------------------------------------------------------------
# Sprite mappings - Ball Hog enemy (SBZ)
# ---------------------------------------------------------------------------
Map_Hog:	dc.w M_Hog_Stand-Map_Hog
		dc.w M_Hog_Open-Map_Hog
		dc.w M_Hog_Squat-Map_Hog
		dc.w M_Hog_Leap-Map_Hog
		dc.w M_Hog_Ball1-Map_Hog
		dc.w M_Hog_Ball2-Map_Hog
M_Hog_Stand:	dc.b 2
		dc.b 0xEF, 9, 0,	0, 0xF4
		dc.b 0xFF, 0xA, 0, 6, 0xF4	/* Ball hog standing */
M_Hog_Open:	dc.b 2
		dc.b 0xEF, 9, 0,	0, 0xF4
		dc.b 0xFF, 0xA, 0, 0xF, 0xF4 /* Ball hog with hatch open */
M_Hog_Squat:	dc.b 2
		dc.b 0xF4, 9, 0,	0, 0xF4
		dc.b 4,	9, 0, 0x18, 0xF4	/* Ball hog squatting */
M_Hog_Leap:	dc.b 2
		dc.b 0xE4, 9, 0,	0, 0xF4
		dc.b 0xF4, 0xA, 0, 0x1E, 0xF4 /* Ball hog leaping */
M_Hog_Ball1:	dc.b 1
		dc.b 0xF8, 5, 0,	0x27, 0xF8 /* Ball (black) */
M_Hog_Ball2:	dc.b 1
		dc.b 0xF8, 5, 0,	0x2B, 0xF8 /* Ball (red) */
		.align 2
