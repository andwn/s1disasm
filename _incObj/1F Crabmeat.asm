# ---------------------------------------------------------------------------
# Object 1F - Crabmeat enemy (GHZ, SYZ)
# ---------------------------------------------------------------------------

Crabmeat:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Crab_Index(pc,d0.w),d1
		jmp	Crab_Index(pc,d1.w)
# ===========================================================================
Crab_Index:
ptr_Crab_Main:		dc.w Crab_Main-Crab_Index
ptr_Crab_Action:	dc.w Crab_Action-Crab_Index
ptr_Crab_Delete:	dc.w Crab_Delete-Crab_Index
ptr_Crab_BallMain:	dc.w Crab_BallMain-Crab_Index
ptr_Crab_BallMove:	dc.w Crab_BallMove-Crab_Index

.equ id_Crab_Main, ptr_Crab_Main-Crab_Index	/* 0 */
.equ id_Crab_Action, ptr_Crab_Action-Crab_Index	/* 2 */
.equ id_Crab_Delete, ptr_Crab_Delete-Crab_Index	/* 4 */
.equ id_Crab_BallMain, ptr_Crab_BallMain-Crab_Index	/* 6 */
.equ id_Crab_BallMove, ptr_Crab_BallMove-Crab_Index	/* 8 */

.equ crab_timedelay, 0x30
.equ crab_mode, 0x32
# ===========================================================================

Crab_Main:	/* Routine 0 */
		move.b	#0x10,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.l	#Map_Crab,obMap(a0)
		move.w	#0x400,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#6,obColType(a0)
		move.b	#0x15,obActWid(a0)
		bsr.w	ObjectFall
		jsr	(ObjFloorDist).l	/* find floor */
		tst.w	d1
		bpl.s	1f
		add.w	d1,obY(a0)
		move.b	d3,obAngle(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)

	1:
		rts	
# ===========================================================================

Crab_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	crabData(pc,d0.w),d1
		jsr	crabData(pc,d1.w)
		lea	(Ani_Crab).l,a1
		bsr.w	AnimateSprite
		bra.w	RememberState
# ===========================================================================
crabData:		dc.w 3f-crabData
		dc.w 2f-crabData
# ===========================================================================

3:
		subq.w	#1,crab_timedelay(a0) /* subtract 1 from time delay */
		bpl.s	4f
		tst.b	obRender(a0)
		bpl.s	5f
		bchg	#1,crab_mode(a0)
		bne.s	6f

	5:
		addq.b	#2,ob2ndRout(a0)
		move.w	#127,crab_timedelay(a0) /* set time delay to approx 2 seconds */
		move.w	#0x80,obVelX(a0)	/* move Crabmeat	to the right */
		bsr.w	Crab_SetAni
		addq.b	#3,d0
		move.b	d0,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	7f
		neg.w	obVelX(a0)	/* change direction */

	4:
	7:
		rts	
# ===========================================================================

6:
		move.w	#59,crab_timedelay(a0)
		move.b	#6,obAnim(a0)	/* use firing animation */
		bsr.w	FindFreeObj
		bne.s	8f
		move.b	#id_Crabmeat,0(a1) /* load left fireball */
		nop /* padding for bindiff */
		move.b	#id_Crab_BallMain,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		subi.w	#0x10,obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#-0x100,obVelX(a1)

	8:
		bsr.w	FindFreeObj
		bne.s	9f
		move.b	#id_Crabmeat,0(a1) /* load right fireball */
		nop /* padding for bindiff */
		move.b	#id_Crab_BallMain,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		addi.w	#0x10,obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#0x100,obVelX(a1)

	9:
		rts	
# ===========================================================================

2:
		subq.w	#1,crab_timedelay(a0)
		bmi.s	loc_966E
		bsr.w	SpeedToPos
		bchg	#0,crab_mode(a0)
		bne.s	loc_9654
		move.w	obX(a0),d3
		addi.w	#0x10,d3
		btst	#0,obStatus(a0)
		beq.s	loc_9640
		subi.w	#0x20,d3

loc_9640:
		jsr	(ObjFloorDist2).l
		cmpi.w	#-8,d1
		blt.s	loc_966E
		cmpi.w	#0xC,d1
		bge.s	loc_966E
		rts	
# ===========================================================================

loc_9654:
		jsr	(ObjFloorDist).l
		add.w	d1,obY(a0)
		move.b	d3,obAngle(a0)
		bsr.w	Crab_SetAni
		addq.b	#3,d0
		move.b	d0,obAnim(a0)
		rts	
# ===========================================================================

loc_966E:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,crab_timedelay(a0)
		move.w	#0,obVelX(a0)
		bsr.w	Crab_SetAni
		move.b	d0,obAnim(a0)
		rts	
# ---------------------------------------------------------------------------
# Subroutine to	set the	correct	animation for a	Crabmeat
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Crab_SetAni:
		moveq	#0,d0
		move.b	obAngle(a0),d3
		bmi.s	loc_96A4
		cmpi.b	#6,d3
		bcs.s	locret_96A2
		moveq	#1,d0
		btst	#0,obStatus(a0)
		bne.s	locret_96A2
		moveq	#2,d0

locret_96A2:
		rts	
# ===========================================================================

loc_96A4:
		cmpi.b	#-6,d3
		bhi.s	locret_96B6
		moveq	#2,d0
		btst	#0,obStatus(a0)
		bne.s	locret_96B6
		moveq	#1,d0

locret_96B6:
		rts	
# End of function Crab_SetAni

# ===========================================================================

Crab_Delete:	/* Routine 4 */
		bsr.w	DeleteObject
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Sub-object - missile that the	Crabmeat throws
# ---------------------------------------------------------------------------

Crab_BallMain:	/* Routine 6 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Crab,obMap(a0)
		move.w	#0x400,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#0x87,obColType(a0)
		move.b	#8,obActWid(a0)
		move.w	#-0x400,obVelY(a0)
		move.b	#7,obAnim(a0)

Crab_BallMove:	/* Routine 8 */
		lea	(Ani_Crab).l,a1
		bsr.w	AnimateSprite
		bsr.w	ObjectFall
		bsr.w	DisplaySprite
		move.w	(v_limitbtm2).w,d0
		addi.w	#0xE0,d0
		cmp.w	obY(a0),d0	/* has object moved below the level boundary? */
		bcs.s	1f		/* if yes, branch */
		rts	

	1:
		bra.w	DeleteObject

