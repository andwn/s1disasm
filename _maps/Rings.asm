# ---------------------------------------------------------------------------
# Sprite mappings - rings
# ---------------------------------------------------------------------------
Map_Ring:	dc.w AT_85_front-Map_Ring, AT_85_angle1-Map_Ring
		dc.w AT_85_edge-Map_Ring, AT_85_angle2-Map_Ring
		dc.w AT_85_sparkle1-Map_Ring, AT_85_sparkle2-Map_Ring
		dc.w AT_85_sparkle3-Map_Ring, AT_85_sparkle4-Map_Ring
AT_85_front:		dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8	/* ring front */
AT_85_angle1:	dc.b 1
		dc.b 0xF8, 5, 0,	4, 0xF8	/* ring angle */
AT_85_edge:		dc.b 1
		dc.b 0xF8, 1, 0,	8, 0xFC	/* ring perpendicular */
AT_85_angle2:	dc.b 1
		dc.b 0xF8, 5, 8,	4, 0xF8	/* ring angle */
AT_85_sparkle1:	dc.b 1
		dc.b 0xF8, 5, 0,	0xA, 0xF8	/* sparkle */
AT_85_sparkle2:	dc.b 1
		dc.b 0xF8, 5, 0x18, 0xA, 0xF8 /* sparkle */
AT_85_sparkle3:	dc.b 1
		dc.b 0xF8, 5, 8,	0xA, 0xF8	/*sparkle */
AT_85_sparkle4:	dc.b 1
		dc.b 0xF8, 5, 0x10, 0xA, 0xF8 /* sparkle */
		.align 2


