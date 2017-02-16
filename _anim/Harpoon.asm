# ---------------------------------------------------------------------------
# Animation script - harpoon (LZ)
# ---------------------------------------------------------------------------
Ani_Harp:	dc.w AT_17_h_extending-Ani_Harp
		dc.w AT_17_h_retracting-Ani_Harp
		dc.w AT_17_v_extending-Ani_Harp
		dc.w AT_17_v_retracting-Ani_Harp
AT_17_h_extending:	dc.b 3,	1, 2, afRoutine
AT_17_h_retracting:	dc.b 3,	1, 0, afRoutine
AT_17_v_extending:	dc.b 3,	4, 5, afRoutine
AT_17_v_retracting:	dc.b 3,	4, 3, afRoutine
		.align 2
