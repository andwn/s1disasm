# ---------------------------------------------------------------------------
# Sprite mappings - blocks that	disintegrate when Eggman presses a switch
# ---------------------------------------------------------------------------
Map_FFloor:	dc.w AT_48_wholeblock-Map_FFloor, AT_48_topleft-Map_FFloor
		dc.w AT_48_topright-Map_FFloor, AT_48_bottomleft-Map_FFloor
		dc.w AT_48_bottomright-Map_FFloor
AT_48_wholeblock:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0, 0xF0
AT_48_topleft:	dc.b 2
		dc.b 0xF8, 1, 0,	0, 0xF8
		dc.b 0xF8, 1, 0,	4, 0
		dc.b 0
AT_48_topright:	dc.b 2
		dc.b 0xF8, 1, 0,	8, 0xF8
		dc.b 0xF8, 1, 0,	0xC, 0
		dc.b 0
AT_48_bottomleft:	dc.b 2
		dc.b 0xF8, 1, 0,	2, 0xF8
		dc.b 0xF8, 1, 0,	6, 0
		dc.b 0
AT_48_bottomright:	dc.b 2
		dc.b 0xF8, 1, 0,	0xA, 0xF8
		dc.b 0xF8, 1, 0,	0xE, 0
		.align 2
