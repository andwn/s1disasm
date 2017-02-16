# ---------------------------------------------------------------------------
# Sprite mappings - Orbinaut enemy (LZ,	SLZ, SBZ)
# ---------------------------------------------------------------------------
Map_Orb:	dc.w AT_10_normal-Map_Orb
		dc.w AT_10_medium-Map_Orb
		dc.w AT_10_angry-Map_Orb
		dc.w AT_10_spikeball-Map_Orb
AT_10_normal:	dc.b 1
		dc.b 0xF4, 0xA, 0, 0, 0xF4
AT_10_medium:	dc.b 1
		dc.b 0xF4, 0xA, 0x20, 9, 0xF4
AT_10_angry:		dc.b 1
		dc.b 0xF4, 0xA, 0, 0x12, 0xF4
AT_10_spikeball:	dc.b 1
		dc.b 0xF8, 5, 0,	0x1B, 0xF8
		.align 2


