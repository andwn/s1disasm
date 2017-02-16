# ---------------------------------------------------------------------------
# Sprite mappings - spiked ball on a chain (SBZ) and big spiked ball (SYZ)
# ---------------------------------------------------------------------------
Map_BBall:	dc.w AT_95_ball-Map_BBall
		dc.w AT_95_chain-Map_BBall
		dc.w AT_95_anchor-Map_BBall
AT_95_ball:		dc.b 5
		dc.b 0xE8, 4, 0,	0, 0xF8	/* big spiked ball */
		dc.b 0xF0, 0xF, 0, 2, 0xF0
		dc.b 0xF8, 1, 0,	0x12, 0xE8
		dc.b 0xF8, 1, 0,	0x14, 0x10
		dc.b 0x10, 4, 0,	0x16, 0xF8
AT_95_chain:		dc.b 1
		dc.b 0xF8, 5, 0,	0x20, 0xF8 /* chain link (SBZ) */
AT_95_anchor:	dc.b 2
		dc.b 0xF8, 0xD, 0, 0x18, 0xF0 /* anchor at base of chain (SBZ) */
		dc.b 0xE8, 0xD, 0x10, 0x18,	0xF0
		.align 2
