# ---------------------------------------------------------------------------
# Object 4E - advancing	wall of	lava (MZ)
# ---------------------------------------------------------------------------

LavaWall:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	LWall_Index(pc,d0.w),d1
		jmp	LWall_Index(pc,d1.w)
# ===========================================================================
LWall_Index:	dc.w LWall_Main-LWall_Index
		dc.w LWall_Solid-LWall_Index
		dc.w LWall_Action-LWall_Index
		dc.w LWall_Move-LWall_Index
		dc.w LWall_Delete-LWall_Index

.equ lwall_flag, 0x36		/* flag to start wall moving */
# ===========================================================================

LWall_Main:	/* Routine 0 */
		addq.b	#4,obRoutine(a0)
		movea.l	a0,a1
		moveq	#1,d1
		bra.s	1f
# ===========================================================================

	2:
		bsr.w	FindNextFreeObj
		bne.s	3f

1:
		move.b	#id_LavaWall,0(a1)	/* load object */
		move.l	#Map_LWall,obMap(a1)
		move.w	#0x63A8,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#0x50,obActWid(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	#1,obPriority(a1)
		move.b	#0,obAnim(a1)
		move.b	#0x94,obColType(a1)
		move.l	a0,0x3C(a1)

	3:
		dbf d1,2b	/* repeat sequence once */

		addq.b	#6,obRoutine(a1)
		move.b	#4,obFrame(a1)

LWall_Action:	/* Routine 4 */
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	1f
		neg.w	d0

	1:
		cmpi.w	#0xC0,d0		/* is Sonic within $C0 pixels (x-axis)? */
		bcc.s	2f	/* if not, branch */
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		bcc.s	3f
		neg.w	d0

	3:
		cmpi.w	#0x60,d0		/* is Sonic within $60 pixels (y-axis)? */
		bcc.s	2f	/* if not, branch */
		move.b	#1,lwall_flag(a0) /* set object to move */
		bra.s	LWall_Solid
# ===========================================================================

2:
		tst.b	lwall_flag(a0)	/* is object set	to move? */
		beq.s	LWall_Solid	/* if not, branch */
		move.w	#0x180,obVelX(a0) /* set object speed */
		subq.b	#2,0x24(a0)

LWall_Solid:	/* Routine 2 */
		move.w	#0x2B,d1
		move.w	#0x18,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	obX(a0),d4
		move.b	obRoutine(a0),d0
		move.w	d0,-(sp)
		bsr.w	SolidObject
		move.w	(sp)+,d0
		move.b	d0,obRoutine(a0)
		cmpi.w	#0x6A0,obX(a0)	/* has object reached $6A0 on the x-axis? */
		bne.s	1f	/* if not, branch */
		clr.w	obVelX(a0)	/* stop object moving */
		clr.b	lwall_flag(a0)

	1:
		lea	(Ani_LWall).l,a1
		bsr.w	AnimateSprite
		cmpi.b	#4,(v_player+obRoutine).w
		bcc.s	2f
		bsr.w	SpeedToPos

	2:
		bsr.w	DisplaySprite
		tst.b	lwall_flag(a0)	/* is wall already moving? */
		bne.s	3f		/* if yes, branch */
		out_of_range_s	4f

	3:
		rts	
# ===========================================================================

4:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bclr	#7,2(a2,d0.w)
		move.b	#8,obRoutine(a0)
		rts	
# ===========================================================================

LWall_Move:	/* Routine 6 */
		movea.l	0x3C(a0),a1
		cmpi.b	#8,obRoutine(a1)
		beq.s	LWall_Delete
		move.w	obX(a1),obX(a0)	/* move rest of lava wall */
		subi.w	#0x80,obX(a0)
		bra.w	DisplaySprite
# ===========================================================================

LWall_Delete:	/* Routine 8 */
		bra.w	DeleteObject

