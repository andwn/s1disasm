# ---------------------------------------------------------------------------
# Object 69 - spinning platforms and trapdoors (SBZ)
# ---------------------------------------------------------------------------

SpinPlatform:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Spin_Index(pc,d0.w),d1
		jmp	Spin_Index(pc,d1.w)
# ===========================================================================
Spin_Index:	dc.w Spin_Main-Spin_Index
		dc.w Spin_Trapdoor-Spin_Index
		dc.w Spin_Spinner-Spin_Index

.equ spin_timer, 0x30		/* time counter until change */
.equ spin_timelen, 0x32		/* time between changes (general) */
# ===========================================================================

Spin_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Trap,obMap(a0)
		move.w	#0x4492,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#0x80,obActWid(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xF,d0
		mulu.w	#0x3C,d0
		move.w	d0,spin_timelen(a0)
		tst.b	obSubtype(a0)	/* is subtype $8x? */
		bpl.s	Spin_Trapdoor	/* if not, branch */

		addq.b	#2,obRoutine(a0) /* goto Spin_Spinner next */
		move.l	#Map_Spin,obMap(a0)
		move.w	#0x4DF,obGfx(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#2,obAnim(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* get object type */
		move.w	d0,d1
		andi.w	#0xF,d0		/* read only the	2nd digit */
		mulu.w	#6,d0		/* multiply by 6 */
		move.w	d0,spin_timer(a0)
		move.w	d0,spin_timelen(a0) /* set time delay */
		andi.w	#0x70,d1
		addi.w	#0x10,d1
		lsl.w	#2,d1
		subq.w	#1,d1
		move.w	d1,0x36(a0)
		bra.s	Spin_Spinner
# ===========================================================================

Spin_Trapdoor:	/* Routine 2 */
		subq.w	#1,spin_timer(a0) /* decrement timer */
		bpl.s	1f	/* if time remains, branch */

		move.w	spin_timelen(a0),spin_timer(a0)
		bchg	#0,obAnim(a0)
		tst.b	obRender(a0)
		bpl.s	1f
		sfx	sfx_Door,0,0,0	/* play door sound */

	1:
		lea	(Ani_Spin).l,a1
		jsr	(AnimateSprite).l
		tst.b	obFrame(a0)	/* is frame number 0 displayed? */
		bne.s	2f	/* if not, branch */
		move.w	#0x4B,d1
		move.w	#0xC,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		bra.w	RememberState
# ===========================================================================

2:
		btst	#3,obStatus(a0) /* is Sonic standing on the trapdoor? */
		beq.s	3f	/* if not, branch */
		lea	(v_player).w,a1
		bclr	#3,obStatus(a1)
		bclr	#3,obStatus(a0)
		clr.b	obSolid(a0)

	3:
		bra.w	RememberState
# ===========================================================================

Spin_Spinner:	/* Routine 4 */
		move.w	(v_framecount).w,d0
		and.w	0x36(a0),d0
		bne.s	1f
		move.b	#1,0x34(a0)

	1:
		tst.b	0x34(a0)
		beq.s	2f
		subq.w	#1,spin_timer(a0)
		bpl.s	2f
		move.w	spin_timelen(a0),spin_timer(a0)
		clr.b	0x34(a0)
		bchg	#0,obAnim(a0)

	2:
		lea	(Ani_Spin).l,a1
		jsr	(AnimateSprite).l
		tst.b	obFrame(a0)	/* check	if frame number	0 is displayed */
		bne.s	3f	/* if not, branch */
		move.w	#0x1B,d1
		move.w	#7,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		bra.w	RememberState
# ===========================================================================

3:
		btst	#3,obStatus(a0)
		beq.s	4f
		lea	(v_player).w,a1
		bclr	#3,obStatus(a1)
		bclr	#3,obStatus(a0)
		clr.b	obSolid(a0)

	4:
		bra.w	RememberState

