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
		bcc.s	oscEnd		/* if yes, branch */
		lea	(v_oscillate).w,a1
		lea	(oscSettings).l,a2
		move.w	(a1)+,d3	/* get oscillation direction bitfield */
		moveq	#0xF,d1

oscLoop:
		move.w	(a2)+,d2	/* get frequency */
		move.w	(a2)+,d4	/* get amplitude */
		btst	d1,d3		/* check oscillation direction */
		bne.s	oscDown		/* branch if 1 */

oscUp:
		move.w	2(a1),d0	/* get current rate */
		add.w	d2,d0		/* add frequency */
		move.w	d0,2(a1)
		add.w	d0,0(a1)	/* add rate to value */
		nop /* filling space for bindiff */
		cmp.b	0(a1),d4
		nop /* filling space for bindiff */
		bhi.s	oscNext
		bset	d1,d3
		bra.s	oscNext

oscDown:
		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,0(a1)
		nop /* filling space for bindiff */
		cmp.b	0(a1),d4
		nop /* filling space for bindiff */
		bls.s	oscNext
		bclr	d1,d3

oscNext:
		addq.w	#4,a1
		dbf d1,oscLoop
		move.w	d3,(v_oscillate).w

oscEnd:
		rts	
# End of function OscillateNumDo

# ===========================================================================
oscSettings:
		dc.w 2,	0x10	/* frequency, amplitude */
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
