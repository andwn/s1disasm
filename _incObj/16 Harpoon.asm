# ---------------------------------------------------------------------------
# Object 16 - harpoon (LZ)
# ---------------------------------------------------------------------------

Harpoon:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Harp_Index(pc,d0.w),d1
		jmp	Harp_Index(pc,d1.w)
# ===========================================================================
Harp_Index:	dc.w Harp_Main-Harp_Index
		dc.w Harp_Move-Harp_Index
		dc.w Harp_Wait-Harp_Index

.equ harp_time, 0x30		/* time between stabbing/retracting */
# ===========================================================================

Harp_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Harp,obMap(a0)
		move.w	#0x3CC,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),obAnim(a0) /* get type (vert/horiz) */
		move.b	#0x14,obActWid(a0)
		move.w	#60,harp_time(a0) /* set time to 1 second */

Harp_Move:	/* Routine 2 */
		lea	(Ani_Harp).l,a1
		bsr.w	AnimateSprite
		moveq	#0,d0
		move.b	obFrame(a0),d0	/* get frame number */
		move.b	1(pc,d0.w),obColType(a0) /* get collision type */
		bra.w	RememberState

	1:
		dc.b 0x9B, 0x9C, 0x9D, 0x9E, 0x9F, 0xA0
		.align 2

Harp_Wait:	/* Routine 4 */
		subq.w	#1,harp_time(a0) /* decrement timer */
		bpl.s	1f		/* branch if time remains */
		move.w	#60,harp_time(a0) /* reset timer */
		subq.b	#2,obRoutine(a0) /* run "Harp_Move" subroutine */
		bchg	#0,obAnim(a0)	/* reverse animation */

	1:
		bra.w	RememberState

