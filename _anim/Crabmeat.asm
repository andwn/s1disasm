# ---------------------------------------------------------------------------
# Animation script - Crabmeat enemy
# ---------------------------------------------------------------------------
Ani_Crab:	dc.w AT_15_stand-Ani_Crab, AT_15_standslope-Ani_Crab, AT_15_standsloperev-Ani_Crab
		dc.w AT_15_walk-Ani_Crab, AT_15_walkslope-Ani_Crab, AT_15_walksloperev-Ani_Crab
		dc.w AT_15_firing-Ani_Crab, AT_15_ball-Ani_Crab
AT_15_stand:		dc.b 0xF, 0, afEnd
		.align 2
AT_15_standslope:	dc.b 0xF, 2, afEnd
		.align 2
AT_15_standsloperev:	dc.b 0xF, 0x22, afEnd
		.align 2
AT_15_walk:		dc.b 0xF, 1, 0x21, 0, afEnd
		.align 2
AT_15_walkslope:	dc.b 0xF, 0x21, 3, 2, afEnd
		.align 2
AT_15_walksloperev:	dc.b 0xF, 1, 0x23, 0x22, afEnd
		.align 2
AT_15_firing:	dc.b 0xF, 4, afEnd
		.align 2
AT_15_ball:		dc.b 1,	5, 6, afEnd
		.align 2
