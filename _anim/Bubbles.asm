# ---------------------------------------------------------------------------
# Animation script - bubbles (LZ)
# ---------------------------------------------------------------------------
Ani_Bub:	dc.w AT_9_small-Ani_Bub
		dc.w AT_9_medium-Ani_Bub
		dc.w AT_9_large-Ani_Bub
		dc.w AT_9_incroutine-Ani_Bub
		dc.w AT_9_incroutine-Ani_Bub
		dc.w AT_9_burst-Ani_Bub
		dc.w AT_9_bubmaker-Ani_Bub
AT_9_small:		dc.b 0xE, 0, 1, 2, afRoutine /* small bubble forming */
		.align 2
AT_9_medium:	dc.b 0xE, 1, 2, 3, 4, afRoutine /* medium bubble forming */
AT_9_large:		dc.b 0xE, 2, 3, 4, 5, 6,	afRoutine /* full size bubble forming */
		.align 2
AT_9_incroutine:	dc.b 4,	afRoutine	/* increment routine counter (no animation) */
AT_9_burst:		dc.b 4,	6, 7, 8, afRoutine /* large bubble bursts */
		.align 2
AT_9_bubmaker:	dc.b 0xF, 0x13, 0x14, 0x15,	afEnd /* bubble maker on the floor */
		.align 2
