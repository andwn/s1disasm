# ---------------------------------------------------------------------------
# Object 61 - blocks (LZ)
# ---------------------------------------------------------------------------

LabyrinthBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	LBlk_Index(pc,d0.w),d1
		jmp	LBlk_Index(pc,d1.w)
# ===========================================================================
LBlk_Index:	dc.w LBlk_Main-LBlk_Index
		dc.w LBlk_Action-LBlk_Index

LBlk_Var:	dc.b 0x10, 0x10		/* width, height */
		dc.b 0x20, 0xC
		dc.b 0x10, 0x10
		dc.b 0x10, 0x10

.equ lblk_height, 0x16		/* block height */
.equ lblk_origX, 0x34		/* original x-axis position */
.equ lblk_origY, 0x30		/* original y-axis position */
.equ lblk_time, 0x36		/* time delay for block movement */
.equ lblk_untouched, 0x38		/* flag block as untouched */
# ===========================================================================

LBlk_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_LBlock,obMap(a0)
		move.w	#0x43E6,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* get block type */
		lsr.w	#3,d0		/* read only the 1st digit */
		andi.w	#0xE,d0
		lea	LBlk_Var(pc,d0.w),a2
		move.b	(a2)+,obActWid(a0) /* set width */
		move.b	(a2),lblk_height(a0) /* set height */
		lsr.w	#1,d0
		move.b	d0,obFrame(a0)
		move.w	obX(a0),lblk_origX(a0)
		move.w	obY(a0),lblk_origY(a0)
		move.b	obSubtype(a0),d0 /* get block type */
		andi.b	#0xF,d0		/* read only the 2nd digit */
		beq.s	LBlk_Action	/* branch if 0 */
		cmpi.b	#7,d0
		beq.s	LBlk_Action	/* branch if 7 */
		move.b	#1,lblk_untouched(a0)

LBlk_Action:	/* Routine 2 */
		move.w	obX(a0),-(sp)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xF,d0
		add.w	d0,d0
		move.w	lBlkIndex(pc,d0.w),d1
		jsr	lBlkIndex(pc,d1.w)
		move.w	(sp)+,d4
		tst.b	obRender(a0)
		bpl.s	2f
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		moveq	#0,d2
		move.b	lblk_height(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		bsr.w	SolidObject
		move.b	d4,0x3F(a0)
		bsr.w	loc_12180

2:
		out_of_range	DeleteObject,lblk_origX(a0)
		bra.w	DisplaySprite
# ===========================================================================
lBlkIndex:	dc.w 6f-lBlkIndex, 7f-lBlkIndex
		dc.w 3f-lBlkIndex, 8f-lBlkIndex
		dc.w 4f-lBlkIndex, 13f-lBlkIndex
		dc.w 5f-lBlkIndex, 15f-lBlkIndex
# ===========================================================================

6:
		rts	
# ===========================================================================

7:
8:
		tst.w	lblk_time(a0)	/* does time remain? */
		bne.s	9f		/* if yes, branch */
		btst	#3,obStatus(a0)	/* is Sonic standing on the object? */
		beq.s	10f	/* if not, branch */
		move.w	#30,lblk_time(a0) /* wait for half second */

	10:
		rts	
# ===========================================================================

	9:
		subq.w	#1,lblk_time(a0)/* decrement waiting time */
		bne.s	10b	/* if time remains, branch */
		addq.b	#1,obSubtype(a0) /* goto @type02 or @type04 */
		clr.b	lblk_untouched(a0) /* flag block as touched */
		rts	
# ===========================================================================

3:
5:
		bsr.w	SpeedToPos
		addq.w	#8,obVelY(a0)	/* make block fall */
		bsr.w	ObjFloorDist
		tst.w	d1		/* has block hit the floor? */
		bpl.w	11f	/* if not, branch */
		addq.w	#1,d1
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)	/* stop when it touches the floor */
		clr.b	obSubtype(a0)	/* set type to 00 (non-moving type) */

	11:
		rts	
# ===========================================================================

4:
		bsr.w	SpeedToPos
		subq.w	#8,obVelY(a0)	/* make block rise */
		bsr.w	ObjHitCeiling
		tst.w	d1		/* has block hit the ceiling? */
		bpl.w	12f	/* if not, branch */
		sub.w	d1,obY(a0)
		clr.w	obVelY(a0)	/* stop when it touches the ceiling */
		clr.b	obSubtype(a0)	/* set type to 00 (non-moving type) */

	12:
		rts	
# ===========================================================================

13:
		cmpi.b	#1,0x3F(a0)	/* is Sonic touching the	block? */
		bne.s	14f	/* if not, branch */
		addq.b	#1,obSubtype(a0) /* goto @type06 */
		clr.b	lblk_untouched(a0)

	14:
		rts	
# ===========================================================================

15:
		move.w	(v_waterpos1).w,d0
		sub.w	obY(a0),d0	/* is block level with water? */
		beq.s	16f		/* if yes, branch */
		bcc.s	17f		/* branch if block is above water */
		cmpi.w	#-2,d0
		bge.s	18f
		moveq	#-2,d0

	18:
		add.w	d0,obY(a0)	/* make the block rise with water level */
		bsr.w	ObjHitCeiling
		tst.w	d1		/* has block hit the ceiling? */
		bpl.w	19f	/* if not, branch */
		sub.w	d1,obY(a0)	/* stop block */

	19:
		rts	
# ===========================================================================

17:
		cmpi.w	#2,d0
		ble.s	20f
		moveq	#2,d0

	20:
		add.w	d0,obY(a0)	/* make the block sink with water level */
		bsr.w	ObjFloorDist
		tst.w	d1
		bpl.w	16f
		addq.w	#1,d1
		add.w	d1,obY(a0)

	16:
		rts	
# ===========================================================================

loc_12180:
		tst.b	lblk_untouched(a0) /* has block been stood on or touched? */
		beq.s	locret_121C0	/* if yes, branch */
		btst	#3,obStatus(a0)	/* is Sonic standing on it now? */
		bne.s	loc_1219A	/* if yes, branch */
		tst.b	0x3E(a0)
		beq.s	locret_121C0
		subq.b	#4,0x3E(a0)
		bra.s	loc_121A6
# ===========================================================================

loc_1219A:
		cmpi.b	#0x40,0x3E(a0)
		beq.s	locret_121C0
		addq.b	#4,0x3E(a0)

loc_121A6:
		move.b	0x3E(a0),d0
		jsr	(CalcSine).l
		move.w	#0x400,d1
		muls.w	d1,d0
		swap	d0
		add.w	lblk_origY(a0),d0
		move.w	d0,obY(a0)

locret_121C0:
		rts	

