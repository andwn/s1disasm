# ---------------------------------------------------------------------------
# Sprite mappings - legs on Eggman's escape ship (FZ)
# ---------------------------------------------------------------------------
Map_FZLegs:	dc.w AT_56_extended-Map_FZLegs
		dc.w AT_56_halfway-Map_FZLegs
		dc.w AT_56_retracted-Map_FZLegs
AT_56_extended:	dc.b 2
		dc.b 0x14, 0xE, 0x28, 0, 0xF4
		dc.b 0x24, 0, 0x28, 0xC, 0xEC
AT_56_halfway:	dc.b 3
		dc.b 0xC, 5, 0x28, 0xD, 0xC
		dc.b 0x1C, 0, 0x28, 0x11, 0xC
		dc.b 0x14, 0xD, 0x28, 0x12,	0xEC
AT_56_retracted:	dc.b 2
		dc.b 0xC, 1, 0x28, 0x1A, 0xC
		dc.b 0x14, 0xC, 0x28, 0x1C,	0xEC
		.align 2
