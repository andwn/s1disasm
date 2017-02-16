# ---------------------------------------------------------------------------
# Subroutine to	find which tile	the object is standing on

# input:
#	d2 = y-position of object's bottom edge
#	d3 = x-position of object

# output:
#	a1 = address within 256x256 mappings where object is standing
#	     (refers to a 16x16 tile number)
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FindNearestTile:
		move.w	d2,d0		/* get y-pos. of bottom edge of object */
		lsr.w	#1,d0
		andi.w	#0x380,d0
		move.w	d3,d1		/* get x-pos. of object */
		lsr.w	#8,d1
		andi.w	#0x7F,d1
		add.w	d1,d0		/* combine */
		moveq	#-1,d1
		lea	(v_lvllayout).w,a1
		move.b	(a1,d0.w),d1	/* get 256x256 tile number */
		beq.s	1f	/* branch if 0 */
		bmi.s	2f	/* branch if >$7F */
		subq.b	#1,d1
		ext.w	d1
		ror.w	#7,d1
		move.w	d2,d0
		add.w	d0,d0
		andi.w	#0x1E0,d0
		add.w	d0,d1
		move.w	d3,d0
		lsr.w	#3,d0
		andi.w	#0x1E,d0
		add.w	d0,d1

1:
		movea.l	d1,a1
		rts	
# ===========================================================================

2:
		andi.w	#0x7F,d1
		btst	#6,obRender(a0) /* is object "behind a loop"? */
		beq.s	3f	/* if not, branch */
		addq.w	#1,d1
		cmpi.w	#0x29,d1
		bne.s	3f
		move.w	#0x51,d1

	3:
		subq.b	#1,d1
		ror.w	#7,d1
		move.w	d2,d0
		add.w	d0,d0
		andi.w	#0x1E0,d0
		add.w	d0,d1
		move.w	d3,d0
		lsr.w	#3,d0
		andi.w	#0x1E,d0
		add.w	d0,d1
		movea.l	d1,a1
		rts	
# End of function FindNearestTile

