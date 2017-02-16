# ---------------------------------------------------------------------------
# Object 65 - waterfalls (LZ)
# ---------------------------------------------------------------------------

Waterfall:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	WFall_Index(pc,d0.w),d1
		jmp	WFall_Index(pc,d1.w)
# ===========================================================================
WFall_Index:	dc.w WFall_Main-WFall_Index
		dc.w WFall_Animate-WFall_Index
		dc.w WFall_ChkDel-WFall_Index
		dc.w WFall_OnWater-WFall_Index
		dc.w loc_12B36-WFall_Index
# ===========================================================================

WFall_Main:	/* Routine 0 */
		addq.b	#4,obRoutine(a0)
		move.l	#Map_WFall,obMap(a0)
		move.w	#0x4259,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#0x18,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	obSubtype(a0),d0 /* get object type */
		bpl.s	1f	/* branch if $00-$7F */
		bset	#7,obGfx(a0)

	1:
		andi.b	#0xF,d0		/* read only the	2nd digit */
		move.b	d0,obFrame(a0)	/* set frame number */
		cmpi.b	#9,d0		/* is object type $x9 ? */
		bne.s	WFall_ChkDel	/* if not, branch */

		clr.b	obPriority(a0)	/* object is in front of Sonic */
		subq.b	#2,obRoutine(a0) /* goto WFall_Animate next */
		btst	#6,obSubtype(a0) /* is object type $49 ? */
		beq.s	2f		/* if not, branch */

		move.b	#6,obRoutine(a0) /* goto WFall_OnWater next */

	2:
		btst	#5,obSubtype(a0) /* is object type $A9 ? */
		beq.s	WFall_Animate	/* if not, branch */
		move.b	#8,obRoutine(a0) /* goto loc_12B36 next */

WFall_Animate:	/* Routine 2 */
		lea	(Ani_WFall).l,a1
		jsr	(AnimateSprite).l

WFall_ChkDel:	/* Routine 4 */
		bra.w	RememberState
# ===========================================================================

WFall_OnWater:	/* Routine 6 */
		move.w	(v_waterpos1).w,d0
		subi.w	#0x10,d0
		move.w	d0,obY(a0)	/* match	object position	to water height */
		bra.s	WFall_Animate
# ===========================================================================

loc_12B36:	/* Routine 8 */
		bclr	#7,obGfx(a0)
		cmpi.b	#7,(v_lvllayout+0x106).w
		bne.s	1f
		bset	#7,obGfx(a0)

	1:
		bra.s	WFall_Animate

