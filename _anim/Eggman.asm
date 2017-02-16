# ---------------------------------------------------------------------------
# Animation script - Eggman (bosses)
# ---------------------------------------------------------------------------
Ani_Eggman:	dc.w AT_6_ship-Ani_Eggman
		dc.w AT_6_facenormal1-Ani_Eggman
		dc.w AT_6_facenormal2-Ani_Eggman
		dc.w AT_6_facenormal3-Ani_Eggman
		dc.w AT_6_facelaugh-Ani_Eggman
		dc.w AT_6_facehit-Ani_Eggman
		dc.w AT_6_facepanic-Ani_Eggman
		dc.w AT_06_blank-Ani_Eggman
		dc.w AT_6_flame1-Ani_Eggman
		dc.w AT_6_flame2-Ani_Eggman
		dc.w AT_6_facedefeat-Ani_Eggman
		dc.w AT_6_escapeflame-Ani_Eggman
AT_6_ship:		dc.b 0xF, 0, afEnd
		.align 2
AT_6_facenormal1:	dc.b 5,	1, 2, afEnd
		.align 2
AT_6_facenormal2:	dc.b 3,	1, 2, afEnd
		.align 2
AT_6_facenormal3:	dc.b 1,	1, 2, afEnd
		.align 2
AT_6_facelaugh:	dc.b 4,	3, 4, afEnd
		.align 2
AT_6_facehit:	dc.b 0x1F, 5, 1,	afEnd
		.align 2
AT_6_facepanic:	dc.b 3,	6, 1, afEnd
		.align 2
AT_06_blank:		dc.b 0xF, 0xA, afEnd
		.align 2
AT_6_flame1:	dc.b 3,	8, 9, afEnd
		.align 2
AT_6_flame2:	dc.b 1,	8, 9, afEnd
		.align 2
AT_6_facedefeat:	dc.b 0xF, 7, afEnd
		.align 2
AT_6_escapeflame:	dc.b 2,	9, 8, 0xB, 0xC, 0xB, 0xC, 9, 8, afBack, 2
		.align 2
