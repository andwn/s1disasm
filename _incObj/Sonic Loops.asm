# ---------------------------------------------------------------------------
# Subroutine to	make Sonic run around loops (GHZ/SLZ)
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Loops:
		cmpi.b	#id_SLZ,(v_zone).w /* is level SLZ ? */
		beq.s	1f	/* if yes, branch */
		tst.b	(v_zone).w	/* is level GHZ ? */
		bne.w	2f	/* if not, branch */

	1:
		move.w	obY(a0),d0
		lsr.w	#1,d0
		andi.w	#0x380,d0
		move.b	obX(a0),d1
		andi.w	#0x7F,d1
		add.w	d1,d0
		lea	(v_lvllayout).w,a1
		move.b	(a1,d0.w),d1	/* d1 is	the 256x256 tile Sonic is currently on */

		cmp.b	(v_256roll1).w,d1 /* is Sonic on a "roll tunnel" tile? */
		beq.w	Sonic_ChkRoll	/* if yes, branch */
		cmp.b	(v_256roll2).w,d1
		beq.w	Sonic_ChkRoll

		cmp.b	(v_256loop1).w,d1 /* is Sonic on a loop tile? */
		beq.s	3f	/* if yes, branch */
		cmp.b	(v_256loop2).w,d1
		beq.s	4f
		bclr	#6,obRender(a0) /* return Sonic to high plane */
		rts	
# ===========================================================================

4:
		btst	#1,obStatus(a0)	/* is Sonic in the air? */
		beq.s	3f	/* if not, branch */

		bclr	#6,obRender(a0)	/* return Sonic to high plane */
		rts	
# ===========================================================================

3:
		move.w	obX(a0),d2
		cmpi.b	#0x2C,d2
		bcc.s	5f

		bclr	#6,obRender(a0)	/* return Sonic to high plane */
		rts	
# ===========================================================================

5:
		cmpi.b	#0xE0,d2
		bcs.s	6f

		bset	#6,obRender(a0)	/* send Sonic to	low plane */
		rts	
# ===========================================================================

6:
		btst	#6,obRender(a0) /* is Sonic on low plane? */
		bne.s	7f	/* if yes, branch */

		move.b	obAngle(a0),d1
		beq.s	8f
		cmpi.b	#0x80,d1		/* is Sonic upside-down? */
		bhi.s	8f		/* if yes, branch */
		bset	#6,obRender(a0)	/* send Sonic to	low plane */
		rts	
# ===========================================================================

7:
		move.b	obAngle(a0),d1
		cmpi.b	#0x80,d1		/* is Sonic upright? */
		bls.s	8f		/* if yes, branch */
		bclr	#6,obRender(a0)	/* send Sonic to	high plane */

2:
8:
		rts	
# End of function Sonic_Loops

