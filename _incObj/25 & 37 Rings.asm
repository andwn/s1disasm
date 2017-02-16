# ---------------------------------------------------------------------------
# Object 25 - rings
# ---------------------------------------------------------------------------

Rings:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Ring_Index(pc,d0.w),d1
		jmp	Ring_Index(pc,d1.w)
# ===========================================================================
Ring_Index:
ptr_Ring_Main:		dc.w Ring_Main-Ring_Index
ptr_Ring_Animate:	dc.w Ring_Animate-Ring_Index
ptr_Ring_Collect:	dc.w Ring_Collect-Ring_Index
ptr_Ring_Sparkle:	dc.w Ring_Sparkle-Ring_Index
ptr_Ring_Delete:	dc.w Ring_Delete-Ring_Index

.equ id_Ring_Main, ptr_Ring_Main-Ring_Index	/* 0 */
.equ id_Ring_Animate, ptr_Ring_Animate-Ring_Index	/* 2 */
.equ id_Ring_Collect, ptr_Ring_Collect-Ring_Index	/* 4 */
.equ id_Ring_Sparkle, ptr_Ring_Sparkle-Ring_Index	/* 6 */
.equ id_Ring_Delete, ptr_Ring_Delete-Ring_Index	/* 8 */
# ---------------------------------------------------------------------------
# Distances between rings (format: horizontal, vertical)
# ---------------------------------------------------------------------------
Ring_PosData:	dc.b 0x10, 0		/* horizontal tight */
		dc.b 0x18, 0		/* horizontal normal */
		dc.b 0x20, 0		/* horizontal wide */
		dc.b 0,	0x10		/* vertical tight */
		dc.b 0,	0x18		/* vertical normal */
		dc.b 0,	0x20		/* vertical wide */
		dc.b 0x10, 0x10		/* diagonal */
		dc.b 0x18, 0x18
		dc.b 0x20, 0x20
		dc.b 0xF0, 0x10
		dc.b 0xE8, 0x18
		dc.b 0xE0, 0x20
		dc.b 0x10, 8
		dc.b 0x18, 0x10
		dc.b 0xF0, 8
		dc.b 0xE8, 0x10
# ===========================================================================

Ring_Main:	/* Routine 0 */
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		lea	2(a2,d0.w),a2
		move.b	(a2),d4
		move.b	obSubtype(a0),d1
		move.b	d1,d0
		andi.w	#7,d1
		cmpi.w	#7,d1
		bne.s	loc_9B80
		moveq	#6,d1

	loc_9B80:
		swap	d1
		move.w	#0,d1
		lsr.b	#4,d0
		add.w	d0,d0
		move.b	Ring_PosData(pc,d0.w),d5 /* load ring spacing data */
		ext.w	d5
		move.b	Ring_PosData+1(pc,d0.w),d6
		ext.w	d6
		movea.l	a0,a1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		lsr.b	#1,d4
		bcs.s	loc_9C02
		bclr	#7,(a2)
		bra.s	loc_9BBA
# ===========================================================================

Ring_MakeRings:
		swap	d1
		lsr.b	#1,d4
		bcs.s	loc_9C02
		bclr	#7,(a2)
		bsr.w	FindFreeObj
		bne.s	loc_9C0E

loc_9BBA:
		move.b	#id_Rings,0(a1)	/* load ring object */
		nop /* padding for bindiff */
		addq.b	#2,obRoutine(a1)
		move.w	d2,obX(a1)	/* set x-axis position based on d2 */
		move.w	obX(a0),0x32(a1)
		move.w	d3,obY(a1)	/* set y-axis position based on d3 */
		move.l	#Map_Ring,obMap(a1)
		move.w	#0x27B2,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#2,obPriority(a1)
		move.b	#0x47,obColType(a1)
		move.b	#8,obActWid(a1)
		move.b	obRespawnNo(a0),obRespawnNo(a1)
		move.b	d1,0x34(a1)

loc_9C02:
		addq.w	#1,d1
		add.w	d5,d2		/* add ring spacing value to d2 */
		add.w	d6,d3		/* add ring spacing value to d3 */
		swap	d1
		dbf	d1,Ring_MakeRings /* repeat for	number of rings */

loc_9C0E:
		btst	#0,(a2)
		bne.w	DeleteObject

Ring_Animate:	/* Routine 2 */
		move.b	(v_ani1_frame).w,obFrame(a0) /* set frame */
		bsr.w	DisplaySprite
		out_of_range_s	Ring_Delete,0x32(a0)
		rts	
# ===========================================================================

Ring_Collect:	/* Routine 4 */
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		bsr.w	CollectRing
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		move.b	0x34(a0),d1
		bset	d1,2(a2,d0.w)

Ring_Sparkle:	/* Routine 6 */
		lea	(Ani_Ring).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
# ===========================================================================

Ring_Delete:	/* Routine 8 */
		bra.w	DeleteObject

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


CollectRing:
		addq.w	#1,(v_rings).w	/* add 1 to rings */
		ori.b	#1,(f_ringcount).w /* update the rings counter */
		move.w	#sfx_Ring,d0	/* play ring sound */
		cmpi.w	#100,(v_rings).w /* do you have < 100 rings? */
		bcs.s	1f	/* if yes, branch */
		bset	#1,(v_lifecount).w /* update lives counter */
		beq.s	2f
		cmpi.w	#200,(v_rings).w /* do you have < 200 rings? */
		bcs.s	1f	/* if yes, branch */
		bset	#2,(v_lifecount).w /* update lives counter */
		bne.s	1f

	2:
		addq.b	#1,(v_lives).w	/* add 1 to the number of lives you have */
		addq.b	#1,(f_lifecount).w /* update the lives counter */
		move.w	#bgm_ExtraLife,d0 /* play extra life music */

	1:
		jmp	(PlaySound_Special).l
# End of function CollectRing

# ===========================================================================
# ---------------------------------------------------------------------------
# Object 37 - rings flying out of Sonic	when he's hit
# ---------------------------------------------------------------------------

RingLoss:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	RLoss_Index(pc,d0.w),d1
		jmp	RLoss_Index(pc,d1.w)
# ===========================================================================
RLoss_Index:	dc.w RLoss_Count-RLoss_Index
		dc.w RLoss_Bounce-RLoss_Index
		dc.w RLoss_Collect-RLoss_Index
		dc.w RLoss_Sparkle-RLoss_Index
		dc.w RLoss_Delete-RLoss_Index
# ===========================================================================

RLoss_Count:	/* Routine 0 */
		movea.l	a0,a1
		moveq	#0,d5
		move.w	(v_rings).w,d5	/* check number of rings you have */
		moveq	#32,d0
		cmp.w	d0,d5		/* do you have 32 or more? */
		bcs.s	1f	/* if not, branch */
		move.w	d0,d5		/* if yes, set d5 to 32 */

	1:
		subq.w	#1,d5
		move.w	#0x288,d4
		bra.s	2f
# ===========================================================================

	3:
		bsr.w	FindFreeObj
		bne.w	4f

2:
		move.b	#id_RingLoss,0(a1) /* load bouncing ring object */
		nop /* padding for bindiff */
		addq.b	#2,obRoutine(a1)
		move.b	#8,obHeight(a1)
		move.b	#8,obWidth(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#0x27B2,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#0x47,obColType(a1)
		move.b	#8,obActWid(a1)
		move.b	#-1,(v_ani3_time).w
		tst.w	d4
		bmi.s	5f
		move.w	d4,d0
		bsr.w	CalcSine
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#0x10,d4
		bcc.s	5f
		subi.w	#0x80,d4
		bcc.s	5f
		move.w	#0x288,d4

	5:
		move.w	d2,obVelX(a1)
		move.w	d3,obVelY(a1)
		neg.w	d2
		neg.w	d4
		dbf d5,3b	/* repeat for number of rings (max 31) */

4:
		move.w	#0,(v_rings).w	/* reset number of rings to zero */
		move.b	#0x80,(f_ringcount).w /* update ring counter */
		move.b	#0,(v_lifecount).w
		sfx	sfx_RingLoss,0,0,0	/* play ring loss sound */

RLoss_Bounce:	/* Routine 2 */
		move.b	(v_ani3_frame).w,obFrame(a0)
		bsr.w	SpeedToPos
		addi.w	#0x18,obVelY(a0)
		bmi.s	1f
		move.b	(v_vbla_byte).w,d0
		add.b	d7,d0
		andi.b	#3,d0
		bne.s	1f
		jsr	(ObjFloorDist).l
		tst.w	d1
		bpl.s	1f
		add.w	d1,obY(a0)
		move.w	obVelY(a0),d0
		asr.w	#2,d0
		sub.w	d0,obVelY(a0)
		neg.w	obVelY(a0)

	1:
		tst.b	(v_ani3_time).w
		beq.s	RLoss_Delete
		move.w	(v_limitbtm2).w,d0
		addi.w	#0xE0,d0
		cmp.w	obY(a0),d0	/* has object moved below level boundary? */
		bcs.s	RLoss_Delete	/* if yes, branch */
		bra.w	DisplaySprite
# ===========================================================================

RLoss_Collect:	/* Routine 4 */
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		bsr.w	CollectRing

RLoss_Sparkle:	/* Routine 6 */
		lea	(Ani_Ring).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
# ===========================================================================

RLoss_Delete:	/* Routine 8 */
		bra.w	DeleteObject

