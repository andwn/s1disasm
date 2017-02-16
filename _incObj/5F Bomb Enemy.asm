# ---------------------------------------------------------------------------
# Object 5F - walking bomb enemy (SLZ, SBZ)
# ---------------------------------------------------------------------------

Bomb:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Bom_Index(pc,d0.w),d1
		jmp	Bom_Index(pc,d1.w)
# ===========================================================================
Bom_Index:	dc.w Bom_Main-Bom_Index
		dc.w Bom_Action-Bom_Index
		dc.w Bom_Display-Bom_Index
		dc.w Bom_End-Bom_Index

.equ bom_time, 0x30		/* time of fuse */
.equ bom_origY, 0x34		/* original y-axis position */
.equ bom_parent, 0x3C		/* address of parent object */
# ===========================================================================

Bom_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bomb,obMap(a0)
		move.w	#0x400,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#0xC,obActWid(a0)
		move.b	obSubtype(a0),d0
		beq.s	loc_11A3C
		move.b	d0,obRoutine(a0)
		rts	
# ===========================================================================

loc_11A3C:
		move.b	#0x9A,obColType(a0)
		bchg	#0,obStatus(a0)

Bom_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	bomData(pc,d0.w),d1
		jsr	bomData(pc,d1.w)
		lea	(Ani_Bomb).l,a1
		bsr.w	AnimateSprite
		bra.w	RememberState
# ===========================================================================
bomData:		dc.w 4f-bomData
		dc.w 2f-bomData
		dc.w 3f-bomData
# ===========================================================================

4:
		bsr.w	5f
		subq.w	#1,bom_time(a0)	/* subtract 1 from time delay */
		bpl.s	6f		/* if time remains, branch */
		addq.b	#2,ob2ndRout(a0) /* goto @wait */
		move.w	#1535,bom_time(a0) /* set time delay to 25 seconds */
		move.w	#0x10,obVelX(a0)
		move.b	#1,obAnim(a0)	/* use walking animation */
		bchg	#0,obStatus(a0)
		beq.s	6f
		neg.w	obVelX(a0)	/* change direction */

	6:
		rts	
# ===========================================================================

2:
		bsr.w	5f
		subq.w	#1,bom_time(a0)	/* subtract 1 from time delay */
		bmi.s	7f	/* if time expires, branch */
		bsr.w	SpeedToPos
		rts	
# ===========================================================================

	7:
		subq.b	#2,ob2ndRout(a0)
		move.w	#179,bom_time(a0) /* set time delay to 3 seconds */
		clr.w	obVelX(a0)	/* stop walking */
		move.b	#0,obAnim(a0)	/* use waiting animation */
		rts	
# ===========================================================================

3:
		subq.w	#1,bom_time(a0)	/* subtract 1 from time delay */
		bpl.s	8f	/* if time remains, branch */
		move.b	#id_ExplosionBomb,0(a0) /* change bomb into an explosion */
		move.b	#0,obRoutine(a0)

	8:
		rts	
# ===========================================================================

5:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	9f
		neg.w	d0

	9:
		cmpi.w	#0x60,d0		/* is Sonic within $60 pixels? */
		bcc.s	10f	/* if not, branch */
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		bcc.s	11f
		neg.w	d0

	11:
		cmpi.w	#0x60,d0
		bcc.s	10f
		tst.w	(v_debuguse).w
		bne.s	10f

		move.b	#4,ob2ndRout(a0)
		move.w	#143,bom_time(a0) /* set fuse time */
		clr.w	obVelX(a0)
		move.b	#2,obAnim(a0)	/* use activated animation */
		bsr.w	FindNextFreeObj
		bne.s	10f
		move.b	#id_Bomb,0(a1)	/* load fuse object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	obY(a0),bom_origY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#4,obSubtype(a1)
		move.b	#3,obAnim(a1)
		move.w	#0x10,obVelY(a1)
		btst	#1,obStatus(a0)	/* is bomb upside-down? */
		beq.s	12f		/* if not, branch */
		neg.w	obVelY(a1)	/* reverse direction for fuse */

	12:
		move.w	#143,bom_time(a1) /* set fuse time */
		move.l	a0,bom_parent(a1)

10:
		rts	
# ===========================================================================

Bom_Display:	/* Routine 4 */
		bsr.s	loc_11B70
		lea	(Ani_Bomb).l,a1
		bsr.w	AnimateSprite
		bra.w	RememberState
# ===========================================================================

loc_11B70:
		subq.w	#1,bom_time(a0)
		bmi.s	loc_11B7C
		bsr.w	SpeedToPos
		rts	
# ===========================================================================

loc_11B7C:
		clr.w	bom_time(a0)
		clr.b	obRoutine(a0)
		move.w	bom_origY(a0),obY(a0)
		moveq	#3,d1
		movea.l	a0,a1
		lea	(Bom_ShrSpeed).l,a2 /* load shrapnel speed data */
		bra.s	1f
# ===========================================================================

	2:
		bsr.w	FindNextFreeObj
		bne.s	3f

1:
		move.b	#id_Bomb,0(a1)	/* load shrapnel	object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	#6,obSubtype(a1)
		move.b	#4,obAnim(a1)
		move.w	(a2)+,obVelX(a1)
		move.w	(a2)+,obVelY(a1)
		move.b	#0x98,obColType(a1)
		bset	#7,obRender(a1)

	3:
		dbf d1,2b	/* repeat 3 more	times */

		move.b	#6,obRoutine(a0)

Bom_End:	/* Routine 6 */
		bsr.w	SpeedToPos
		addi.w	#0x18,obVelY(a0)
		lea	(Ani_Bomb).l,a1
		bsr.w	AnimateSprite
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite
# ===========================================================================
Bom_ShrSpeed:	dc.w -0x200, -0x300, -0x100, -0x200, 0x200, -0x300, 0x100, -0x200

