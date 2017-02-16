# ---------------------------------------------------------------------------
# Object 55 - Basaran enemy (MZ)
# ---------------------------------------------------------------------------

Basaran:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Bas_Index(pc,d0.w),d1
		jmp	Bas_Index(pc,d1.w)
# ===========================================================================
Bas_Index:	dc.w Bas_Main-Bas_Index
		dc.w Bas_Action-Bas_Index
# ===========================================================================

Bas_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bas,obMap(a0)
		move.w	#0x84B8,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#0xC,obHeight(a0)
		move.b	#2,obPriority(a0)
		move.b	#0xB,obColType(a0)
		move.b	#0x10,obActWid(a0)

Bas_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	basState(pc,d0.w),d1
		jsr	basState(pc,d1.w)
		lea	(Ani_Bas).l,a1
		bsr.w	AnimateSprite
		bra.w	RememberState
# ===========================================================================
basState:		dc.w 5f-basState
		dc.w 2f-basState
		dc.w 3f-basState
		dc.w 4f-basState
# ===========================================================================

5:
		move.w	#0x80,d2
		bsr.w	6f	/* is Sonic < $80 pixels from basaran? */
		bcc.s	7f		/* if not, branch */
		move.w	(v_player+obY).w,d0
		move.w	d0,0x36(a0)
		sub.w	obY(a0),d0
		bcs.s	7f
		cmpi.w	#0x80,d0		/* is Sonic < $80 pixels from basaran? */
		bcc.s	7f		/* if not, branch */
		tst.w	(v_debuguse).w	/* is debug mode	on? */
		bne.s	7f		/* if yes, branch */

		move.b	(v_vbla_byte).w,d0
		add.b	d7,d0
		andi.b	#7,d0
		bne.s	7f
		move.b	#1,obAnim(a0)
		addq.b	#2,ob2ndRout(a0)

	7:
		rts	
# ===========================================================================

2:
		bsr.w	SpeedToPos
		addi.w	#0x18,obVelY(a0)	/* make basaran fall */
		move.w	#0x80,d2
		bsr.w	6f
		move.w	0x36(a0),d0
		sub.w	obY(a0),d0
		bcs.s	8f
		cmpi.w	#0x10,d0		/* is basaran close to Sonic vertically? */
		bcc.s	9f	/* if not, branch */
		move.w	d1,obVelX(a0)	/* make basaran fly horizontally */
		move.w	#0,obVelY(a0)	/* stop basaran falling */
		move.b	#2,obAnim(a0)
		addq.b	#2,ob2ndRout(a0)

	9:
		rts	

	8:
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		rts	
# ===========================================================================

3:
		move.b	(v_vbla_byte).w,d0
		andi.b	#0xF,d0
		bne.s	10f
		sfx	sfx_Basaran,0,0,0	/* play flapping sound every 16th frame */

	10:
		bsr.w	SpeedToPos
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	11f	/* if Sonic is right of basaran, branch */
		neg.w	d0

	11:
		cmpi.w	#0x80,d0		/* is Sonic within $80 pixels of basaran? */
		bcs.s	12f	/* if yes, branch */
		move.b	(v_vbla_byte).w,d0
		add.b	d7,d0
		andi.b	#7,d0
		bne.s	12f
		addq.b	#2,ob2ndRout(a0)

12:
		rts	
# ===========================================================================

4:
		bsr.w	SpeedToPos
		subi.w	#0x18,obVelY(a0)	/* make basaran fly upwards */
		bsr.w	ObjHitCeiling
		tst.w	d1		/* has basaran hit the ceiling? */
		bpl.s	13f	/* if not, branch */
		sub.w	d1,obY(a0)
		andi.w	#0xFFF8,obX(a0)
		clr.w	obVelX(a0)	/* stop basaran moving */
		clr.w	obVelY(a0)
		clr.b	obAnim(a0)
		clr.b	ob2ndRout(a0)

	13:
		rts	
# ===========================================================================

# Subroutine to check Sonic's distance from the basaran

# input:
#	d2 = distance to compare

# output:
#	d0 = distance between Sonic and basaran
#	d1 = speed/direction for basaran to fly

6:
		move.w	#0x100,d1
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcc.s	14f		/* if Sonic is right of basaran, branch */
		neg.w	d0
		neg.w	d1
		bclr	#0,obStatus(a0)

	14:
		cmp.w	d2,d0
		rts	
# ===========================================================================
# unused crap
		bsr.w	SpeedToPos
		bsr.w	DisplaySprite
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		rts	

