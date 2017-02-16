# ---------------------------------------------------------------------------
# Sprite mappings - points that	appear when you	destroy	something
# ---------------------------------------------------------------------------
Map_Poi:	dc.w byte_94BC-Map_Poi, byte_94C2-Map_Poi
		dc.w byte_94C8-Map_Poi, byte_94CE-Map_Poi
		dc.w byte_94D4-Map_Poi, byte_94DA-Map_Poi
		dc.w byte_94E5-Map_Poi
byte_94BC:	dc.b 1
		dc.b 0xFC, 4, 0,	0, 0xF8	/* 100 points */
byte_94C2:	dc.b 1
		dc.b 0xFC, 4, 0,	2, 0xF8	/* 200 points */
byte_94C8:	dc.b 1
		dc.b 0xFC, 4, 0,	4, 0xF8	/* 500 points */
byte_94CE:	dc.b 1
		dc.b 0xFC, 8, 0,	6, 0xF8	/* 1000 points */
byte_94D4:	dc.b 1
		dc.b 0xFC, 0, 0,	6, 0xFC	/* 10 points */
byte_94DA:	dc.b 2
		dc.b 0xFC, 8, 0,	6, 0xF4	/* 10,000 points */
		dc.b 0xFC, 4, 0,	7, 1
byte_94E5:	dc.b 2
		dc.b 0xFC, 8, 0,	6, 0xF4	/* 100,000 points */
		dc.b 0xFC, 4, 0,	7, 6
		.align 2


