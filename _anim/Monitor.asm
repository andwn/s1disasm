# ---------------------------------------------------------------------------
# Animation script - monitors
# ---------------------------------------------------------------------------
Ani_Monitor:	dc.w AT_16_static-Ani_Monitor, AT_16_eggman-Ani_Monitor, AT_16_sonic-Ani_Monitor
		dc.w AT_16_shoes-Ani_Monitor, AT_16_shield-Ani_Monitor, AT_16_invincible-Ani_Monitor
		dc.w AT_16_rings-Ani_Monitor, AT_16_s-Ani_Monitor, AT_16_goggles-Ani_Monitor
		dc.w AT_16_breaking-Ani_Monitor
AT_16_static:	dc.b 1,	0, 1, 2, afEnd
		.align 2
AT_16_eggman:	dc.b 1,	0, 3, 3, 1, 3, 3, 2, 3,	3, afEnd
		.align 2
AT_16_sonic:		dc.b 1,	0, 4, 4, 1, 4, 4, 2, 4,	4, afEnd
		.align 2
AT_16_shoes:		dc.b 1,	0, 5, 5, 1, 5, 5, 2, 5,	5, afEnd
		.align 2
AT_16_shield:	dc.b 1,	0, 6, 6, 1, 6, 6, 2, 6,	6, afEnd
		.align 2
AT_16_invincible:	dc.b 1,	0, 7, 7, 1, 7, 7, 2, 7,	7, afEnd
		.align 2
AT_16_rings:		dc.b 1,	0, 8, 8, 1, 8, 8, 2, 8,	8, afEnd
		.align 2
AT_16_s:		dc.b 1,	0, 9, 9, 1, 9, 9, 2, 9,	9, afEnd
		.align 2
AT_16_goggles:	dc.b 1,	0, 0xA, 0xA, 1, 0xA, 0xA, 2, 0xA, 0xA, afEnd
		.align 2
AT_16_breaking:	dc.b 2,	0, 1, 2, 0xB, afBack, 1
		.align 2
