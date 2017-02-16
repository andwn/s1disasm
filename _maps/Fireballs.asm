# ---------------------------------------------------------------------------
# Sprite mappings - fire balls (MZ, SLZ)
# ---------------------------------------------------------------------------
Map_Fire:	dc.w AT_51_vertical1-Map_Fire
		dc.w AT_51_vertical2-Map_Fire
		dc.w AT_51_vertcollide-Map_Fire
		dc.w AT_51_horizontal1-Map_Fire
		dc.w AT_51_horizontal2-Map_Fire
		dc.w AT_51_horicollide-Map_Fire
AT_51_vertical1:	dc.b 1
		dc.b 0xE8, 7, 0,	0, 0xF8
AT_51_vertical2:	dc.b 1
		dc.b 0xE8, 7, 0,	8, 0xF8
AT_51_vertcollide:	dc.b 1
		dc.b 0xF0, 6, 0,	0x10, 0xF8
AT_51_horizontal1:	dc.b 1
		dc.b 0xF8, 0xD, 0, 0x16, 0xE8
AT_51_horizontal2:	dc.b 1
		dc.b 0xF8, 0xD, 0, 0x1E, 0xE8
AT_51_horicollide:	dc.b 1
		dc.b 0xF8, 9, 0,	0x26, 0xF0
		.align 2


