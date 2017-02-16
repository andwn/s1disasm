# ---------------------------------------------------------------------------
# Animation script - energy ball launcher (FZ)
# ---------------------------------------------------------------------------
Ani_PLaunch:	dc.w AT_40_red-Ani_PLaunch
		dc.w AT_40_redsparking-Ani_PLaunch
		dc.w AT_40_whitesparking-Ani_PLaunch
AT_40_red:		dc.b 0x7E, 0, afEnd
		.align 2
AT_40_redsparking:	dc.b 1,	0, 2, 0, 3, afEnd
		.align 2
AT_40_whitesparking:	dc.b 1,	1, 2, 1, 3, afEnd
		.align 2
