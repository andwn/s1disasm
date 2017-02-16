# ---------------------------------------------------------------------------
# Animation script - platform on conveyor belt (SBZ)
# ---------------------------------------------------------------------------
Ani_SpinConvey:	dc.w AT_47_spin-Ani_SpinConvey
		dc.w AT_47_still-Ani_SpinConvey
AT_47_spin:		dc.b 0,	0, 1, 2, 3, 4, 0x43, 0x42, 0x41, 0x40, 0x61,	0x62, 0x63
		dc.b 0x64, 0x23, 0x22, 0x21, 0, afEnd
		.align 2
AT_47_still:		dc.b 0xF, 0, afEnd
		.align 2
