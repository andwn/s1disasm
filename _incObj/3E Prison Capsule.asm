# ---------------------------------------------------------------------------
# Object 3E - prison capsule
# ---------------------------------------------------------------------------

Prison:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Pri_Index(pc,d0.w),d1
		jsr	Pri_Index(pc,d1.w)
		out_of_range_s	1f
		jmp	(DisplaySprite).l

	1:
		jmp	(DeleteObject).l
# ===========================================================================
Pri_Index:	dc.w Pri_Main-Pri_Index
		dc.w Pri_BodyMain-Pri_Index
		dc.w Pri_Switched-Pri_Index
		dc.w Pri_Explosion-Pri_Index
		dc.w Pri_Explosion-Pri_Index
		dc.w Pri_Explosion-Pri_Index
		dc.w Pri_Animals-Pri_Index
		dc.w Pri_EndAct-Pri_Index

.equ pri_origY, 0x30		/* original y-axis position */

Pri_Var:	dc.b 2,	0x20, 4,	0	/* routine, width, priority, frame */
		dc.b 4,	0xC, 5, 1
		dc.b 6,	0x10, 4,	3
		dc.b 8,	0x10, 3,	5
# ===========================================================================

Pri_Main:	/* Routine 0 */
		move.l	#Map_Pri,obMap(a0)
		move.w	#0x49D,obGfx(a0)
		move.b	#4,obRender(a0)
		move.w	obY(a0),pri_origY(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		lsl.w	#2,d0
		lea	Pri_Var(pc,d0.w),a1
		move.b	(a1)+,obRoutine(a0)
		move.b	(a1)+,obActWid(a0)
		move.b	(a1)+,obPriority(a0)
		move.b	(a1)+,obFrame(a0)
		cmpi.w	#8,d0		/* is object type number	02? */
		bne.s	1f		/* if not, branch */

		move.b	#6,obColType(a0)
		move.b	#8,obColProp(a0)

	1:
		rts	
# ===========================================================================

Pri_BodyMain:	/* Routine 2 */
		cmpi.b	#2,(v_bossstatus).w
		beq.s	1f
		move.w	#0x2B,d1
		move.w	#0x18,d2
		move.w	#0x18,d3
		move.w	obX(a0),d4
		jmp	(SolidObject).l
# ===========================================================================

1:
		tst.b	ob2ndRout(a0)	/* has the prison been opened? */
		beq.s	2f		/* if yes, branch */
		clr.b	ob2ndRout(a0)
		bclr	#3,(v_player+obStatus).w
		bset	#1,(v_player+obStatus).w

	2:
		move.b	#2,obFrame(a0)	/* use frame number 2 (destroyed	prison) */
		rts	
# ===========================================================================

Pri_Switched:	/* Routine 4 */
		move.w	#0x17,d1
		move.w	#8,d2
		move.w	#8,d3
		move.w	obX(a0),d4
		jsr	(SolidObject).l
		lea	(Ani_Pri).l,a1
		jsr	(AnimateSprite).l
		move.w	pri_origY(a0),obY(a0)
		tst.b	ob2ndRout(a0)	/* has prison already been opened? */
		beq.s	1f		/* if yes, branch */

		addq.w	#8,obY(a0)
		move.b	#0xA,obRoutine(a0)
		move.w	#60,obTimeFrame(a0) /* set time between animal spawns */
		clr.b	(f_timecount).w	/* stop time counter */
		clr.b	(f_lockscreen).w /* lock screen position */
		move.b	#1,(f_lockctrl).w /* lock controls */
		move.w	#(btnR<<8),(v_jpadhold2).w /* make Sonic run to the right */
		clr.b	ob2ndRout(a0)
		bclr	#3,(v_player+obStatus).w
		bset	#1,(v_player+obStatus).w

	1:
		rts	
# ===========================================================================

Pri_Explosion:	/* Routine 6, 8, $A */
		moveq	#7,d0
		and.b	(v_vbla_byte).w,d0
		bne.s	1f
		jsr	(FindFreeObj).l
		bne.s	1f
		move.b	#id_ExplosionBomb,0(a1) /* load explosion object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		jsr	(RandomNumber).l
		moveq	#0,d1
		move.b	d0,d1
		lsr.b	#2,d1
		subi.w	#0x20,d1
		add.w	d1,obX(a1)
		lsr.w	#8,d0
		lsr.b	#3,d0
		add.w	d0,obY(a1)

	1:
		subq.w	#1,obTimeFrame(a0)
		beq.s	2f
		rts	
# ===========================================================================

2:
		move.b	#2,(v_bossstatus).w
		move.b	#0xC,obRoutine(a0)	/* replace explosions with animals */
		move.b	#6,obFrame(a0)
		move.w	#150,obTimeFrame(a0)
		addi.w	#0x20,obY(a0)
		moveq	#7,d6
		move.w	#0x9A,d5
		moveq	#-0x1C,d4

	3:
		jsr	(FindFreeObj).l
		bne.s	4f
		move.b	#id_Animals,0(a1) /* load animal object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		add.w	d4,obX(a1)
		addq.w	#7,d4
		move.w	d5,0x36(a1)
		subq.w	#8,d5
		dbf d6,3b	/* repeat 7 more	times */

	4:
		rts	
# ===========================================================================

Pri_Animals:	/* Routine $C */
		moveq	#7,d0
		and.b	(v_vbla_byte).w,d0
		bne.s	1f
		jsr	(FindFreeObj).l
		bne.s	1f
		move.b	#id_Animals,0(a1) /* load animal object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		jsr	(RandomNumber).l
		andi.w	#0x1F,d0
		subq.w	#6,d0
		tst.w	d1
		bpl.s	2f
		neg.w	d0

	2:
		add.w	d0,obX(a1)
		move.w	#0xC,0x36(a1)

	1:
		subq.w	#1,obTimeFrame(a0)
		bne.s	3f
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0)

	3:
		rts	
# ===========================================================================

Pri_EndAct:	/* Routine $E */
		moveq	#0x3E,d0
		moveq	#id_Animals,d1
		moveq	#0x40,d2
		lea	(v_objspace+0x40).w,a1 /* load object RAM */

	1:
		cmp.b	(a1),d1		/* is object $28	(animal) loaded? */
		beq.s	2f		/* if yes, branch */
		adda.w	d2,a1		/* next object RAM */
		dbf d0,1b	/* repeat $3E times */

		jsr	(GotThroughAct).l
		jmp	(DeleteObject).l

	2:
		rts	

