# ---------------------------------------------------------------------------
# Object 70 - large girder block (SBZ)
# ---------------------------------------------------------------------------

Girder:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Gird_Index(pc,d0.w),d1
		jmp	Gird_Index(pc,d1.w)
# ===========================================================================
Gird_Index:	dc.w Gird_Main-Gird_Index
		dc.w Gird_Action-Gird_Index

.equ gird_height, 0x16
.equ gird_origX, 0x32		/* original x-axis position */
.equ gird_origY, 0x30		/* original y-axis position */
.equ gird_time, 0x34		/* duration for movement in a direction */
.equ gird_set, 0x38		/* which movement settings to use (0/8/16/24) */
.equ gird_delay, 0x3A		/* delay for movement */
# ===========================================================================

Gird_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Gird,obMap(a0)
		move.w	#0x42F0,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#0x60,obActWid(a0)
		move.b	#0x18,gird_height(a0)
		move.w	obX(a0),gird_origX(a0)
		move.w	obY(a0),gird_origY(a0)
		bsr.w	Gird_ChgMove

Gird_Action:	/* Routine 2 */
		move.w	obX(a0),-(sp)
		tst.w	gird_delay(a0)
		beq.s	1f
		subq.w	#1,gird_delay(a0)
		bne.s	2f

	1:
		jsr	(SpeedToPos).l
		subq.w	#1,gird_time(a0) /* decrement movement duration */
		bne.s	2f		/* if time remains, branch */
		bsr.w	Gird_ChgMove	/* if time is zero, branch */

	2:
		move.w	(sp)+,d4
		tst.b	obRender(a0)
		bpl.s	3f
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		moveq	#0,d2
		move.b	gird_height(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		bsr.w	SolidObject

	3:
		out_of_range_s	4f,gird_origX(a0)
		jmp	(DisplaySprite).l

	4:
		jmp	(DeleteObject).l
# ===========================================================================

Gird_ChgMove:
		move.b	gird_set(a0),d0
		andi.w	#0x18,d0
		lea	(gridSpd).l,a1
		lea	(a1,d0.w),a1
		move.w	(a1)+,obVelX(a0)
		move.w	(a1)+,obVelY(a0)
		move.w	(a1)+,gird_time(a0)
		addq.b	#8,gird_set(a0)	/* use next settings */
		move.w	#7,gird_delay(a0)
		rts	
# ===========================================================================
gridSpd:	/*   x-speed, y-speed, duration */
		dc.w   0x100,	 0,   0x60,     0 /* right */
		dc.w	  0,  0x100,   0x30,     0 /* down */
		dc.w  -0x100,  -0x40,   0x60,     0 /* up/left */
		dc.w	  0, -0x100,   0x18,     0 /* up */

