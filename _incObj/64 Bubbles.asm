# ---------------------------------------------------------------------------
# Object 64 - bubbles (LZ)
# ---------------------------------------------------------------------------

Bubble:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Bub_Index(pc,d0.w),d1
		jmp	Bub_Index(pc,d1.w)
# ===========================================================================
Bub_Index:	dc.w Bub_Main-Bub_Index
		dc.w Bub_Animate-Bub_Index
		dc.w Bub_ChkWater-Bub_Index
		dc.w Bub_Display-Bub_Index
		dc.w Bub_Delete-Bub_Index
		dc.w Bub_BblMaker-Bub_Index

.equ bub_inhalable, 0x2E		/* flag set when bubble is collectable */
.equ bub_origX, 0x30		/* original x-axis position */
.equ bub_time, 0x32		/* time until next bubble spawn */
.equ bub_freq, 0x33		/* frequency of bubble spawn */
# ===========================================================================

Bub_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bub,obMap(a0)
		move.w	#0x8348,obGfx(a0)
		move.b	#0x84,obRender(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	obSubtype(a0),d0 /* get bubble type */
		bpl.s	1f		/* if type is $0-$7F, branch */

		addq.b	#8,obRoutine(a0) /* goto Bub_BblMaker next */
		andi.w	#0x7F,d0		/* read only last 7 bits	(deduct	$80) */
		move.b	d0,bub_time(a0)
		move.b	d0,bub_freq(a0)	/* set bubble frequency */
		move.b	#6,obAnim(a0)
		bra.w	Bub_BblMaker
# ===========================================================================

1:
		move.b	d0,obAnim(a0)
		move.w	obX(a0),bub_origX(a0)
		move.w	#-0x88,obVelY(a0) /* float bubble upwards */
		jsr	(RandomNumber).l
		move.b	d0,obAngle(a0)

Bub_Animate:	/* Routine 2 */
		lea	(Ani_Bub).l,a1
		jsr	(AnimateSprite).l
		cmpi.b	#6,obFrame(a0)	/* is bubble full-size? */
		bne.s	Bub_ChkWater	/* if not, branch */

		move.b	#1,bub_inhalable(a0) /* set "inhalable" flag */

Bub_ChkWater:	/* Routine 4 */
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	/* is bubble underwater? */
		bcs.s	1f		/* if yes, branch */

2:
		move.b	#6,obRoutine(a0) /* goto Bub_Display next */
		addq.b	#3,obAnim(a0)	/* run "bursting" animation */
		bra.w	Bub_Display
# ===========================================================================

1:
		move.b	obAngle(a0),d0
		addq.b	#1,obAngle(a0)
		andi.w	#0x7F,d0
		lea	(Drown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	bub_origX(a0),d0
		move.w	d0,obX(a0)	/* change bubble's x-axis position */
		tst.b	bub_inhalable(a0)
		beq.s	3f
		bsr.w	Bub_ChkSonic	/* has Sonic touched the	bubble? */
		beq.s	3f	/* if not, branch */

		bsr.w	ResumeMusic	/* cancel countdown music */
		sfx	sfx_Bubble,0,0,0	/* play collecting bubble sound */
		lea	(v_player).w,a1
		clr.w	obVelX(a1)
		clr.w	obVelY(a1)
		clr.w	obInertia(a1)	/* stop Sonic */
		move.b	#id_GetAir,obAnim(a1) /* use bubble-collecting animation */
		move.w	#0x23,0x3E(a1)
		move.b	#0,0x3C(a1)
		bclr	#5,obStatus(a1)
		bclr	#4,obStatus(a1)
		btst	#2,obStatus(a1)
		beq.w	2b
		bclr	#2,obStatus(a1)
		move.b	#0x13,obHeight(a1)
		move.b	#9,obWidth(a1)
		subq.w	#5,obY(a1)
		bra.w	2b
# ===========================================================================

3:
		bsr.w	SpeedToPos
		tst.b	obRender(a0)
		bpl.s	4f
		jmp	(DisplaySprite).l

	4:
		jmp	(DeleteObject).l
# ===========================================================================

Bub_Display:	/* Routine 6 */
		lea	(Ani_Bub).l,a1
		jsr	(AnimateSprite).l
		tst.b	obRender(a0)
		bpl.s	1f
		jmp	(DisplaySprite).l

	1:
		jmp	(DeleteObject).l
# ===========================================================================

Bub_Delete:	/* Routine 8 */
		bra.w	DeleteObject
# ===========================================================================

Bub_BblMaker:	/* Routine $A */
		tst.w	0x36(a0)
		bne.s	1f
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	/* is bubble maker underwater? */
		bcc.w	2f		/* if not, branch */
		tst.b	obRender(a0)
		bpl.w	2f
		subq.w	#1,0x38(a0)
		bpl.w	3f
		move.w	#1,0x36(a0)

	4:
		jsr	(RandomNumber).l
		move.w	d0,d1
		andi.w	#7,d0
		cmpi.w	#6,d0		/* random number over 6? */
		bcc.s	4b	/* if yes, branch */

		move.b	d0,0x34(a0)
		andi.w	#0xC,d1
		lea	(Bub_BblTypes).l,a1
		adda.w	d1,a1
		move.l	a1,0x3C(a0)
		subq.b	#1,bub_time(a0)
		bpl.s	5f
		move.b	bub_freq(a0),bub_time(a0)
		bset	#7,0x36(a0)

5:
		bra.s	6f
# ===========================================================================

1:
		subq.w	#1,0x38(a0)
		bpl.w	3f

6:
		jsr	(RandomNumber).l
		andi.w	#0x1F,d0
		move.w	d0,0x38(a0)
		bsr.w	FindFreeObj
		bne.s	7f
		move.b	#id_Bubble,0(a1) /* load bubble object */
		nop /* padding for bindiff */
		move.w	obX(a0),obX(a1)
		jsr	(RandomNumber).l
		andi.w	#0xF,d0
		subq.w	#8,d0
		add.w	d0,obX(a1)
		move.w	obY(a0),obY(a1)
		moveq	#0,d0
		move.b	0x34(a0),d0
		movea.l	0x3C(a0),a2
		move.b	(a2,d0.w),obSubtype(a1)
		btst	#7,0x36(a0)
		beq.s	7f
		jsr	(RandomNumber).l
		andi.w	#3,d0
		bne.s	8f
		bset	#6,0x36(a0)
		bne.s	7f
		move.b	#2,obSubtype(a1)

8:
		tst.b	0x34(a0)
		bne.s	7f
		bset	#6,0x36(a0)
		bne.s	7f
		move.b	#2,obSubtype(a1)

	7:
		subq.b	#1,0x34(a0)
		bpl.s	3f
		jsr	(RandomNumber).l
		andi.w	#0x7F,d0
		addi.w	#0x80,d0
		add.w	d0,0x38(a0)
		clr.w	0x36(a0)

3:
		lea	(Ani_Bub).l,a1
		jsr	(AnimateSprite).l

2:
		out_of_range	DeleteObject
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0
		bcs.w	DisplaySprite
		rts	
# ===========================================================================
# bubble production sequence

# 0 = small bubble, 1 =	large bubble

Bub_BblTypes:	dc.b 0,	1, 0, 0, 0, 0, 1, 0, 0,	0, 0, 1, 0, 1, 0, 0, 1,	0

# ===========================================================================

Bub_ChkSonic:
		tst.b	(f_lockmulti).w
		bmi.s	1f
		lea	(v_player).w,a1
		move.w	obX(a1),d0
		move.w	obX(a0),d1
		subi.w	#0x10,d1
		cmp.w	d0,d1
		bcc.s	1f
		addi.w	#0x20,d1
		cmp.w	d0,d1
		bcs.s	1f
		move.w	obY(a1),d0
		move.w	obY(a0),d1
		cmp.w	d0,d1
		bcc.s	1f
		addi.w	#0x10,d1
		cmp.w	d0,d1
		bcs.s	1f
		moveq	#1,d0
		rts	
# ===========================================================================

1:
		moveq	#0,d0
		rts	

