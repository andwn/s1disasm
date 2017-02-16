# ---------------------------------------------------------------------------
# Sprite mappings - flapping door (LZ)
# ---------------------------------------------------------------------------
Map_Flap:	dc.w AT_49_closed-Map_Flap
		dc.w AT_49_halfway-Map_Flap
		dc.w AT_49_open-Map_Flap
AT_49_closed:	dc.b 2
		dc.b 0xE0, 7, 0,	0, 0xF8
		dc.b 0,	7, 0x10,	0, 0xF8
AT_49_halfway:	dc.b 2
		dc.b 0xDA, 0xF, 0, 8, 0xFB
		dc.b 6,	0xF, 0x10, 8, 0xFB
AT_49_open:		dc.b 2
		dc.b 0xD8, 0xD, 0, 0x18, 0
		dc.b 0x18, 0xD, 0x10, 0x18,	0
		.align 2
