# ---------------------------------------------------------------------------
# Subroutine to react to obColType(a0)
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ReactToItem:
		nop	
		move.w	obX(a0),d2	/* load Sonic's x-axis position */
		move.w	obY(a0),d3	/* load Sonic's y-axis position */
		subq.w	#8,d2
		moveq	#0,d5
		move.b	obHeight(a0),d5	/* load Sonic's height */
		subq.b	#3,d5
		sub.w	d5,d3
		cmpi.b	#fr_Duck,obFrame(a0) /* is Sonic ducking? */
		bne.s	1f	/* if not, branch */
		addi.w	#0xC,d3
		moveq	#0xA,d5

	1:
		move.w	#0x10,d4
		add.w	d5,d5
		lea	(v_objspace+0x800).w,a1 /* set object RAM start address */
		move.w	#0x5F,d6

2:
		tst.b	obRender(a1)
		bpl.s	3f
		move.b	obColType(a1),d0 /* load collision type */
		bne.s	4f	/* if nonzero, branch */

	3:
		lea	0x40(a1),a1	/* next object RAM */
		dbf d6,2b	/* repeat $5F more times */

		moveq	#0,d0
		rts	
# ===========================================================================
reactWH:		/*   width, height */
		dc.b  0x14, 0x14		/* $01 */
		dc.b   0xC, 0x14		/* $02 */
		dc.b  0x14,  0xC		/* $03 */
		dc.b	4, 0x10		/* $04 */
		dc.b   0xC, 0x12		/* $05 */
		dc.b  0x10, 0x10		/* $06 */
		dc.b	6,   6		/* $07 */
		dc.b  0x18,  0xC		/* $08 */
		dc.b   0xC, 0x10		/* $09 */
		dc.b  0x10,  0xC		/* $0A */
		dc.b	8,   8		/* $0B */
		dc.b  0x14, 0x10		/* $0C */
		dc.b  0x14,   8		/* $0D */
		dc.b   0xE,  0xE		/* $0E */
		dc.b  0x18, 0x18		/* $0F */
		dc.b  0x28, 0x10		/* $10 */
		dc.b  0x10, 0x18		/* $11 */
		dc.b	8, 0x10		/* $12 */
		dc.b  0x20, 0x70		/* $13 */
		dc.b  0x40, 0x20		/* $14 */
		dc.b  0x80, 0x20		/* $15 */
		dc.b  0x20, 0x20		/* $16 */
		dc.b	8,   8		/* $17 */
		dc.b	4,   4		/* $18 */
		dc.b  0x20,   8		/* $19 */
		dc.b   0xC,  0xC		/* $1A */
		dc.b	8,   4		/* $1B */
		dc.b  0x18,   4		/* $1C */
		dc.b  0x28,   4		/* $1D */
		dc.b	4,   8		/* $1E */
		dc.b	4, 0x18		/* $1F */
		dc.b	4, 0x28		/* $20 */
		dc.b	4, 0x20		/* $21 */
		dc.b  0x18, 0x18		/* $22 */
		dc.b   0xC, 0x18		/* $23 */
		dc.b  0x48,   8		/* $24 */
# ===========================================================================

4:
		andi.w	#0x3F,d0
		add.w	d0,d0
		lea	reactWH-2(pc,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obX(a1),d0
		sub.w	d1,d0
		sub.w	d2,d0
		bcc.s	6f	/* branch if not touching */
		add.w	d1,d1
		add.w	d1,d0
		bcs.s	7f	/* branch if touching */
		bra.w	3b
# ===========================================================================

6:
		cmp.w	d4,d0
		bhi.w	3b

7:
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obY(a1),d0
		sub.w	d1,d0
		sub.w	d3,d0
		bcc.s	8f	/* branch if not touching */
		add.w	d1,d1
		add.w	d0,d1
		bcs.s	9f	/* branch if touching */
		bra.w	3b
# ===========================================================================

8:
		cmp.w	d5,d0
		bhi.w	3b

9:
	10:
		move.b	obColType(a1),d1 /* load collision type */
		andi.b	#0xC0,d1		/* is obColType $40 or higher? */
		beq.w	React_Enemy	/* if not, branch */
		cmpi.b	#0xC0,d1		/* is obColType $C0 or higher? */
		beq.w	React_Special	/* if yes, branch */
		tst.b	d1		/* is obColType $80-$BF? */
		bmi.w	React_ChkHurt	/* if yes, branch */

# obColType is $40-$7F (powerups)

		move.b	obColType(a1),d0
		andi.b	#0x3F,d0
		cmpi.b	#6,d0		/* is collision type $46	? */
		beq.s	React_Monitor	/* if yes, branch */
		cmpi.w	#90,0x30(a0)	/* is Sonic invincible? */
		bcc.w	11f	/* if yes, branch */
		addq.b	#2,obRoutine(a1) /* advance the object's routine counter */

	11:
		rts	
# ===========================================================================

React_Monitor:
		tst.w	obVelY(a0)	/* is Sonic moving upwards? */
		bpl.s	1f	/* if not, branch */

		move.w	obY(a0),d0
		subi.w	#0x10,d0
		cmp.w	obY(a1),d0
		bcs.s	2f
		neg.w	obVelY(a0)	/* reverse Sonic's vertical speed */
		move.w	#-0x180,obVelY(a1)
		tst.b	ob2ndRout(a1)
		bne.s	2f
		addq.b	#4,ob2ndRout(a1) /* advance the monitor's routine counter */
		rts	
# ===========================================================================

1:
		cmpi.b	#id_Roll,obAnim(a0) /* is Sonic rolling/jumping? */
		bne.s	2f
		neg.w	obVelY(a0)	/* reverse Sonic's y-motion */
		addq.b	#2,obRoutine(a1) /* advance the monitor's routine counter */

	2:
		rts	
# ===========================================================================

React_Enemy:
		tst.b	(v_invinc).w	/* is Sonic invincible? */
		bne.s	1f	/* if yes, branch */
		cmpi.b	#id_Roll,obAnim(a0) /* is Sonic rolling/jumping? */
		bne.w	React_ChkHurt	/* if not, branch */

	1:
		tst.b	obColProp(a1)
		beq.s	2f

		neg.w	obVelX(a0)	/* repel Sonic */
		neg.w	obVelY(a0)
		asr	obVelX(a0)
		asr	obVelY(a0)
		move.b	#0,obColType(a1)
		subq.b	#1,obColProp(a1)
		bne.s	3f
		bset	#7,obStatus(a1)

	3:
		rts	
# ===========================================================================

2:
		bset	#7,obStatus(a1)
		moveq	#0,d0
		move.w	(v_itembonus).w,d0
		addq.w	#2,(v_itembonus).w /* add 2 to item bonus counter */
		cmpi.w	#6,d0
		bcs.s	4f
		moveq	#6,d0		/* max bonus is lvl6 */

	4:
		move.w	d0,0x3E(a1)
		move.w	reactPoints(pc,d0.w),d0
		cmpi.w	#0x20,(v_itembonus).w /* have 16 enemies been destroyed? */
		bcs.s	6f	/* if not, branch */
		move.w	#1000,d0	/* fix bonus to 10000 */
		move.w	#0xA,0x3E(a1)

	6:
		bsr.w	AddPoints
		move.b	#id_ExplosionItem,0(a1) /* change object to explosion */
		move.b	#0,obRoutine(a1)
		tst.w	obVelY(a0)
		bmi.s	7f
		move.w	obY(a0),d0
		cmp.w	obY(a1),d0
		bcc.s	8f
		neg.w	obVelY(a0)
		rts	
# ===========================================================================

	7:
		addi.w	#0x100,obVelY(a0)
		rts	

	8:
		subi.w	#0x100,obVelY(a0)
		rts	

reactPoints:	dc.w 10, 20, 50, 100	/* points awarded div 10 */

# ===========================================================================

React_Caterkiller:
		bset	#7,obStatus(a1)

React_ChkHurt:
		tst.b	(v_invinc).w	/* is Sonic invincible? */
		beq.s	1f	/* if not, branch */

	2:
		moveq	#-1,d0
		rts	
# ===========================================================================

	1:
		nop	
		tst.w	0x30(a0)		/* is Sonic flashing? */
		bne.s	2b	/* if yes, branch */
		movea.l	a1,a2

# End of function ReactToItem
# continue straight to HurtSonic

# ---------------------------------------------------------------------------
# Hurting Sonic	subroutine
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HurtSonic:
		tst.b	(v_shield).w	/* does Sonic have a shield? */
		bne.s	1f	/* if yes, branch */
		tst.w	(v_rings).w	/* does Sonic have any rings? */
		beq.w	2f	/* if not, branch */

		jsr	(FindFreeObj).l
		bne.s	1f
		move.b	#id_RingLoss,0(a1) /* load bouncing multi rings object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

	1:
		move.b	#0,(v_shield).w	/* remove shield */
		move.b	#4,obRoutine(a0)
		bsr.w	Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		move.w	#-0x400,obVelY(a0) /* make Sonic bounce away from the object */
		move.w	#-0x200,obVelX(a0)
		btst	#6,obStatus(a0)	/* is Sonic underwater? */
		beq.s	3f		/* if not, branch */

		move.w	#-0x200,obVelY(a0) /* slower bounce */
		move.w	#-0x100,obVelX(a0)

	3:
		move.w	obX(a0),d0
		cmp.w	obX(a2),d0
		bcs.s	4f		/* if Sonic is left of the object, branch */
		neg.w	obVelX(a0)	/* if Sonic is right of the object, reverse */

	4:
		move.w	#0,obInertia(a0)
		move.b	#id_Hurt,obAnim(a0)
		move.w	#120,0x30(a0)	/* set temp invincible time to 2 seconds */
		move.w	#sfx_Death,d0	/* load normal damage sound */
		cmpi.b	#id_Spikes,(a2)	/* was damage caused by spikes? */
		bne.s	5f		/* if not, branch */
		cmpi.b	#id_Harpoon,(a2) /* was damage caused by LZ harpoon? */
		bne.s	5f		/* if not, branch */
		move.w	#sfx_HitSpikes,d0 /* load spikes damage sound */

	5:
		jsr	(PlaySound_Special).l
		moveq	#-1,d0
		rts	
# ===========================================================================

2:
		tst.w	(f_debugmode).w	/* is debug mode	cheat on? */
		bne.w	1b	/* if yes, branch */

# ---------------------------------------------------------------------------
# Subroutine to	kill Sonic
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


KillSonic:
		tst.w	(v_debuguse).w	/* is debug mode	active? */
		bne.s	1f	/* if yes, branch */
		move.b	#0,(v_invinc).w	/* remove invincibility */
		move.b	#6,obRoutine(a0)
		bsr.w	Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		move.w	#-0x700,obVelY(a0)
		move.w	#0,obVelX(a0)
		move.w	#0,obInertia(a0)
		move.w	obY(a0),0x38(a0)
		move.b	#id_Death,obAnim(a0)
		bset	#7,obGfx(a0)
		move.w	#sfx_Death,d0	/* play normal death sound */
		cmpi.b	#id_Spikes,(a2)	/* check	if you were killed by spikes */
		bne.s	2f
		move.w	#sfx_HitSpikes,d0 /* play spikes death sound */

	2:
		jsr	(PlaySound_Special).l

	1:
		moveq	#-1,d0
		rts	
# End of function KillSonic


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


React_Special:
		move.b	obColType(a1),d1
		andi.b	#0x3F,d1
		cmpi.b	#0xB,d1		/* is collision type $CB	? */
		beq.s	1f	/* if yes, branch */
		cmpi.b	#0xC,d1		/* is collision type $CC	? */
		beq.s	2f		/* if yes, branch */
		cmpi.b	#0x17,d1		/* is collision type $D7	? */
		beq.s	3f		/* if yes, branch */
		cmpi.b	#0x21,d1		/* is collision type $E1	? */
		beq.s	3f		/* if yes, branch */
		rts	
# ===========================================================================

1:
		bra.w	React_Caterkiller
# ===========================================================================

2:
		sub.w	d0,d5
		cmpi.w	#8,d5
		bcc.s	4f
		move.w	obX(a1),d0
		subq.w	#4,d0
		btst	#0,obStatus(a1)
		beq.s	5f
		subi.w	#0x10,d0

	5:
		sub.w	d2,d0
		bcc.s	6f
		addi.w	#0x18,d0
		bcs.s	7f
		bra.s	4f
# ===========================================================================

	6:
		cmp.w	d4,d0
		bhi.s	4f

	7:
		bra.w	React_ChkHurt
# ===========================================================================

	4:
		bra.w	React_Enemy
# ===========================================================================

3:
		addq.b	#1,obColProp(a1)
		rts	
# End of function React_Special

