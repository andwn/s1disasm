# ---------------------------------------------------------------------------
# Object 59 - platforms	that move when you stand on them (SLZ)
# ---------------------------------------------------------------------------

Elevator:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Elev_Index(pc,d0.w),d1
		jsr	Elev_Index(pc,d1.w)
		out_of_range	DeleteObject,elev_origX(a0)
		bra.w	DisplaySprite
# ===========================================================================
Elev_Index:	dc.w Elev_Main-Elev_Index
		dc.w Elev_Platform-Elev_Index
		dc.w Elev_Action-Elev_Index
		dc.w Elev_MakeMulti-Elev_Index

.equ elev_origX, 0x32		/* original x-axis position */
.equ elev_origY, 0x30		/* original y-axis position */
.equ elev_dist, 0x3C		/* distance to move (2 bytes) */

Elev_Var1:	dc.b 0x28, 0		/* width, frame number */

Elev_Var2:	dc.b 0x10, 1		/* distance to move, action type */
		dc.b 0x20, 1
		dc.b 0x34, 1
		dc.b 0x10, 3
		dc.b 0x20, 3
		dc.b 0x34, 3
		dc.b 0x14, 1
		dc.b 0x24, 1
		dc.b 0x2C, 1
		dc.b 0x14, 3
		dc.b 0x24, 3
		dc.b 0x2C, 3
		dc.b 0x20, 5
		dc.b 0x20, 7
		dc.b 0x30, 9
# ===========================================================================

Elev_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		bpl.s	1f		/* branch for types 00-7F */
		addq.b	#4,obRoutine(a0) /* goto Elev_MakeMulti next */
		andi.w	#0x7F,d0
		mulu.w	#6,d0
		move.w	d0,elev_dist(a0)
		move.w	d0,0x3E(a0)
		addq.l	#4,sp
		rts	
# ===========================================================================

	1:
		lsr.w	#3,d0
		andi.w	#0x1E,d0
		lea	Elev_Var1(pc,d0.w),a2
		move.b	(a2)+,obActWid(a0) /* set width */
		move.b	(a2)+,obFrame(a0) /* set frame */
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		andi.w	#0x1E,d0
		lea	Elev_Var2(pc,d0.w),a2
		move.b	(a2)+,d0
		lsl.w	#2,d0
		move.w	d0,elev_dist(a0)	/* set distance to move */
		move.b	(a2)+,obSubtype(a0)	/* set type */
		move.l	#Map_Elev,obMap(a0)
		move.w	#0x4000,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.w	obX(a0),elev_origX(a0)
		move.w	obY(a0),elev_origY(a0)

Elev_Platform:	/* Routine 2 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(PlatformObject).l
		bra.w	Elev_Types
# ===========================================================================

Elev_Action:	/* Routine 4 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(ExitPlatform).l
		move.w	obX(a0),-(sp)
		bsr.w	Elev_Types
		move.w	(sp)+,d2
		tst.b	0(a0)
		beq.s	1f
		jmp	(MvSonicOnPtfm2).l

	1:
		rts	
# ===========================================================================

Elev_Types:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xF,d0
		add.w	d0,d0
		move.w	elevIndex(pc,d0.w),d1
		jmp	elevIndex(pc,d1.w)
# ===========================================================================
elevIndex:		dc.w 6f-elevIndex, 7f-elevIndex
		dc.w 2f-elevIndex, 7f-elevIndex
		dc.w 3f-elevIndex, 7f-elevIndex
		dc.w 4f-elevIndex, 7f-elevIndex
		dc.w 5f-elevIndex, 9f-elevIndex
# ===========================================================================

6:
		rts	
# ===========================================================================

7:
		cmpi.b	#4,obRoutine(a0) /* check if Sonic is standing on the object */
		bne.s	8f
		addq.b	#1,obSubtype(a0) /* if yes, add 1 to type */

	8:
		rts	
# ===========================================================================

2:
		bsr.w	Elev_Move
		move.w	0x34(a0),d0
		neg.w	d0
		add.w	elev_origY(a0),d0
		move.w	d0,obY(a0)
		rts	
# ===========================================================================

3:
		bsr.w	Elev_Move
		move.w	0x34(a0),d0
		add.w	elev_origY(a0),d0
		move.w	d0,obY(a0)
		rts	
# ===========================================================================

4:
		bsr.w	Elev_Move
		move.w	0x34(a0),d0
		asr.w	#1,d0
		neg.w	d0
		add.w	elev_origY(a0),d0
		move.w	d0,obY(a0)
		move.w	0x34(a0),d0
		add.w	elev_origX(a0),d0
		move.w	d0,obX(a0)
		rts	
# ===========================================================================

5:
		bsr.w	Elev_Move
		move.w	0x34(a0),d0
		asr.w	#1,d0
		add.w	elev_origY(a0),d0
		move.w	d0,obY(a0)
		move.w	0x34(a0),d0
		neg.w	d0
		add.w	elev_origX(a0),d0
		move.w	d0,obX(a0)
		rts	
# ===========================================================================

9:
		bsr.w	Elev_Move
		move.w	0x34(a0),d0
		neg.w	d0
		add.w	elev_origY(a0),d0
		move.w	d0,obY(a0)
		tst.b	obSubtype(a0)
		beq.w	10f
		rts	
# ===========================================================================

	10:
		btst	#3,obStatus(a0)
		beq.s	11f
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)

	11:
		bra.w	DeleteObject

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Elev_Move:
		move.w	0x38(a0),d0
		tst.b	0x3A(a0)
		bne.s	loc_10CC8
		cmpi.w	#0x800,d0
		bcc.s	loc_10CD0
		addi.w	#0x10,d0
		bra.s	loc_10CD0
# ===========================================================================

loc_10CC8:
		tst.w	d0
		beq.s	loc_10CD0
		subi.w	#0x10,d0

loc_10CD0:
		move.w	d0,0x38(a0)
		ext.l	d0
		asl.l	#8,d0
		add.l	0x34(a0),d0
		move.l	d0,0x34(a0)
		swap	d0
		move.w	elev_dist(a0),d2
		cmp.w	d2,d0
		bls.s	loc_10CF0
		move.b	#1,0x3A(a0)

loc_10CF0:
		add.w	d2,d2
		cmp.w	d2,d0
		bne.s	locret_10CFA
		clr.b	obSubtype(a0)

locret_10CFA:
		rts	
# End of function Elev_Move

# ===========================================================================

Elev_MakeMulti:	/* Routine 6 */
		subq.w	#1,elev_dist(a0)
		bne.s	1f
		move.w	0x3E(a0),elev_dist(a0)
		bsr.w	FindFreeObj
		bne.s	1f
		move.b	#id_Elevator,0(a1) /* duplicate the object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	#0xE,obSubtype(a1)

1:
		addq.l	#4,sp
		out_of_range	DeleteObject
		rts	

