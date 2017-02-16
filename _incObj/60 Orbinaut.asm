# ---------------------------------------------------------------------------
# Object 60 - Orbinaut enemy (LZ, SLZ, SBZ)
# ---------------------------------------------------------------------------

Orbinaut:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Orb_Index(pc,d0.w),d1
		jmp	Orb_Index(pc,d1.w)
# ===========================================================================
Orb_Index:	dc.w Orb_Main-Orb_Index
		dc.w Orb_ChkSonic-Orb_Index
		dc.w Orb_Display-Orb_Index
		dc.w Orb_MoveOrb-Orb_Index
		dc.w Orb_ChkDel2-Orb_Index

.equ orb_parent, 0x3C		/* address of parent object */
# ===========================================================================

Orb_Main:	/* Routine 0 */
		move.l	#Map_Orb,obMap(a0)
		move.w	#0x429,obGfx(a0)	/* SBZ specific code */
		cmpi.b	#id_SBZ,(v_zone).w /* check if level is SBZ */
		beq.s	1f
		move.w	#0x2429,obGfx(a0) /* SLZ specific code */

	1:
		cmpi.b	#id_LZ,(v_zone).w /* check if level is LZ */
		bne.s	2f
		move.w	#0x467,obGfx(a0)	/* LZ specific code */

	2:
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0xB,obColType(a0)
		move.b	#0xC,obActWid(a0)
		moveq	#0,d2
		lea	0x37(a0),a2
		movea.l	a2,a3
		addq.w	#1,a2
		moveq	#3,d1

3:
		bsr.w	FindNextFreeObj
		bne.s	4f
		addq.b	#1,(a3)
		move.w	a1,d5
		subi.w	#0xD000,d5
		lsr.w	#6,d5
		andi.w	#0x7F,d5
		move.b	d5,(a2)+
		move.b	0(a0),0(a1)	/* load spiked orb object */
		move.b	#6,obRoutine(a1) /* use Orb_MoveOrb routine */
		move.l	obMap(a0),obMap(a1)
		move.w	obGfx(a0),obGfx(a1)
		ori.b	#4,obRender(a1)
		move.b	#4,obPriority(a1)
		move.b	#8,obActWid(a1)
		move.b	#3,obFrame(a1)
		move.b	#0x98,obColType(a1)
		move.b	d2,obAngle(a1)
		addi.b	#0x40,d2
		move.l	a0,orb_parent(a1)
		dbf d1,3b /* repeat sequence 3 more times */

	4:
		moveq	#1,d0
		btst	#0,obStatus(a0)	/* is orbinaut facing left? */
		beq.s	5f		/* if not, branch */
		neg.w	d0

	5:
		move.b	d0,0x36(a0)
		move.b	obSubtype(a0),obRoutine(a0) /* if type is 02, skip Orb_ChkSonic */
		addq.b	#2,obRoutine(a0)
		move.w	#-0x40,obVelX(a0) /* move orbinaut to the left */
		btst	#0,obStatus(a0)	/* is orbinaut facing left?? */
		beq.s	6f	/* if not, branch */
		neg.w	obVelX(a0)	/* move orbinaut	to the right */

	6:
		rts	
# ===========================================================================

Orb_ChkSonic:	/* Routine 2 */
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0	/* is Sonic to the right of the orbinaut? */
		bcc.s	1f	/* if yes, branch */
		neg.w	d0

	1:
		cmpi.w	#0xA0,d0		/* is Sonic within $A0 pixels of	orbinaut? */
		bcc.s	2f	/* if not, branch */
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0	/* is Sonic above the orbinaut? */
		bcc.s	3f	/* if yes, branch */
		neg.w	d0

	3:
		cmpi.w	#0x50,d0		/* is Sonic within $50 pixels of	orbinaut? */
		bcc.s	2f	/* if not, branch */
		tst.w	(v_debuguse).w	/* is debug mode	on? */
		bne.s	2f	/* if yes, branch */
		move.b	#1,obAnim(a0)	/* use "angry" animation */

2:
		lea	(Ani_Orb).l,a1
		bsr.w	AnimateSprite
		bra.w	Orb_ChkDel
# ===========================================================================

Orb_Display:	/* Routine 4 */
		bsr.w	SpeedToPos

Orb_ChkDel:
		out_of_range	1f
		bra.w	DisplaySprite

1:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	loc_11E34
		bclr	#7,2(a2,d0.w)

loc_11E34:
		lea	0x37(a0),a2
		moveq	#0,d2
		move.b	(a2)+,d2
		subq.w	#1,d2
		bcs.s	Orb_Delete

loc_11E40:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#6,d0
		addi.l	#v_objspace&0xFFFFFF,d0
		movea.l	d0,a1
		bsr.w	DeleteChild
		dbf	d2,loc_11E40

Orb_Delete:
		bra.w	DeleteObject
# ===========================================================================

Orb_MoveOrb:	/* Routine 6 */
		movea.l	orb_parent(a0),a1
		cmpi.b	#id_Orbinaut,0(a1) /* does parent object still exist? */
		bne.w	DeleteObject	/* if not, delete */
		cmpi.b	#2,obFrame(a1)	/* is orbinaut angry? */
		bne.s	1f		/* if not, branch */
		cmpi.b	#0x40,obAngle(a0) /* is spikeorb directly under the orbinaut? */
		bne.s	1f		/* if not, branch */
		addq.b	#2,obRoutine(a0)
		subq.b	#1,0x37(a1)
		bne.s	2f
		addq.b	#2,obRoutine(a1)

	2:
		move.w	#-0x200,obVelX(a0) /* move orb to the left (quickly) */
		btst	#0,obStatus(a1)
		beq.s	3f
		neg.w	obVelX(a0)

	3:
		bra.w	DisplaySprite
# ===========================================================================

1:
		move.b	obAngle(a0),d0
		jsr	(CalcSine).l
		asr.w	#4,d1
		add.w	obX(a1),d1
		move.w	d1,obX(a0)
		asr.w	#4,d0
		add.w	obY(a1),d0
		move.w	d0,obY(a0)
		move.b	0x36(a1),d0
		add.b	d0,obAngle(a0)
		bra.w	DisplaySprite
# ===========================================================================

Orb_ChkDel2:	/* Routine 8 */
		bsr.w	SpeedToPos
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite

