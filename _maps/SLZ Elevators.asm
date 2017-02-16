# ---------------------------------------------------------------------------
# Sprite mappings - platforms that move	when you stand on them (SLZ)
# ---------------------------------------------------------------------------
Map_Elev:	dc.w AT_70_elevator-Map_Elev
AT_70_elevator:	dc.b 3
		dc.b 0xF8, 0xF, 0, 0x41, 0xD8
		dc.b 0xF8, 0xF, 0, 0x41, 0xF8
		dc.b 0xF8, 7, 0,	0x41, 0x18
		.align 2
