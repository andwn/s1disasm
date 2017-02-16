# ---------------------------------------------------------------------------
# Animation script - signpost
# ---------------------------------------------------------------------------
Ani_Sign:	dc.w AT_38_eggman-Ani_Sign
		dc.w AT_38_spin1-Ani_Sign
		dc.w AT_38_spin2-Ani_Sign
		dc.w AT_38_sonic-Ani_Sign
AT_38_eggman:	dc.b 0xF, 0, afEnd
		.align 2
AT_38_spin1:		dc.b 1,	0, 1, 2, 3, afEnd
AT_38_spin2:		dc.b 1,	4, 1, 2, 3, afEnd
AT_38_sonic:		dc.b 0xF, 4, afEnd
		.align 2
