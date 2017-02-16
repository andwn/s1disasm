# ---------------------------------------------------------------------------
# Object 5A - platforms	moving in circles (SLZ)
# ---------------------------------------------------------------------------

CirclingPlatform:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Circ_Index(pc,d0.w),d1
		jsr	Circ_Index(pc,d1.w)
		out_of_range	DeleteObject,circ_origX(a0)
		bra.w	DisplaySprite
# ===========================================================================
Circ_Index:	dc.w Circ_Main-Circ_Index
		dc.w Circ_Platform-Circ_Index
		dc.w Circ_Action-Circ_Index

.equ circ_origX, 0x32		/* original x-axis position */
.equ circ_origY, 0x30		/* original y-axis position */
# ===========================================================================

Circ_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Circ,obMap(a0)
		move.w	#0x4000,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x18,obActWid(a0)
		move.w	obX(a0),circ_origX(a0)
		move.w	obY(a0),circ_origY(a0)

Circ_Platform:	/* Routine 2 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(PlatformObject).l
		bra.w	Circ_Types
# ===========================================================================

Circ_Action:	/* Routine 4 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(ExitPlatform).l
		move.w	obX(a0),-(sp)
		bsr.w	Circ_Types
		move.w	(sp)+,d2
		jmp	(MvSonicOnPtfm2).l
# ===========================================================================

Circ_Types:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xC,d0
		lsr.w	#1,d0
		move.w	circData(pc,d0.w),d1
		jmp	circData(pc,d1.w)
# ===========================================================================
circData:		dc.w 1-1
		dc.w 2-2
# ===========================================================================

3:
		move.b	(v_oscillate+0x22).w,d1 /* get rotating value */
		subi.b	#0x50,d1		/* set radius of circle */
		ext.w	d1
		move.b	(v_oscillate+0x26).w,d2
		subi.b	#0x50,d2
		ext.w	d2
		btst	#0,obSubtype(a0)
		beq.s	4f
		neg.w	d1
		neg.w	d2

	4:
		btst	#1,obSubtype(a0)
		beq.s	5f
		neg.w	d1
		exg	d1,d2

	5:
		add.w	circ_origX(a0),d1
		move.w	d1,obX(a0)
		add.w	circ_origY(a0),d2
		move.w	d2,obY(a0)
		rts	
# ===========================================================================

2:
		move.b	(v_oscillate+0x22).w,d1
		subi.b	#0x50,d1
		ext.w	d1
		move.b	(v_oscillate+0x26).w,d2
		subi.b	#0x50,d2
		ext.w	d2
		btst	#0,obSubtype(a0)
		beq.s	6f
		neg.w	d1
		neg.w	d2

	6:
		btst	#1,obSubtype(a0)
		beq.s	7f
		neg.w	d1
		exg	d1,d2

	7:
		neg.w	d1
		add.w	circ_origX(a0),d1
		move.w	d1,obX(a0)
		add.w	circ_origY(a0),d2
		move.w	d2,obY(a0)
		rts	

