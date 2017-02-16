# ---------------------------------------------------------------------------
# Object 40 - Moto Bug enemy (GHZ)
# ---------------------------------------------------------------------------

MotoBug:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Moto_Index(pc,d0.w),d1
		jmp	Moto_Index(pc,d1.w)
# ===========================================================================
Moto_Index:	dc.w Moto_Main-Moto_Index
		dc.w Moto_Action-Moto_Index
		dc.w Moto_Animate-Moto_Index
		dc.w Moto_Delete-Moto_Index
# ===========================================================================

Moto_Main:	/* Routine 0 */
		move.l	#Map_Moto,obMap(a0)
		move.w	#0x4F0,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x14,obActWid(a0)
		tst.b	obAnim(a0)	/* is object a smoke trail? */
		bne.s	1f		/* if yes, branch */
		move.b	#0xE,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.b	#0xC,obColType(a0)
		bsr.w	ObjectFall
		jsr	(ObjFloorDist).l
		tst.w	d1
		bpl.s	2f
		add.w	d1,obY(a0)	/* match	object's position with the floor */
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0) /* goto Moto_Action next */
		bchg	#0,obStatus(a0)

	2:
		rts	
# ===========================================================================

1:
		addq.b	#4,obRoutine(a0) /* goto Moto_Animate next */
		bra.w	Moto_Animate
# ===========================================================================

Moto_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Moto_ActIndex(pc,d0.w),d1
		jsr	Moto_ActIndex(pc,d1.w)
		lea	(Ani_Moto).l,a1
		bsr.w	AnimateSprite

		.include	"_incObj/sub RememberState.asm" /* Moto_Action terminates in this file */

# ===========================================================================
Moto_ActIndex:	dc.w Moto_ActIndex_move-Moto_ActIndex
		dc.w Moto_ActIndex_findFloor-Moto_ActIndex

.equ Moto_ActIndex_time, 0x30
.equ Moto_ActIndex_smokedelay, 0x33
# ===========================================================================

Moto_ActIndex_move:
		subq.w	#1,Moto_ActIndex_time(a0)	/* subtract 1 from pause	time */
		bpl.s	5f		/* if time remains, branch */
		addq.b	#2,ob2ndRout(a0)
		move.w	#-0x100,obVelX(a0) /* move object to the left */
		move.b	#1,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	5f
		neg.w	obVelX(a0)	/* change direction */

	5:
		rts	
# ===========================================================================

Moto_ActIndex_findFloor:
		bsr.w	SpeedToPos
		jsr	(ObjFloorDist).l
		cmpi.w	#-8,d1
		blt.s	6f
		cmpi.w	#0xC,d1
		bge.s	6f
		add.w	d1,obY(a0)	/* match	object's position with the floor */
		subq.b	#1,Moto_ActIndex_smokedelay(a0)
		bpl.s	7f
		move.b	#0xF,Moto_ActIndex_smokedelay(a0)
		bsr.w	FindFreeObj
		bne.s	7f
		move.b	#id_MotoBug,0(a1) /* load exhaust smoke object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#2,obAnim(a1)

	7:
		rts	

6:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,Moto_ActIndex_time(a0)	/* set pause time to 1 second */
		move.w	#0,obVelX(a0)	/* stop the object moving */
		move.b	#0,obAnim(a0)
		rts	
# ===========================================================================

Moto_Animate:	/* Routine 4 */
		lea	(Ani_Moto).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
# ===========================================================================

Moto_Delete:	/* Routine 6 */
		bra.w	DeleteObject
