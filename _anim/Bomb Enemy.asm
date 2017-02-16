# ---------------------------------------------------------------------------
# Animation script - Bomb enemy
# ---------------------------------------------------------------------------
Ani_Bomb:	dc.w AT_039_stand-Ani_Bomb
		dc.w AT_039_walk-Ani_Bomb
		dc.w AT_39_activated-Ani_Bomb
		dc.w AT_39_fuse-Ani_Bomb
		dc.w AT_39_shrapnel-Ani_Bomb
AT_039_stand:		dc.b 0x13, 1, 0,	afEnd
AT_039_walk:		dc.b 0x13, 5, 4,	3, 2, afEnd
AT_39_activated:	dc.b 0x13, 7, 6,	afEnd
AT_39_fuse:		dc.b 3,	8, 9, afEnd
AT_39_shrapnel:	dc.b 3,	0xA, 0xB,	afEnd
		.align 2
