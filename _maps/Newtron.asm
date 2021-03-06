# ---------------------------------------------------------------------------
# Sprite mappings - Newtron enemy (GHZ)
# ---------------------------------------------------------------------------
Map_Newt:	dc.w M_Newt_Trans-Map_Newt, M_Newt_Norm-Map_Newt
		dc.w M_Newt_Fires-Map_Newt, M_Newt_Drop1-Map_Newt
		dc.w M_Newt_Drop2-Map_Newt, M_Newt_Drop3-Map_Newt
		dc.w M_Newt_Fly1a-Map_Newt, M_Newt_Fly1b-Map_Newt
		dc.w M_Newt_Fly2a-Map_Newt, M_Newt_Fly2b-Map_Newt
		dc.w M_Newt_Blank-Map_Newt
M_Newt_Trans:	dc.b 3
		dc.b 0xEC, 0xD, 0, 0, 0xEC	/* partially visible */
		dc.b 0xF4, 0, 0,	8, 0xC
		dc.b 0xFC, 0xE, 0, 9, 0xF4
M_Newt_Norm:	dc.b 3
		dc.b 0xEC, 6, 0,	0x15, 0xEC /* visible */
		dc.b 0xEC, 9, 0,	0x1B, 0xFC
		dc.b 0xFC, 0xA, 0, 0x21, 0xFC
M_Newt_Fires:	dc.b 3
		dc.b 0xEC, 6, 0,	0x2A, 0xEC /* open mouth, firing */
		dc.b 0xEC, 9, 0,	0x1B, 0xFC
		dc.b 0xFC, 0xA, 0, 0x21, 0xFC
M_Newt_Drop1:	dc.b 4
		dc.b 0xEC, 6, 0,	0x30, 0xEC /* dropping */
		dc.b 0xEC, 9, 0,	0x1B, 0xFC
		dc.b 0xFC, 9, 0,	0x36, 0xFC
		dc.b 0xC, 0, 0, 0x3C, 0xC
M_Newt_Drop2:	dc.b 3
		dc.b 0xF4, 0xD, 0, 0x3D, 0xEC
		dc.b 0xFC, 0, 0,	0x20, 0xC
		dc.b 4,	8, 0, 0x45, 0xFC
M_Newt_Drop3:	dc.b 2
		dc.b 0xF8, 0xD, 0, 0x48, 0xEC
		dc.b 0xF8, 1, 0,	0x50, 0xC
M_Newt_Fly1a:	dc.b 3
		dc.b 0xF8, 0xD, 0, 0x48, 0xEC /* flying */
		dc.b 0xF8, 1, 0,	0x50, 0xC
		dc.b 0xFE, 0, 0,	0x52, 0x14
M_Newt_Fly1b:	dc.b 3
		dc.b 0xF8, 0xD, 0, 0x48, 0xEC
		dc.b 0xF8, 1, 0,	0x50, 0xC
		dc.b 0xFE, 4, 0,	0x53, 0x14
M_Newt_Fly2a:	dc.b 3
		dc.b 0xF8, 0xD, 0, 0x48, 0xEC
		dc.b 0xF8, 1, 0,	0x50, 0xC
		dc.b 0xFE, 0, 0xE0, 0x52, 0x14
M_Newt_Fly2b:	dc.b 3
		dc.b 0xF8, 0xD, 0, 0x48, 0xEC
		dc.b 0xF8, 1, 0,	0x50, 0xC
		dc.b 0xFE, 4, 0xE0, 0x53, 0x14
M_Newt_Blank:	dc.b 0
		.align 2


