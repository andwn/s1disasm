# ---------------------------------------------------------------------------
# Subroutine allowing Sonic to roll when he's moving
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Roll:
		tst.b	(f_jumponly).w
		bne.s	1f
		move.w	obInertia(a0),d0
		bpl.s	2f
		neg.w	d0

	2:
		cmpi.w	#0x80,d0		/* is Sonic moving at $80 speed or faster? */
		bcs.s	1f		/* if not, branch */
		move.b	(v_jpadhold2).w,d0
		andi.b	#btnL+btnR,d0	/* is left/right	being pressed? */
		bne.s	1f		/* if yes, branch */
		btst	#bitDn,(v_jpadhold2).w /* is down being pressed? */
		bne.s	Sonic_ChkRoll	/* if yes, branch */

	1:
		rts	
# ===========================================================================

Sonic_ChkRoll:
		btst	#2,obStatus(a0)	/* is Sonic already rolling? */
		beq.s	1f		/* if not, branch */
		rts	
# ===========================================================================

1:
		bset	#2,obStatus(a0)
		move.b	#0xE,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0) /* use "rolling" animation */
		addq.w	#5,obY(a0)
		sfx	sfx_Roll,0,0,0	/* play rolling sound */
		tst.w	obInertia(a0)
		bne.s	2f
		move.w	#0x200,obInertia(a0) /* set inertia if 0 */

	2:
		rts	
# End of function Sonic_Roll

