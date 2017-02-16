# ---------------------------------------------------------------------------
# Object 47 - pinball bumper (SYZ)
# ---------------------------------------------------------------------------

Bumper:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Bump_Index(pc,d0.w),d1
		jmp	Bump_Index(pc,d1.w)
# ===========================================================================
Bump_Index:	dc.w Bump_Main-Bump_Index
		dc.w Bump_Hit-Bump_Index
# ===========================================================================

Bump_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bump,obMap(a0)
		move.w	#0x380,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	#0xD7,obColType(a0)

Bump_Hit:	/* Routine 2 */
		tst.b	obColProp(a0)	/* has Sonic touched the	bumper? */
		beq.w	1f	/* if not, branch */
		clr.b	obColProp(a0)
		lea	(v_player).w,a1
		move.w	obX(a0),d1
		move.w	obY(a0),d2
		sub.w	obX(a1),d1
		sub.w	obY(a1),d2
		jsr	(CalcAngle).l
		jsr	(CalcSine).l
		muls.w	#-0x700,d1
		asr.l	#8,d1
		move.w	d1,obVelX(a1)	/* bounce Sonic away */
		muls.w	#-0x700,d0
		asr.l	#8,d0
		move.w	d0,obVelY(a1)	/* bounce Sonic away */
		bset	#1,obStatus(a1)
		bclr	#4,obStatus(a1)
		bclr	#5,obStatus(a1)
		clr.b	0x3C(a1)
		move.b	#1,obAnim(a0)	/* use "hit" animation */
		sfx	sfx_Bumper,0,0,0	/* play bumper sound */
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	2f
		cmpi.b	#0x8A,2(a2,d0.w)	/* has bumper been hit 10 times? */
		bcc.s	1f	/* if yes, Sonic	gets no	points */
		addq.b	#1,2(a2,d0.w)

	2:
		moveq	#1,d0
		jsr	(AddPoints).l	/* add 10 to score */
		bsr.w	FindFreeObj
		bne.s	1f
		move.b	#id_Points,0(a1) /* load points object */
		nop /* padding for bindiff */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	#4,obFrame(a1)

	1:
		lea	(Ani_Bump).l,a1
		bsr.w	AnimateSprite
		out_of_range_s	3f
		bra.w	DisplaySprite
# ===========================================================================

3:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	4f
		bclr	#7,2(a2,d0.w)

	4:
		bra.w	DeleteObject

