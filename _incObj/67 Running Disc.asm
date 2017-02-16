# ---------------------------------------------------------------------------
# Object 67 - disc that	you run	around (SBZ)
# ---------------------------------------------------------------------------

RunningDisc:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Disc_Index(pc,d0.w),d1
		jmp	Disc_Index(pc,d1.w)
# ===========================================================================
Disc_Index:	dc.w Disc_Main-Disc_Index
		dc.w Disc_Action-Disc_Index

.equ disc_origX, 0x32		/* original x-axis position */
.equ disc_origY, 0x30		/* original y-axis position */
# ===========================================================================

Disc_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Disc,obMap(a0)
		move.w	#0xC344,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	obX(a0),disc_origX(a0)
		move.w	obY(a0),disc_origY(a0)
		move.b	#0x18,0x34(a0)
		move.b	#0x48,0x38(a0)
		move.b	obSubtype(a0),d1 /* get object type */
		andi.b	#0xF,d1		/* read only the	2nd digit */
		beq.s	1f	/* branch if 0 */
		move.b	#0x10,0x34(a0)
		move.b	#0x38,0x38(a0)

	1:
		move.b	obSubtype(a0),d1 /* get object type */
		andi.b	#0xF0,d1		/* read only the	1st digit */
		ext.w	d1
		asl.w	#3,d1
		move.w	d1,0x36(a0)
		move.b	obStatus(a0),d0
		ror.b	#2,d0
		andi.b	#0xC0,d0
		move.b	d0,obAngle(a0)

Disc_Action:	/* Routine 2 */
		bsr.w	Disc_MoveSonic
		bsr.w	Disc_MoveSpot
		bra.w	Disc_ChkDel
# ===========================================================================

Disc_MoveSonic:
		moveq	#0,d2
		move.b	0x38(a0),d2
		move.w	d2,d3
		add.w	d3,d3
		lea	(v_player).w,a1
		move.w	obX(a1),d0
		sub.w	disc_origX(a0),d0
		add.w	d2,d0
		cmp.w	d3,d0
		bcc.s	loc_155A8
		move.w	obY(a1),d1
		sub.w	disc_origY(a0),d1
		add.w	d2,d1
		cmp.w	d3,d1
		bcc.s	loc_155A8
		btst	#1,obStatus(a1)
		beq.s	loc_155B8
		clr.b	0x3A(a0)
		rts	
# ===========================================================================

loc_155A8:
		tst.b	0x3A(a0)
		beq.s	locret_155B6
		clr.b	0x38(a1)
		clr.b	0x3A(a0)

locret_155B6:
		rts	
# ===========================================================================

loc_155B8:
		tst.b	0x3A(a0)
		bne.s	loc_155E2
		move.b	#1,0x3A(a0)
		btst	#2,obStatus(a1)
		bne.s	loc_155D0
		clr.b	obAnim(a1)

loc_155D0:
		bclr	#5,obStatus(a1)
		move.b	#1,obNextAni(a1)
		move.b	#1,0x38(a1)

loc_155E2:
		move.w	obInertia(a1),d0
		tst.w	0x36(a0)
		bpl.s	loc_15608
		cmpi.w	#-0x400,d0
		ble.s	loc_155FA
		move.w	#-0x400,obInertia(a1)
		rts	
# ===========================================================================

loc_155FA:
		cmpi.w	#-0xF00,d0
		bge.s	locret_15606
		move.w	#-0xF00,obInertia(a1)

locret_15606:
		rts	
# ===========================================================================

loc_15608:
		cmpi.w	#0x400,d0
		bge.s	loc_15616
		move.w	#0x400,obInertia(a1)
		rts	
# ===========================================================================

loc_15616:
		cmpi.w	#0xF00,d0
		ble.s	locret_15622
		move.w	#0xF00,obInertia(a1)

locret_15622:
		rts	
# ===========================================================================

Disc_MoveSpot:
		move.w	0x36(a0),d0
		add.w	d0,obAngle(a0)
		move.b	obAngle(a0),d0
		jsr	(CalcSine).l
		move.w	disc_origY(a0),d2
		move.w	disc_origX(a0),d3
		moveq	#0,d4
		move.b	0x34(a0),d4
		lsl.w	#8,d4
		move.l	d4,d5
		muls.w	d0,d4
		swap	d4
		muls.w	d1,d5
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d4,obY(a0)
		move.w	d5,obX(a0)
		rts	
# ===========================================================================

Disc_ChkDel:
		out_of_range_s	1f,disc_origX(a0)
		jmp	(DisplaySprite).l

	1:
		jmp	(DeleteObject).l

