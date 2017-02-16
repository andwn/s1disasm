# ---------------------------------------------------------------------------
# Animation script - geyser of lava (MZ)
# ---------------------------------------------------------------------------
Ani_Geyser:	dc.w AT_5_bubble1-Ani_Geyser
		dc.w AT_5_bubble2-Ani_Geyser
		dc.w AT_5_end-Ani_Geyser
		dc.w AT_5_bubble3-Ani_Geyser
		dc.w AT_5_blank-Ani_Geyser
		dc.w AT_5_bubble4-Ani_Geyser
AT_5_bubble1:	dc.b 2,	0, 1, 0, 1, 4, 5, 4, 5,	afRoutine
AT_5_bubble2:	dc.b 2,	2, 3, afEnd
AT_5_end:		dc.b 2,	6, 7, afEnd
AT_5_bubble3:	dc.b 2,	2, 3, 0, 1, 0, 1, afRoutine
AT_5_blank:		dc.b 0xF, 0x13, afEnd
		.align 2
AT_5_bubble4:	dc.b 2,	0x11, 0x12, afEnd
		.align 2
