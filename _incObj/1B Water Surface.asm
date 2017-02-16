# ---------------------------------------------------------------------------
# Object 1B - water surface (LZ)
# ---------------------------------------------------------------------------

WaterSurface:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Surf_Index(pc,d0.w),d1
		jmp	Surf_Index(pc,d1.w)
# ===========================================================================
Surf_Index:	dc.w Surf_Main-Surf_Index
		dc.w Surf_Action-Surf_Index

.equ surf_origX, 0x30		/* original x-axis position */
.equ surf_freeze, 0x32		/* flag to freeze animation */
# ===========================================================================

Surf_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Surf,obMap(a0)
		move.w	#0xC300,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#0x80,obActWid(a0)
		move.w	obX(a0),surf_origX(a0)

Surf_Action:	/* Routine 2 */
		move.w	(v_screenposx).w,d1
		andi.w	#0xFFE0,d1
		add.w	surf_origX(a0),d1
		btst	#0,(v_framebyte).w
		beq.s	1f		/* branch on even frames */
		addi.w	#0x20,d1

	1:
		move.w	d1,obX(a0)	/* match	obj x-position to screen position */
		move.w	(v_waterpos1).w,d1
		move.w	d1,obY(a0)	/* match	obj y-position to water	height */
		tst.b	surf_freeze(a0)
		bne.s	2f
		btst	#bitStart,(v_jpadpress1).w /* is Start button pressed? */
		beq.s	3f	/* if not, branch */
		addq.b	#3,obFrame(a0)	/* use different	frames */
		move.b	#1,surf_freeze(a0) /* stop animation */
		bra.s	4f
# ===========================================================================

2:
		tst.w	(f_pause).w	/* is the game paused? */
		bne.s	4f	/* if yes, branch */
		move.b	#0,surf_freeze(a0) /* resume animation */
		subq.b	#3,obFrame(a0)	/* use normal frames */

3:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	4f
		move.b	#7,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		cmpi.b	#3,obFrame(a0)
		bcs.s	4f
		move.b	#0,obFrame(a0)

4:
		bra.w	DisplaySprite

