# ---------------------------------------------------------------------------
# Object 58 - giant spiked balls (SYZ)
# ---------------------------------------------------------------------------

BigSpikeBall:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	BBall_Index(pc,d0.w),d1
		jmp	BBall_Index(pc,d1.w)
# ===========================================================================
BBall_Index:	dc.w BBall_Main-BBall_Index
		dc.w BBall_Move-BBall_Index

.equ bball_origX, 0x3A		/* original x-axis position */
.equ bball_origY, 0x38		/* original y-axis position */
.equ bball_radius, 0x3C		/* radius of circle */
.equ bball_speed, 0x3E		/* speed */
# ===========================================================================

BBall_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_BBall,obMap(a0)
		move.w	#0x396,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x18,obActWid(a0)
		move.w	obX(a0),bball_origX(a0)
		move.w	obY(a0),bball_origY(a0)
		move.b	#0x86,obColType(a0)
		move.b	obSubtype(a0),d1 /* get object type */
		andi.b	#0xF0,d1		/* read only the	1st digit */
		ext.w	d1
		asl.w	#3,d1		/* multiply by 8 */
		move.w	d1,bball_speed(a0) /* set object speed */
		move.b	obStatus(a0),d0
		ror.b	#2,d0
		andi.b	#0xC0,d0
		move.b	d0,obAngle(a0)
		move.b	#0x50,bball_radius(a0) /* set radius of circle motion */

BBall_Move:	/* Routine 2 */
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* get object type */
		andi.w	#7,d0		/* read only the	2nd digit */
		add.w	d0,d0
		move.w	bbIndex(pc,d0.w),d1
		jsr	bbIndex(pc,d1.w)
		out_of_range	DeleteObject,bball_origX(a0)
		bra.w	DisplaySprite
# ===========================================================================
bbIndex:		dc.w 5f-bbIndex
		dc.w 2f-bbIndex
		dc.w 3f-bbIndex
		dc.w 4f-bbIndex
# ===========================================================================

5:
		rts	
# ===========================================================================

2:
		move.w	#0x60,d1
		moveq	#0,d0
		move.b	(v_oscillate+0xE).w,d0
		btst	#0,obStatus(a0)
		beq.s	6f
		neg.w	d0
		add.w	d1,d0

	6:
		move.w	bball_origX(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)	/* move object horizontally */
		rts	
# ===========================================================================

3:
		move.w	#0x60,d1
		moveq	#0,d0
		move.b	(v_oscillate+0xE).w,d0
		btst	#0,obStatus(a0)
		beq.s	7f
		neg.w	d0
		addi.w	#0x80,d0

	7:
		move.w	bball_origY(a0),d1
		sub.w	d0,d1
		move.w	d1,obY(a0)	/* move object vertically */
		rts	
# ===========================================================================

4:
		move.w	bball_speed(a0),d0
		add.w	d0,obAngle(a0)
		move.b	obAngle(a0),d0
		jsr	(CalcSine).l
		move.w	bball_origY(a0),d2
		move.w	bball_origX(a0),d3
		moveq	#0,d4
		move.b	bball_radius(a0),d4
		move.l	d4,d5
		muls.w	d0,d4
		asr.l	#8,d4
		muls.w	d1,d5
		asr.l	#8,d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d4,obY(a0)	/* move object circularly */
		move.w	d5,obX(a0)
		rts	

