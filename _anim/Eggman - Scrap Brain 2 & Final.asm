# ---------------------------------------------------------------------------
# Animation script - Eggman (SBZ2)
# ---------------------------------------------------------------------------
Ani_SEgg:	dc.w AT_35_stand-Ani_SEgg
		dc.w AT_35_laugh-Ani_SEgg
		dc.w AT_35_jump1-Ani_SEgg
		dc.w AT_35_intube-Ani_SEgg
		dc.w AT_35_running-Ani_SEgg
		dc.w AT_35_jump2-Ani_SEgg
		dc.w AT_35_starjump-Ani_SEgg
AT_35_stand:		dc.b 0x7E, 0, afEnd
		.align 2
AT_35_laugh:		dc.b 6,	1, 2, afEnd
AT_35_jump1:		dc.b 0xE, 3, 4, 4, 0, 0,	0, afEnd
AT_35_intube:	dc.b 0,	5, 9, afEnd
AT_35_running:	dc.b 6,	7, 4, 8, 4, afEnd
AT_35_jump2:		dc.b 0xF, 4, 3, 3, afEnd
		.align 2
AT_35_starjump:	dc.b 0x7E, 6, afEnd
		.align 2
