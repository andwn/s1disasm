# ---------------------------------------------------------------------------
# Subroutine to	generate a pseudo-random number	in d0
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


RandomNumber:
		move.l	(v_random).w,d1
		bne.s	1f	/* if d0 is not 0, branch */
		move.l	#0x2A6D365A,d1	/* if do is 0, use seed number */

	1:
		move.l	d1,d0
		asl.l	#2,d1
		add.l	d0,d1
		asl.l	#3,d1
		add.l	d0,d1
		move.w	d1,d0
		swap	d1
		add.w	d1,d0
		move.w	d0,d1
		swap	d1
		move.l	d1,(v_random).w
		rts	

