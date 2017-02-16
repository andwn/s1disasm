# ---------------------------------------------------------------------------
# Object 18 - platforms	(GHZ, SYZ, SLZ)
# ---------------------------------------------------------------------------

BasicPlatform:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Plat_Index(pc,d0.w),d1
		jmp	Plat_Index(pc,d1.w)
# ===========================================================================
Plat_Index:	dc.w Plat_Main-Plat_Index
		dc.w Plat_Solid-Plat_Index
		dc.w Plat_Action2-Plat_Index
		dc.w Plat_Delete-Plat_Index
		dc.w Plat_Action-Plat_Index
# ===========================================================================

Plat_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.w	#0x4000,obGfx(a0)
		move.l	#Map_Plat_GHZ,obMap(a0)
		move.b	#0x20,obActWid(a0)
		cmpi.b	#id_SYZ,(v_zone).w /* check if level is SYZ */
		bne.s	1f

		move.l	#Map_Plat_SYZ,obMap(a0) /* SYZ specific code */
		move.b	#0x20,obActWid(a0)

	1:
		cmpi.b	#id_SLZ,(v_zone).w /* check if level is SLZ */
		bne.s	2f
		move.l	#Map_Plat_SLZ,obMap(a0) /* SLZ specific code */
		move.b	#0x20,obActWid(a0)
		move.w	#0x4000,obGfx(a0)
		move.b	#3,obSubtype(a0)

	2:
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.w	obY(a0),0x2C(a0)
		move.w	obY(a0),0x34(a0)
		move.w	obX(a0),0x32(a0)
		move.w	#0x80,obAngle(a0)
		moveq	#0,d1
		move.b	obSubtype(a0),d0
		cmpi.b	#0xA,d0		/* is object type $A (large platform)? */
		bne.s	3f	/* if not, branch */
		addq.b	#1,d1		/* use frame #1 */
		move.b	#0x20,obActWid(a0) /* set width */

	3:
		move.b	d1,obFrame(a0)	/* set frame to d1 */

Plat_Solid:	/* Routine 2 */
		tst.b	0x38(a0)
		beq.s	loc_7EE0
		subq.b	#4,0x38(a0)

	loc_7EE0:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		bsr.w	PlatformObject

Plat_Action:	/* Routine 8 */
		bsr.w	Plat_Move
		bsr.w	Plat_Nudge
		bsr.w	DisplaySprite
		bra.w	Plat_ChkDel
# ===========================================================================

Plat_Action2:	/* Routine 4 */
		cmpi.b	#0x40,0x38(a0)
		beq.s	loc_7F06
		addq.b	#4,0x38(a0)

	loc_7F06:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		bsr.w	ExitPlatform
		move.w	obX(a0),-(sp)
		bsr.w	Plat_Move
		bsr.w	Plat_Nudge
		move.w	(sp)+,d2
		bsr.w	MvSonicOnPtfm2
		bsr.w	DisplaySprite
		bra.w	Plat_ChkDel

		rts

# ---------------------------------------------------------------------------
# Subroutine to	move platform slightly when you	stand on it
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Plat_Nudge:
		move.b	0x38(a0),d0
		bsr.w	CalcSine
		move.w	#0x400,d1
		muls.w	d1,d0
		swap	d0
		add.w	0x2C(a0),d0
		move.w	d0,obY(a0)
		rts	
# End of function Plat_Nudge

# ---------------------------------------------------------------------------
# Subroutine to	move platforms
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Plat_Move:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xF,d0
		add.w	d0,d0
		move.w	platIndex(pc,d0.w),d1
		jmp	platIndex(pc,d1.w)
# End of function Plat_Move

# ===========================================================================
platIndex:		dc.w plat00-platIndex, plat01-platIndex
		dc.w plat02-platIndex, plat03-platIndex
		dc.w plat04-platIndex, plat05-platIndex
		dc.w plat06-platIndex, plat07-platIndex
		dc.w plat08-platIndex, plat00-platIndex
		dc.w plat0A-platIndex, plat0B-platIndex
		dc.w plat0C-platIndex
# ===========================================================================

plat00:
8:
		rts			/* platform 00 doesn't move */
# ===========================================================================

plat05:
9:
		move.w	0x32(a0),d0
		move.b	obAngle(a0),d1	/* load platform-motion variable */
		neg.b	d1		/* reverse platform-motion */
		addi.b	#0x40,d1
		bra.s	10f
# ===========================================================================

plat01:
11:
		move.w	0x32(a0),d0
		move.b	obAngle(a0),d1	/* load platform-motion variable */
		subi.b	#0x40,d1

	10:
		ext.w	d1
		add.w	d1,d0
		move.w	d0,obX(a0)	/* change position on x-axis */
		bra.w	12f
# ===========================================================================

plat0C:
7:
		move.w	0x34(a0),d0
		move.b	(v_oscillate+0xE).w,d1 /* load platform-motion variable */
		neg.b	d1		/* reverse platform-motion */
		addi.b	#0x30,d1
		bra.s	13f
# ===========================================================================

plat0B:
14:
		move.w	0x34(a0),d0
		move.b	(v_oscillate+0xE).w,d1 /* load platform-motion variable */
		subi.b	#0x30,d1
		bra.s	13f
# ===========================================================================

plat06:
4:
		move.w	0x34(a0),d0
		move.b	obAngle(a0),d1	/* load platform-motion variable */
		neg.b	d1		/* reverse platform-motion */
		addi.b	#0x40,d1
		bra.s	13f
# ===========================================================================

plat02:
2:
		move.w	0x34(a0),d0
		move.b	obAngle(a0),d1	/* load platform-motion variable */
		subi.b	#0x40,d1

	13:
		ext.w	d1
		add.w	d1,d0
		move.w	d0,0x2C(a0)	/* change position on y-axis */
		bra.w	12f
# ===========================================================================

plat03:
15:
		tst.w	0x3A(a0)		/* is time delay	set? */
		bne.s	16f	/* if yes, branch */
		btst	#3,obStatus(a0)	/* is Sonic standing on the platform? */
		beq.s	17f	/* if not, branch */
		move.w	#30,0x3A(a0)	/* set time delay to 0.5	seconds */

	17:
		rts	

	16:
		subq.w	#1,0x3A(a0)	/* subtract 1 from time */
		bne.s	17b	/* if time is > 0, branch */
		move.w	#32,0x3A(a0)
		addq.b	#1,obSubtype(a0) /* change to type 04 (falling) */
		rts	
# ===========================================================================

plat04:
3:
		tst.w	0x3A(a0)
		beq.s	18f
		subq.w	#1,0x3A(a0)
		bne.s	18f
		btst	#3,obStatus(a0)
		beq.s	19f
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)
		bclr	#3,obStatus(a0)
		clr.b	0x25(a0)
		move.w	obVelY(a0),obVelY(a1)

	19:
		move.b	#8,obRoutine(a0)

	18:
		move.l	0x2C(a0),d3
		move.w	obVelY(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d3,0x2C(a0)
		addi.w	#0x38,obVelY(a0)
		move.w	(v_limitbtm2).w,d0
		addi.w	#0xE0,d0
		cmp.w	0x2C(a0),d0
		bcc.s	20f
		move.b	#6,obRoutine(a0)

	20:
		rts	
# ===========================================================================

plat07:
21:
		tst.w	0x3A(a0)		/* is time delay	set? */
		bne.s	22f	/* if yes, branch */
		lea	(f_switch).w,a2	/* load switch statuses */
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* move object type ($x7) to d0 */
		lsr.w	#4,d0		/* divide d0 by 8, round	down */
		tst.b	(a2,d0.w)	/* has switch no. d0 been pressed? */
		beq.s	23f	/* if not, branch */
		move.w	#60,0x3A(a0)	/* set time delay to 1 second */

	23:
		rts	

	22:
		subq.w	#1,0x3A(a0)	/* subtract 1 from time delay */
		bne.s	23b	/* if time is > 0, branch */
		addq.b	#1,obSubtype(a0) /* change to type 08 */
		rts	
# ===========================================================================

plat08:
5:
		subq.w	#2,0x2C(a0)	/* move platform	up */
		move.w	0x34(a0),d0
		subi.w	#0x200,d0
		cmp.w	0x2C(a0),d0	/* has platform moved $200 pixels? */
		bne.s	24f	/* if not, branch */
		clr.b	obSubtype(a0)	/* change to type 00 (stop moving) */

	24:
		rts	
# ===========================================================================

plat0A:
6:
		move.w	0x34(a0),d0
		move.b	obAngle(a0),d1	/* load platform-motion variable */
		subi.b	#0x40,d1
		ext.w	d1
		asr.w	#1,d1
		add.w	d1,d0
		move.w	d0,0x2C(a0)	/* change position on y-axis */

12:
		move.b	(v_oscillate+0x1A).w,0x26(a0) /* update platform-movement variable */
		rts	
# ===========================================================================

Plat_ChkDel:
		out_of_range_s	Plat_Delete,0x32(a0)
		rts	
# ===========================================================================

Plat_Delete:	/* Routine 6 */
		bra.w	DeleteObject

