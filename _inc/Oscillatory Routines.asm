# ---------------------------------------------------------------------------
# Oscillating number subroutines
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Initialise the values

OscillateNumInit:
		lea	(v_oscillate).w,a1
		lea	(oscDir).l,a2
		moveq	#0x20,d1

	2:
		move.w	(a2)+,(a1)+	/* copy baseline values to RAM */
		dbf d1,2b
		rts	


# ===========================================================================
oscDir:	dc.w 0b0000000001111100	/* oscillation direction bitfield */
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x80, 0
		dc.w 0x50F0, 0x11E
		dc.w 0x2080, 0xB4
		dc.w 0x3080, 0x10E
		dc.w 0x5080, 0x1C2
		dc.w 0x7080, 0x276
		dc.w 0x80, 0
		dc.w 0x80, 0
		.align 2

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Oscillate values

OscillateNumDo:
		cmpi.b	#6,(v_player+obRoutine).w /* has Sonic just died? */
		bcc.s	1f		/* if yes, branch */
		lea	(v_oscillate).w,a1
		lea	(oscData).l,a2
		move.w	(a1)+,d3	/* get oscillation direction bitfield */
		moveq	#0xF,d1

3:
		move.w	(a2)+,d2	/* get frequency */
		move.w	(a2)+,d4	/* get amplitude */
		btst	d1,d3		/* check oscillation direction */
		bne.s	4f		/* branch if 1 */

	5:
		move.w	2(a1),d0	/* get current rate */
		add.w	d2,d0		/* add frequency */
		move.w	d0,2(a1)
		add.w	d0,0(a1)	/* add rate to value */
		cmp.b	0(a1),d4
		bhi.s	6f
		bset	d1,d3
		bra.s	6f

	4:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,0(a1)
		cmp.b	0(a1),d4
		bls.s	6f
		bclr	d1,d3

	6:
		addq.w	#4,a1
		dbf d1,3b
		move.w	d3,(v_oscillate).w

1:
		rts	
# End of function OscillateNumDo

# ===========================================================================
oscData:	dc.w 2,	0x10	/* frequency, amplitude */
		dc.w 2,	0x18
		dc.w 2,	0x20
		dc.w 2,	0x30
		dc.w 4,	0x20
		dc.w 8,	8
		dc.w 8,	0x40
		dc.w 4,	0x40
		dc.w 2,	0x50
		dc.w 2,	0x50
		dc.w 2,	0x20
		dc.w 3,	0x30
		dc.w 5,	0x50
		dc.w 7,	0x70
		dc.w 2,	0x10
		dc.w 2,	0x10
		.align 2
