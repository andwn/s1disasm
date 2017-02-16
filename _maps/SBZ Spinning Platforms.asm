# ---------------------------------------------------------------------------
# Sprite mappings - spinning platforms (SBZ)
# ---------------------------------------------------------------------------
Map_Spin:	dc.w AT_61_flat-Map_Spin, AT_61_spin1-Map_Spin
		dc.w AT_61_spin2-Map_Spin, AT_61_spin3-Map_Spin
		dc.w AT_61_spin4-Map_Spin
AT_61_flat:		dc.b 2
		dc.b 0xF8, 5, 0,	0, 0xF0
		dc.b 0xF8, 5, 8,	0, 0
AT_61_spin1:		dc.b 2
		dc.b 0xF0, 0xD, 0, 0x14, 0xF0
		dc.b 0,	0xD, 0, 0x1C, 0xF0
AT_61_spin2:		dc.b 2
		dc.b 0xF0, 9, 0,	4, 0xF0
		dc.b 0,	9, 0, 0xA, 0xF8
AT_61_spin3:		dc.b 2
		dc.b 0xF0, 9, 0,	0x24, 0xF0
		dc.b 0,	9, 0, 0x2A, 0xF8
AT_61_spin4:		dc.b 2
		dc.b 0xF0, 5, 0,	0x10, 0xF8
		dc.b 0,	5, 0x10,	0x10, 0xF8
		.align 2
