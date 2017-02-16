# ---------------------------------------------------------------------------
# Sprite mappings - disc that you run around (SBZ)
# (It's just a small blob that moves around in a circle. The disc itself is
# part of the level tiles.)
# ---------------------------------------------------------------------------
Map_Disc:	dc.w AT_80_spot-Map_Disc
AT_80_spot:		dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8
		.align 2
