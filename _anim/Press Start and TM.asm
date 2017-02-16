# ---------------------------------------------------------------------------
# Animation script - "TM" and "PRESS START BUTTON" on the title screen
# ---------------------------------------------------------------------------
Ani_PSBTM:	dc.w AT_26_flash-Ani_PSBTM
AT_26_flash:		dc.b 0x1F, 0, 1,	afEnd
		.align 2
