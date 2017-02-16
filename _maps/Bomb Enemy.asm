# ---------------------------------------------------------------------------
# Sprite mappings - walking bomb enemy (SLZ, SBZ)
# ---------------------------------------------------------------------------
Map_Bomb:	dc.w AT_106_stand1-Map_Bomb, AT_106_stand2-Map_Bomb
		dc.w AT_106_walk1-Map_Bomb, AT_106_walk2-Map_Bomb
		dc.w AT_106_walk3-Map_Bomb, AT_106_walk4-Map_Bomb
		dc.w AT_106_activate1-Map_Bomb, AT_106_activate2-Map_Bomb
		dc.w AT_106_fuse1-Map_Bomb, AT_106_fuse2-Map_Bomb
		dc.w AT_106_shrapnel1-Map_Bomb, AT_106_shrapnel2-Map_Bomb
AT_106_stand1:	dc.b 3
		dc.b 0xF1, 0xA, 0, 0, 0xF4	/* bomb standing still */
		dc.b 9,	8, 0, 0x12, 0xF4
		dc.b 0xE7, 1, 0,	0x21, 0xFC
AT_106_stand2:	dc.b 3
		dc.b 0xF1, 0xA, 0, 9, 0xF4
		dc.b 9,	8, 0, 0x12, 0xF4
		dc.b 0xE7, 1, 0,	0x21, 0xFC
AT_106_walk1:		dc.b 3
		dc.b 0xF0, 0xA, 0, 0, 0xF4	/* bomb walking */
		dc.b 8,	8, 0, 0x15, 0xF4
		dc.b 0xE6, 1, 0,	0x21, 0xFC
AT_106_walk2:		dc.b 3
		dc.b 0xF1, 0xA, 0, 9, 0xF4
		dc.b 9,	8, 0, 0x18, 0xF4
		dc.b 0xE7, 1, 0,	0x21, 0xFC
AT_106_walk3:		dc.b 3
		dc.b 0xF0, 0xA, 0, 0, 0xF4
		dc.b 8,	8, 0, 0x1B, 0xF4
		dc.b 0xE6, 1, 0,	0x21, 0xFC
AT_106_walk4:		dc.b 3
		dc.b 0xF1, 0xA, 0, 9, 0xF4
		dc.b 9,	8, 0, 0x1E, 0xF4
		dc.b 0xE7, 1, 0,	0x21, 0xFC
AT_106_activate1:	dc.b 2
		dc.b 0xF1, 0xA, 0, 0, 0xF4	/* bomb during detonation countdown */
		dc.b 9,	8, 0, 0x12, 0xF4
AT_106_activate2:	dc.b 2
		dc.b 0xF1, 0xA, 0, 9, 0xF4
		dc.b 9,	8, 0, 0x12, 0xF4
AT_106_fuse1:		dc.b 1
		dc.b 0xE7, 1, 0,	0x23, 0xFC /* fuse	(just before it	explodes) */
AT_106_fuse2:		dc.b 1
		dc.b 0xE7, 1, 0,	0x25, 0xFC
AT_106_shrapnel1:	dc.b 1
		dc.b 0xFC, 0, 0,	0x27, 0xFC /* shrapnel (after it exploded) */
AT_106_shrapnel2:	dc.b 1
		dc.b 0xFC, 0, 0,	0x28, 0xFC
		.align 2
