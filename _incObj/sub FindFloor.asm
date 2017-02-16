# ---------------------------------------------------------------------------
# Subroutine to	find the floor

# input:
#	d2 = y-position of object's bottom edge
#	d3 = x-position of object
#	d5 = bit to test for solidness

# output:
#	d1 = distance to the floor
#	a1 = address within 256x256 mappings where object is standing
#	     (refers to a 16x16 tile number)
#	(a4) = floor angle
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FindFloor:
		bsr.s	FindNearestTile
		move.w	(a1),d0		/* get value for solidness, orientation and 16x16 tile number */
		move.w	d0,d4
		andi.w	#0x7FF,d0
		beq.s	1f	/* branch if tile is blank */
		btst	d5,d4		/* is the tile solid? */
		bne.s	2f	/* if yes, branch */

1:
		add.w	a3,d2
		bsr.w	FindFloor2	/* try tile below the nearest */
		sub.w	a3,d2
		addi.w	#0x10,d1		/* return distance to floor */
		rts	
# ===========================================================================

2:
		movea.l	(v_collindex).w,a2
		move.b	(a2,d0.w),d0	/* get collision block number */
		andi.w	#0xFF,d0
		beq.s	1b	/* branch if 0 */
		lea	(AngleMap).l,a2
		move.b	(a2,d0.w),(a4)	/* get collision angle value */
		lsl.w	#4,d0
		move.w	d3,d1		/* get x-pos. of object */
		btst	#0xB,d4		/* is block flipped horizontally? */
		beq.s	3f		/* if not, branch */
		not.w	d1
		neg.b	(a4)

	3:
		btst	#0xC,d4		/* is block flipped vertically? */
		beq.s	4f	/* if not, branch */
		addi.b	#0x40,(a4)
		neg.b	(a4)
		subi.b	#0x40,(a4)

	4:
		andi.w	#0xF,d1
		add.w	d0,d1		/* (block num. * $10) + x-pos. = place in array */
		lea	(CollArray1).l,a2
		move.b	(a2,d1.w),d0	/* get collision height */
		ext.w	d0
		eor.w	d6,d4
		btst	#0xC,d4		/* is block flipped vertically? */
		beq.s	5f	/* if not, branch */
		neg.w	d0

	5:
		tst.w	d0
		beq.s	1b	/* branch if height is 0 */
		bmi.s	6f	/* branch if height is negative */
		cmpi.b	#0x10,d0
		beq.s	7f	/* branch if height is $10 (max) */
		move.w	d2,d1		/* get y-pos. of object */
		andi.w	#0xF,d1
		add.w	d1,d0
		move.w	#0xF,d1
		sub.w	d0,d1		/* return distance to floor */
		rts	
# ===========================================================================

6:
		move.w	d2,d1
		andi.w	#0xF,d1
		add.w	d1,d0
		bpl.w	1b

7:
		sub.w	a3,d2
		bsr.w	FindFloor2	/* try tile above the nearest */
		add.w	a3,d2
		subi.w	#0x10,d1		/* return distance to floor */
		rts	
# End of function FindFloor


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FindFloor2:
		bsr.w	FindNearestTile
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#0x7FF,d0
		beq.s	1f
		btst	d5,d4
		bne.s	2f

1:
		move.w	#0xF,d1
		move.w	d2,d0
		andi.w	#0xF,d0
		sub.w	d0,d1
		rts	
# ===========================================================================

2:
		movea.l	(v_collindex).w,a2
		move.b	(a2,d0.w),d0
		andi.w	#0xFF,d0
		beq.s	1b
		lea	(AngleMap).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#0xB,d4
		beq.s	3f
		not.w	d1
		neg.b	(a4)

	3:
		btst	#0xC,d4
		beq.s	4f
		addi.b	#0x40,(a4)
		neg.b	(a4)
		subi.b	#0x40,(a4)

	4:
		andi.w	#0xF,d1
		add.w	d0,d1
		lea	(CollArray1).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#0xC,d4
		beq.s	5f
		neg.w	d0

	5:
		tst.w	d0
		beq.s	1b
		bmi.s	6f
		move.w	d2,d1
		andi.w	#0xF,d1
		add.w	d1,d0
		move.w	#0xF,d1
		sub.w	d0,d1
		rts	
# ===========================================================================

6:
		move.w	d2,d1
		andi.w	#0xF,d1
		add.w	d1,d0
		bpl.w	1b
		not.w	d1
		rts	
# End of function FindFloor2

