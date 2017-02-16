# ---------------------------------------------------------------------------
# Sprite mappings - spiked ball	on a chain (LZ)
# ---------------------------------------------------------------------------
Map_SBall2:	dc.w AT_63_chain-Map_SBall2
		dc.w AT_63_spikeball-Map_SBall2
		dc.w AT_63_base-Map_SBall2
AT_63_chain:		dc.b 1
		dc.b 0xF8, 5, 0,	0, 0xF8	/* chain link */
AT_63_spikeball:	dc.b 1
		dc.b 0xF0, 0xF, 0, 4, 0xF0	/* spikeball */
AT_63_base:		dc.b 1
		dc.b 0xF8, 5, 0,	0x14, 0xF8 /* wall attachment */
		.align 2
