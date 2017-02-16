# ---------------------------------------------------------------------------
# Object 72 - teleporter (SBZ)
# ---------------------------------------------------------------------------

Teleport:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Tele_Index(pc,d0.w),d1
		jsr	Tele_Index(pc,d1.w)
		out_of_range_s	1f
		rts	

	1:
		jmp	(DeleteObject).l
# ===========================================================================
Tele_Index:	dc.w Tele_Main-Tele_Index
		dc.w loc_166C8-Tele_Index
		dc.w loc_1675E-Tele_Index
		dc.w loc_16798-Tele_Index
# ===========================================================================

Tele_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		andi.w	#0x1E,d0
		lea	Tele_Data(pc),a2
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,0x3A(a0)
		move.l	a2,0x3C(a0)
		move.w	(a2)+,0x36(a0)
		move.w	(a2)+,0x38(a0)

loc_166C8:	/* Routine 2 */
		lea	(v_player).w,a1
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		btst	#0,obStatus(a0)
		beq.s	loc_166E0
		addi.w	#0xF,d0

loc_166E0:
		cmpi.w	#0x10,d0
		bcc.s	locret_1675C
		move.w	obY(a1),d1
		sub.w	obY(a0),d1
		addi.w	#0x20,d1
		cmpi.w	#0x40,d1
		bcc.s	locret_1675C
		tst.b	(f_lockmulti).w
		bne.s	locret_1675C
		cmpi.b	#7,obSubtype(a0)
		bne.s	loc_1670E
		cmpi.w	#50,(v_rings).w
		bcs.s	locret_1675C

loc_1670E:
		addq.b	#2,obRoutine(a0)
		move.b	#0x81,(f_lockmulti).w /* lock controls */
		move.b	#id_Roll,obAnim(a1) /* use Sonic's rolling animation */
		move.w	#0x800,obInertia(a1)
		move.w	#0,obVelX(a1)
		move.w	#0,obVelY(a1)
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)
		bset	#1,obStatus(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		clr.b	0x32(a0)
		sfx	sfx_Roll,0,0,0	/* play Sonic rolling sound */

locret_1675C:
		rts	
# ===========================================================================

loc_1675E:	/* Routine 4 */
		lea	(v_player).w,a1
		move.b	0x32(a0),d0
		addq.b	#2,0x32(a0)
		jsr	(CalcSine).l
		asr.w	#5,d0
		move.w	obY(a0),d2
		sub.w	d0,d2
		move.w	d2,obY(a1)
		cmpi.b	#0x80,0x32(a0)
		bne.s	locret_16796
		bsr.w	sub_1681C
		addq.b	#2,obRoutine(a0)
		sfx	sfx_Teleport,0,0,0	/* play teleport sound */

locret_16796:
		rts	
# ===========================================================================

loc_16798:	/* Routine 6 */
		addq.l	#4,sp
		lea	(v_player).w,a1
		subq.b	#1,0x2E(a0)
		bpl.s	loc_167DA
		move.w	0x36(a0),obX(a1)
		move.w	0x38(a0),obY(a1)
		moveq	#0,d1
		move.b	0x3A(a0),d1
		addq.b	#4,d1
		cmp.b	0x3B(a0),d1
		bcs.s	loc_167C2
		moveq	#0,d1
		bra.s	loc_16800
# ===========================================================================

loc_167C2:
		move.b	d1,0x3A(a0)
		movea.l	0x3C(a0),a2
		move.w	(a2,d1.w),0x36(a0)
		move.w	2(a2,d1.w),0x38(a0)
		bra.w	sub_1681C
# ===========================================================================

loc_167DA:
		move.l	obX(a1),d2
		move.l	obY(a1),d3
		move.w	obVelX(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	obVelY(a1),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,obX(a1)
		move.l	d3,obY(a1)
		rts	
# ===========================================================================

loc_16800:
		andi.w	#0x7FF,obY(a1)
		clr.b	obRoutine(a0)
		clr.b	(f_lockmulti).w
		move.w	#0,obVelX(a1)
		move.w	#0x200,obVelY(a1)
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_1681C:
		moveq	#0,d0
		move.w	#0x1000,d2
		move.w	0x36(a0),d0
		sub.w	obX(a1),d0
		bge.s	loc_16830
		neg.w	d0
		neg.w	d2

loc_16830:
		moveq	#0,d1
		move.w	#0x1000,d3
		move.w	0x38(a0),d1
		sub.w	obY(a1),d1
		bge.s	loc_16844
		neg.w	d1
		neg.w	d3

loc_16844:
		cmp.w	d0,d1
		bcs.s	loc_1687A
		moveq	#0,d1
		move.w	0x38(a0),d1
		sub.w	obY(a1),d1
		swap	d1
		divs.w	d3,d1
		moveq	#0,d0
		move.w	0x36(a0),d0
		sub.w	obX(a1),d0
		beq.s	loc_16866
		swap	d0
		divs.w	d1,d0

loc_16866:
		move.w	d0,obVelX(a1)
		move.w	d3,obVelY(a1)
		tst.w	d1
		bpl.s	loc_16874
		neg.w	d1

loc_16874:
		move.w	d1,0x2E(a0)
		rts	
# ===========================================================================

loc_1687A:
		moveq	#0,d0
		move.w	0x36(a0),d0
		sub.w	obX(a1),d0
		swap	d0
		divs.w	d2,d0
		moveq	#0,d1
		move.w	0x38(a0),d1
		sub.w	obY(a1),d1
		beq.s	loc_16898
		swap	d1
		divs.w	d0,d1

loc_16898:
		move.w	d1,obVelY(a1)
		move.w	d2,obVelX(a1)
		tst.w	d0
		bpl.s	loc_168A6
		neg.w	d0

loc_168A6:
		move.w	d0,0x2E(a0)
		rts	
# End of function sub_1681C

# ===========================================================================
Tele_Data:	dc.w td00-Tele_Data, td01-Tele_Data, td02-Tele_Data
		dc.w td03-Tele_Data, td04-Tele_Data, td05-Tele_Data
		dc.w td06-Tele_Data, td07-Tele_Data
td00:	dc.w 4,	0x794, 0x98C
td01:	dc.w 4,	0x94, 0x38C
td02:	dc.w 0x1C, 0x794,	0x2E8
		dc.w 0x7A4, 0x2C0, 0x7D0
		dc.w 0x2AC, 0x858, 0x2AC
		dc.w 0x884, 0x298, 0x894
		dc.w 0x270, 0x894, 0x190
td03:	dc.w 4,	0x894, 0x690
td04:	dc.w 0x1C, 0x1194, 0x470
		dc.w 0x1184, 0x498, 0x1158
		dc.w 0x4AC, 0xFD0, 0x4AC
		dc.w 0xFA4, 0x4C0, 0xF94
		dc.w 0x4E8, 0xF94, 0x590
td05:	dc.w 4,	0x1294, 0x490
td06:	dc.w 0x1C, 0x1594, 0xFFE8
		dc.w 0x1584, 0xFFC0, 0x1560
		dc.w 0xFFAC, 0x14D0, 0xFFAC
		dc.w 0x14A4, 0xFF98, 0x1494
		dc.w 0xFF70, 0x1494, 0xFD90
td07:	dc.w 4,	0x894, 0x90

