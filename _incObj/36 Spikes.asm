# ---------------------------------------------------------------------------
# Object 36 - spikes
# ---------------------------------------------------------------------------

Spikes:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Spik_Index(pc,d0.w),d1
		jmp	Spik_Index(pc,d1.w)
# ===========================================================================
Spik_Index:	dc.w Spik_Main-Spik_Index
		dc.w Spik_Solid-Spik_Index

.equ spik_origX, 0x30		/* start X position */
.equ spik_origY, 0x32		/* start Y position */

Spik_Var:	dc.b 0,	0x14		/* frame	number,	object width */
		dc.b 1,	0x10
		dc.b 2,	4
		dc.b 3,	0x1C
		dc.b 4,	0x40
		dc.b 5,	0x10
# ===========================================================================

Spik_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Spike,obMap(a0)
		move.w	#0x51B,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),d0
		andi.b	#0xF,obSubtype(a0)
		andi.w	#0xF0,d0
		lea	(Spik_Var).l,a1
		lsr.w	#3,d0
		adda.w	d0,a1
		move.b	(a1)+,obFrame(a0)
		move.b	(a1)+,obActWid(a0)
		move.w	obX(a0),spik_origX(a0)
		move.w	obY(a0),spik_origY(a0)

Spik_Solid:	/* Routine 2 */
		bsr.w	Spik_Type0x	/* make the object move */
		move.w	#4,d2
		cmpi.b	#5,obFrame(a0)	/* is object type $5x ? */
		beq.s	Spik_SideWays	/* if yes, branch */
		cmpi.b	#1,obFrame(a0)	/* is object type $1x ? */
		bne.s	Spik_Upright	/* if not, branch */
		move.w	#0x14,d2

# Spikes types $1x and $5x face	sideways

Spik_SideWays:
		move.w	#0x1B,d1
		move.w	d2,d3
		addq.w	#1,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#3,obStatus(a0)
		bne.s	Spik_Display
		cmpi.w	#1,d4
		beq.s	Spik_Hurt
		bra.s	Spik_Display
# ===========================================================================

# Spikes types $0x, $2x, $3x and $4x face up or	down

Spik_Upright:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		move.w	#0x10,d2
		move.w	#0x11,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#3,obStatus(a0)
		bne.s	Spik_Hurt
		tst.w	d4
		bpl.s	Spik_Display

Spik_Hurt:
		tst.b	(v_invinc).w	/* is Sonic invincible? */
		bne.s	Spik_Display	/* if yes, branch */
		move.l	a0,-(sp)
		movea.l	a0,a2
		lea	(v_player).w,a0
		cmpi.b	#4,obRoutine(a0)
		bcc.s	loc_CF20
		move.l	obY(a0),d3
		move.w	obVelY(a0),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,obY(a0)
		jsr	(HurtSonic).l

loc_CF20:
		movea.l	(sp)+,a0

Spik_Display:
		bsr.w	DisplaySprite
		out_of_range	DeleteObject,spik_origX(a0)
		rts	
# ===========================================================================

Spik_Type0x:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		move.w	Spik_TypeIndex(pc,d0.w),d1
		jmp	Spik_TypeIndex(pc,d1.w)
# ===========================================================================
Spik_TypeIndex:	dc.w Spik_Type00-Spik_TypeIndex
		dc.w Spik_Type01-Spik_TypeIndex
		dc.w Spik_Type02-Spik_TypeIndex
# ===========================================================================

Spik_Type00:
		rts			/* don't move the object */
# ===========================================================================

Spik_Type01:
		bsr.w	Spik_Wait
		moveq	#0,d0
		move.b	0x34(a0),d0
		add.w	spik_origY(a0),d0
		move.w	d0,obY(a0)	/* move the object vertically */
		rts	
# ===========================================================================

Spik_Type02:
		bsr.w	Spik_Wait
		moveq	#0,d0
		move.b	0x34(a0),d0
		add.w	spik_origX(a0),d0
		move.w	d0,obX(a0)	/* move the object horizontally */
		rts	
# ===========================================================================

Spik_Wait:
		tst.w	0x38(a0)		/* is time delay	= zero? */
		beq.s	loc_CFA4	/* if yes, branch */
		subq.w	#1,0x38(a0)	/* subtract 1 from time delay */
		bne.s	locret_CFE6
		tst.b	obRender(a0)
		bpl.s	locret_CFE6
		sfx	sfx_SpikesMove,0,0,0	/* play "spikes moving" sound */
		bra.s	locret_CFE6
# ===========================================================================

loc_CFA4:
		tst.w	0x36(a0)
		beq.s	loc_CFC6
		subi.w	#0x800,0x34(a0)
		bcc.s	locret_CFE6
		move.w	#0,0x34(a0)
		move.w	#0,0x36(a0)
		move.w	#60,0x38(a0)	/* set time delay to 1 second */
		bra.s	locret_CFE6
# ===========================================================================

loc_CFC6:
		addi.w	#0x800,0x34(a0)
		cmpi.w	#0x2000,0x34(a0)
		bcs.s	locret_CFE6
		move.w	#0x2000,0x34(a0)
		move.w	#1,0x36(a0)
		move.w	#60,0x38(a0)	/* set time delay to 1 second */

locret_CFE6:
		rts	

