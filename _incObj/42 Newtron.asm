# ---------------------------------------------------------------------------
# Object 42 - Newtron enemy (GHZ)
# ---------------------------------------------------------------------------

Newtron:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Newt_Index(pc,d0.w),d1
		jmp	Newt_Index(pc,d1.w)
# ===========================================================================
Newt_Index:	dc.w Newt_Main-Newt_Index
		dc.w Newt_Action-Newt_Index
		dc.w Newt_Delete-Newt_Index
# ===========================================================================

Newt_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Newt,obMap(a0)
		move.w	#0x49B,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x14,obActWid(a0)
		move.b	#0x10,obHeight(a0)
		move.b	#8,obWidth(a0)

Newt_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	newtState(pc,d0.w),d1
		jsr	newtState(pc,d1.w)
		lea	(Ani_Newt).l,a1
		bsr.w	AnimateSprite
		bra.w	RememberState
# ===========================================================================
newtState:		dc.w 6f-newtState
		dc.w 2f-newtState
		dc.w 3f-newtState
		dc.w 4f-newtState
		dc.w 5f-newtState
# ===========================================================================

6:
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	7f
		neg.w	d0
		bclr	#0,obStatus(a0)

	7:
		cmpi.w	#0x80,d0		/* is Sonic within $80 pixels of	the newtron? */
		bcc.s	8f	/* if not, branch */
		addq.b	#2,ob2ndRout(a0) /* goto @type00 next */
		move.b	#1,obAnim(a0)
		tst.b	obSubtype(a0)	/* check	object type */
		beq.s	9f	/* if type is 00, branch */

		move.w	#0x249B,obGfx(a0)
		move.b	#8,ob2ndRout(a0) /* goto @type01 next */
		move.b	#4,obAnim(a0)	/* use different	animation */

	8:
	9:
		rts	
# ===========================================================================

2:
		cmpi.b	#4,obFrame(a0)	/* has "appearing" animation finished? */
		bcc.s	10f		/* is yes, branch */
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	11f
		bclr	#0,obStatus(a0)

	11:
		rts	
# ===========================================================================

	10:
		cmpi.b	#1,obFrame(a0)
		bne.s	12f
		move.b	#0xC,obColType(a0)

	12:
		bsr.w	ObjectFall
		bsr.w	ObjFloorDist
		tst.w	d1		/* has newtron hit the floor? */
		bpl.s	13f	/* if not, branch */

		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)	/* stop newtron falling */
		addq.b	#2,ob2ndRout(a0)
		move.b	#2,obAnim(a0)
		btst	#5,obGfx(a0)
		beq.s	14f
		addq.b	#1,obAnim(a0)

	14:
		move.b	#0xD,obColType(a0)
		move.w	#0x200,obVelX(a0) /* move newtron horizontally */
		btst	#0,obStatus(a0)
		bne.s	13f
		neg.w	obVelX(a0)

	13:
		rts	
# ===========================================================================

3:
		bsr.w	SpeedToPos
		bsr.w	ObjFloorDist
		cmpi.w	#-8,d1
		blt.s	15f
		cmpi.w	#0xC,d1
		bge.s	15f
		add.w	d1,obY(a0)	/* match	newtron's position with floor */
		rts	
# ===========================================================================

	15:
		addq.b	#2,ob2ndRout(a0) /* goto @speed next */
		rts	
# ===========================================================================

4:
		bsr.w	SpeedToPos
		rts	
# ===========================================================================

5:
		cmpi.b	#1,obFrame(a0)
		bne.s	16f
		move.b	#0xC,obColType(a0)

	16:
		cmpi.b	#2,obFrame(a0)
		bne.s	17f
		tst.b	0x32(a0)
		bne.s	17f
		move.b	#1,0x32(a0)
		bsr.w	FindFreeObj
		bne.s	17f
		move.b	#id_Missile,0(a1) /* load missile object */
		nop /* padding for bindiff */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		subq.w	#8,obY(a1)
		move.w	#0x200,obVelX(a1)
		move.w	#0x14,d0
		btst	#0,obStatus(a0)
		bne.s	18f
		neg.w	d0
		neg.w	obVelX(a1)

	18:
		add.w	d0,obX(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#1,obSubtype(a1)

	17:
		rts	
# ===========================================================================

Newt_Delete:	/* Routine 4 */
		bra.w	DeleteObject

