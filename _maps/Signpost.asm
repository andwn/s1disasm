# ---------------------------------------------------------------------------
# Sprite mappings - signpost
# ---------------------------------------------------------------------------
Map_Sign:	dc.w AT_102_eggman-Map_Sign, AT_102_spin1-Map_Sign
		dc.w AT_102_spin2-Map_Sign, AT_102_spin3-Map_Sign
		dc.w AT_102_sonic-Map_Sign
AT_102_eggman:	dc.b 3
		dc.b 0xF0, 0xB, 0, 0, 0xE8
		dc.b 0xF0, 0xB, 8, 0, 0
		dc.b 0x10, 1, 0,	0x38, 0xFC
AT_102_spin1:		dc.b 2
		dc.b 0xF0, 0xF, 0, 0xC, 0xF0
		dc.b 0x10, 1, 0,	0x38, 0xFC
AT_102_spin2:		dc.b 2
		dc.b 0xF0, 3, 0,	0x1C, 0xFC
		dc.b 0x10, 1, 8,	0x38, 0xFC
AT_102_spin3:		dc.b 2
		dc.b 0xF0, 0xF, 8, 0xC, 0xF0
		dc.b 0x10, 1, 8,	0x38, 0xFC
AT_102_sonic:		dc.b 3
		dc.b 0xF0, 0xB, 0, 0x20, 0xE8
		dc.b 0xF0, 0xB, 0, 0x2C, 0
		dc.b 0x10, 1, 0,	0x38, 0xFC
		.align 2


