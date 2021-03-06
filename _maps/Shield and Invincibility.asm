# ---------------------------------------------------------------------------
# Sprite mappings - shield and invincibility stars
# ---------------------------------------------------------------------------
Map_Shield:	dc.w AT_31_shield1-Map_Shield, AT_31_shield2-Map_Shield
		dc.w AT_31_shield3-Map_Shield, AT_31_shield4-Map_Shield
		dc.w AT_31_stars1-Map_Shield, AT_31_stars2-Map_Shield
		dc.w AT_31_stars3-Map_Shield, AT_31_stars4-Map_Shield
AT_31_shield2:	dc.b 4
		dc.b 0xE8, 0xA, 0, 0, 0xE8
		dc.b 0xE8, 0xA, 0, 9, 0
AT_31_shield1:	dc.b 0,	0xA, 0x10, 0, 0xE8
		dc.b 0,	0xA, 0x10, 9, 0
AT_31_shield3:	dc.b 4
		dc.b 0xE8, 0xA, 8, 0x12, 0xE9
		dc.b 0xE8, 0xA, 0, 0x12, 0
		dc.b 0,	0xA, 0x18, 0x12, 0xE9
		dc.b 0,	0xA, 0x10, 0x12, 0
AT_31_shield4:	dc.b 4
		dc.b 0xE8, 0xA, 8, 9, 0xE8
		dc.b 0xE8, 0xA, 8, 0, 0
		dc.b 0,	0xA, 0x18, 9, 0xE8
		dc.b 0,	0xA, 0x18, 0, 0
AT_31_stars1:	dc.b 4
		dc.b 0xE8, 0xA, 0, 0, 0xE8
		dc.b 0xE8, 0xA, 0, 9, 0
		dc.b 0,	0xA, 0x18, 9, 0xE8
		dc.b 0,	0xA, 0x18, 0, 0
AT_31_stars2:	dc.b 4
		dc.b 0xE8, 0xA, 8, 9, 0xE8
		dc.b 0xE8, 0xA, 8, 0, 0
		dc.b 0,	0xA, 0x10, 0, 0xE8
		dc.b 0,	0xA, 0x10, 9, 0
AT_31_stars3:	dc.b 4
		dc.b 0xE8, 0xA, 0, 0x12, 0xE8
		dc.b 0xE8, 0xA, 0, 0x1B, 0
		dc.b 0,	0xA, 0x18, 0x1B, 0xE8
		dc.b 0,	0xA, 0x18, 0x12, 0
AT_31_stars4:	dc.b 4
		dc.b 0xE8, 0xA, 8, 0x1B, 0xE8
		dc.b 0xE8, 0xA, 8, 0x12, 0
		dc.b 0,	0xA, 0x10, 0x12, 0xE8
		dc.b 0,	0xA, 0x10, 0x1B, 0
		.align 2
