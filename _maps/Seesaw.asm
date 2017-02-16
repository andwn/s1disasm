# ---------------------------------------------------------------------------
# Sprite mappings - seesaws (SLZ)
# ---------------------------------------------------------------------------
Map_Seesaw:	dc.w AT_127_sloping-Map_Seesaw
		dc.w AT_127_flat-Map_Seesaw
		dc.w AT_127_sloping-Map_Seesaw
		dc.w AT_127_flat-Map_Seesaw
AT_127_sloping:	dc.b 7
		dc.b 0xD4, 6, 0,	0, 0xD3
		dc.b 0xDC, 6, 0,	6, 0xE3
		dc.b 0xE4, 4, 0,	0xC, 0xF3
		dc.b 0xEC, 0xD, 0, 0xE, 0xF3
		dc.b 0xFC, 8, 0,	0x16, 0xFB
		dc.b 0xF4, 6, 0,	6, 0x13
		dc.b 0xFC, 5, 0,	0x19, 0x23
AT_127_flat:		dc.b 4
		dc.b 0xE6, 0xA, 0, 0x1D, 0xD0
		dc.b 0xE6, 0xA, 0, 0x23, 0xE8
		dc.b 0xE6, 0xA, 8, 0x23, 0
		dc.b 0xE6, 0xA, 8, 0x1D, 0x18
		.align 2



