# ---------------------------------------------------------------------------
# Object 6A - ground saws and pizza cutters (SBZ)
# ---------------------------------------------------------------------------

Saws:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Saw_Index(pc,d0.w),d1
		jmp	Saw_Index(pc,d1.w)
# ===========================================================================
Saw_Index:	dc.w Saw_Main-Saw_Index
		dc.w Saw_Action-Saw_Index

.equ saw_origX, 0x3A		/* original x-axis position */
.equ saw_origY, 0x38		/* original y-axis position */
.equ saw_here, 0x3D		/* flag set when the ground saw appears */
# ===========================================================================

Saw_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Saw,obMap(a0)
		move.w	#0x43B5,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x20,obActWid(a0)
		move.w	obX(a0),saw_origX(a0)
		move.w	obY(a0),saw_origY(a0)
		cmpi.b	#3,obSubtype(a0) /* is object a ground saw? */
		bcc.s	Saw_Action	/* if yes, branch */
		move.b	#0xA2,obColType(a0)

Saw_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#7,d0
		add.w	d0,d0
		move.w	sawIndex(pc,d0.w),d1
		jsr	sawIndex(pc,d1.w)
		out_of_range_s	2f,saw_origX(a0)
		jmp	(DisplaySprite).l

	2:
		jmp	(DeleteObject).l
# ===========================================================================
sawIndex:		dc.w 4f-sawIndex, 5f-sawIndex, 9f-sawIndex /* pizza cutters */
		dc.w 3f-sawIndex, 17f-sawIndex /* ground saws */
# ===========================================================================

4:
		rts			/* doesn't move */
# ===========================================================================

5:
		move.w	#0x60,d1
		moveq	#0,d0
		move.b	(v_oscillate+0xE).w,d0
		btst	#0,obStatus(a0)
		beq.s	6f
		neg.w	d0
		add.w	d1,d0

	6:
		move.w	saw_origX(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)	/* move saw sideways */

		subq.b	#1,obTimeFrame(a0)
		bpl.s	7f
		move.b	#2,obTimeFrame(a0) /* time between frame changes */
		bchg	#0,obFrame(a0)	/* change frame */

	7:
		tst.b	obRender(a0)
		bpl.s	8f
		move.w	(v_framecount).w,d0
		andi.w	#0xF,d0
		bne.s	8f
		sfx	sfx_Saw,0,0,0		/* play saw sound */

	8:
		rts	
# ===========================================================================

9:
		move.w	#0x30,d1
		moveq	#0,d0
		move.b	(v_oscillate+6).w,d0
		btst	#0,obStatus(a0)
		beq.s	10f
		neg.w	d0
		addi.w	#0x80,d0

	10:
		move.w	saw_origY(a0),d1
		sub.w	d0,d1
		move.w	d1,obY(a0)	/* move saw vertically */
		subq.b	#1,obTimeFrame(a0)
		bpl.s	11f
		move.b	#2,obTimeFrame(a0)
		bchg	#0,obFrame(a0)

	11:
		tst.b	obRender(a0)
		bpl.s	12f
		move.b	(v_oscillate+6).w,d0
		cmpi.b	#0x18,d0
		bne.s	12f
		sfx	sfx_Saw,0,0,0		/* play saw sound */

	12:
		rts	
# ===========================================================================

3:
		tst.b	saw_here(a0)	/* has the saw appeared already? */
		bne.s	13f		/* if yes, branch */

		move.w	(v_player+obX).w,d0
		subi.w	#0xC0,d0
		bcs.s	14f
		sub.w	obX(a0),d0
		bcs.s	14f
		move.w	(v_player+obY).w,d0
		subi.w	#0x80,d0
		cmp.w	obY(a0),d0
		bcc.s	15f
		addi.w	#0x100,d0
		cmp.w	obY(a0),d0
		bcs.s	15f
		move.b	#1,saw_here(a0)
		move.w	#0x600,obVelX(a0) /* move object to the right */
		move.b	#0xA2,obColType(a0)
		move.b	#2,obFrame(a0)
		sfx	sfx_Saw,0,0,0		/* play saw sound */

	14:
		addq.l	#4,sp

	15:
		rts	
# ===========================================================================

13:
		jsr	(SpeedToPos).l
		move.w	obX(a0),saw_origX(a0)
		subq.b	#1,obTimeFrame(a0)
		bpl.s	16f
		move.b	#2,obTimeFrame(a0)
		bchg	#0,obFrame(a0)

	16:
		rts	
# ===========================================================================

17:
		tst.b	saw_here(a0)
		bne.s	18f
		move.w	(v_player+obX).w,d0
		addi.w	#0xE0,d0
		sub.w	obX(a0),d0
		bcc.s	19f
		move.w	(v_player+obY).w,d0
		subi.w	#0x80,d0
		cmp.w	obY(a0),d0
		bcc.s	20f
		addi.w	#0x100,d0
		cmp.w	obY(a0),d0
		bcs.s	20f
		move.b	#1,saw_here(a0)
		move.w	#-0x600,obVelX(a0) /* move object to the left */
		move.b	#0xA2,obColType(a0)
		move.b	#2,obFrame(a0)
		sfx	sfx_Saw,0,0,0		/* play saw sound */

	19:
		addq.l	#4,sp

	20:
		rts	
# ===========================================================================

18:
		jsr	(SpeedToPos).l
		move.w	obX(a0),saw_origX(a0)
		subq.b	#1,obTimeFrame(a0)
		bpl.s	21f
		move.b	#2,obTimeFrame(a0)
		bchg	#0,obFrame(a0)

	21:
		rts	

