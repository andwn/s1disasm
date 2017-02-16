# ---------------------------------------------------------------------------
# Animation script - Eggman on the "TRY AGAIN" and "END" screens
# ---------------------------------------------------------------------------
Ani_EEgg:	dc.w AT_49_tryagain1-Ani_EEgg
		dc.w AT_49_tryagain2-Ani_EEgg
		dc.w AT_49_end-Ani_EEgg
AT_49_tryagain1:	dc.b 5,	0, afRoutine, 1
AT_49_tryagain2:	dc.b 5,	2, afRoutine, 3
AT_49_end:		dc.b 7,	4, 5, 6, 5, 4, 5, 6, 5,	4, 5, 6, 5, 7, 5, 6, 5,	afEnd
		.align 2
