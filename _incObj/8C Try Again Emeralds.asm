# ---------------------------------------------------------------------------
# Object 8C - chaos emeralds on	the "TRY AGAIN"	screen
# ---------------------------------------------------------------------------

TryChaos:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	TCha_Index(pc,d0.w),d1
		jsr	TCha_Index(pc,d1.w)
		jmp	(DisplaySprite).l
# ===========================================================================
TCha_Index:	dc.w TCha_Main-TCha_Index
		dc.w TCha_Move-TCha_Index
# ===========================================================================

TCha_Main:	/* Routine 0 */
		movea.l	a0,a1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#5,d1
		sub.b	(v_emeralds).w,d1

1:
		move.b	#id_TryChaos,(a1) /* load emerald object */
		addq.b	#2,obRoutine(a1)
		move.l	#Map_ECha,obMap(a1)
		move.w	#0x3C5,obGfx(a1)
		move.b	#0,obRender(a1)
		move.b	#1,obPriority(a1)
		move.w	#0x104,obX(a1)
		move.w	#0x120,0x38(a1)
		move.w	#0xEC,obScreenY(a1)
		move.w	obScreenY(a1),0x3A(a1)
		move.b	#0x1C,0x3C(a1)
		lea	(v_emldlist).w,a3

	2:
		moveq	#0,d0
		move.b	(v_emeralds).w,d0
		subq.w	#1,d0
		bcs.s	3f

	4:
		cmp.b	(a3,d0.w),d2
		bne.s	5f
		addq.b	#1,d2
		bra.s	2b
# ===========================================================================

	5:
		dbf d0,4b

3:
		move.b	d2,obFrame(a1)
		addq.b	#1,obFrame(a1)
		addq.b	#1,d2
		move.b	#0x80,obAngle(a1)
		move.b	d3,obTimeFrame(a1)
		move.b	d3,obDelayAni(a1)
		addi.w	#10,d3
		lea	0x40(a1),a1
		dbf d1,1b	/* repeat 5 times */

TCha_Move:	/* Routine 2 */
		tst.w	0x3E(a0)
		beq.s	locret_5BBA
		tst.b	obTimeFrame(a0)
		beq.s	loc_5B78
		subq.b	#1,obTimeFrame(a0)
		bne.s	loc_5B80

loc_5B78:
		move.w	0x3E(a0),d0
		add.w	d0,obAngle(a0)

loc_5B80:
		move.b	obAngle(a0),d0
		beq.s	loc_5B8C
		cmpi.b	#0x80,d0
		bne.s	loc_5B96

loc_5B8C:
		clr.w	0x3E(a0)
		move.b	obDelayAni(a0),obTimeFrame(a0)

loc_5B96:
		jsr	(CalcSine).l
		moveq	#0,d4
		move.b	0x3C(a0),d4
		muls.w	d4,d1
		asr.l	#8,d1
		muls.w	d4,d0
		asr.l	#8,d0
		add.w	0x38(a0),d1
		add.w	0x3A(a0),d0
		move.w	d1,obX(a0)
		move.w	d0,obScreenY(a0)

locret_5BBA:
		rts	

