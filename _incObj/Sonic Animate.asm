# ---------------------------------------------------------------------------
# Subroutine to	animate	Sonic's sprites
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Animate:
		lea	(Ani_Sonic).l,a1
		moveq	#0,d0
		move.b	obAnim(a0),d0
		cmp.b	obNextAni(a0),d0 /* is animation set to restart? */
		beq.s	1f		/* if not, branch */
		move.b	d0,obNextAni(a0) /* set to "no restart" */
		move.b	#0,obAniFrame(a0) /* reset animation */
		move.b	#0,obTimeFrame(a0) /* reset frame duration */

	1:
		add.w	d0,d0
		adda.w	(a1,d0.w),a1	/* jump to appropriate animation	script */
		move.b	(a1),d0
		bmi.s	2f	/* if animation is walk/run/roll/jump, branch */
		move.b	obStatus(a0),d1
		andi.b	#1,d1
		andi.b	#0xFC,obRender(a0)
		or.b	d1,obRender(a0)
		subq.b	#1,obTimeFrame(a0) /* subtract 1 from frame duration */
		bpl.s	3f		/* if time remains, branch */
		move.b	d0,obTimeFrame(a0) /* load frame duration */

4:
		moveq	#0,d1
		move.b	obAniFrame(a0),d1 /* load current frame number */
		move.b	1(a1,d1.w),d0	/* read sprite number from script */
		bmi.s	5f		/* if animation is complete, branch */

	6:
		move.b	d0,obFrame(a0)	/* load sprite number */
		addq.b	#1,obAniFrame(a0) /* next frame number */

	3:
		rts	
# ===========================================================================

5:
		addq.b	#1,d0		/* is the end flag = $FF	? */
		bne.s	7f		/* if not, branch */
		move.b	#0,obAniFrame(a0) /* restart the animation */
		move.b	1(a1),d0	/* read sprite number */
		bra.s	6b
# ===========================================================================

7:
		addq.b	#1,d0		/* is the end flag = $FE	? */
		bne.s	8f		/* if not, branch */
		move.b	2(a1,d1.w),d0	/* read the next	byte in	the script */
		sub.b	d0,obAniFrame(a0) /* jump back d0 bytes in the script */
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0	/* read sprite number */
		bra.s	6b
# ===========================================================================

8:
		addq.b	#1,d0		/* is the end flag = $FD	? */
		bne.s	9f		/* if not, branch */
		move.b	2(a1,d1.w),obAnim(a0) /* read next byte, run that animation */

	9:
		rts	
# ===========================================================================

2:
		subq.b	#1,obTimeFrame(a0) /* subtract 1 from frame duration */
		bpl.s	3b		/* if time remains, branch */
		addq.b	#1,d0		/* is animation walking/running? */
		bne.w	10f	/* if not, branch */
		moveq	#0,d1
		move.b	obAngle(a0),d0	/* get Sonic's angle */
		move.b	obStatus(a0),d2
		andi.b	#1,d2		/* is Sonic mirrored horizontally? */
		bne.s	11f		/* if yes, branch */
		not.b	d0		/* reverse angle */

	11:
		addi.b	#0x10,d0		/* add $10 to angle */
		bpl.s	12f	/* if angle is $0-$7F, branch */
		moveq	#3,d1

	12:
		andi.b	#0xFC,obRender(a0)
		eor.b	d1,d2
		or.b	d2,obRender(a0)
		btst	#5,obStatus(a0)	/* is Sonic pushing something? */
		bne.w	13f		/* if yes, branch */

		lsr.b	#4,d0		/* divide angle by $10 */
		andi.b	#6,d0		/* angle	must be	0, 2, 4	or 6 */
		move.w	obInertia(a0),d2 /* get Sonic's speed */
		bpl.s	14f
		neg.w	d2		/* modulus speed */

	14:
		lea	(SonAni_Run).l,a1 /* use	running	animation */
		cmpi.w	#0x600,d2	/* is Sonic at running speed? */
		bcc.s	15f	/* if yes, branch */

		lea	(SonAni_Walk).l,a1 /* use walking animation */
		move.b	d0,d1
		lsr.b	#1,d1
		add.b	d1,d0

	15:
		add.b	d0,d0
		move.b	d0,d3
		neg.w	d2
		addi.w	#0x800,d2
		bpl.s	16f
		moveq	#0,d2		/* max animation speed */

	16:
		lsr.w	#8,d2
		move.b	d2,obTimeFrame(a0) /* modify frame duration */
		bsr.w	4b
		add.b	d3,obFrame(a0)	/* modify frame number */
		rts	
# ===========================================================================

10:
		addq.b	#1,d0		/* is animation rolling/jumping? */
		bne.s	13f		/* if not, branch */
		move.w	obInertia(a0),d2 /* get Sonic's speed */
		bpl.s	17f
		neg.w	d2

	17:
		lea	(SonAni_Roll2).l,a1 /* use fast animation */
		cmpi.w	#0x600,d2	/* is Sonic moving fast? */
		bcc.s	18f	/* if yes, branch */
		lea	(SonAni_Roll).l,a1 /* use slower	animation */

	18:
		neg.w	d2
		addi.w	#0x400,d2
		bpl.s	19f
		moveq	#0,d2

	19:
		lsr.w	#8,d2
		move.b	d2,obTimeFrame(a0) /* modify frame duration */
		move.b	obStatus(a0),d1
		andi.b	#1,d1
		andi.b	#0xFC,obRender(a0)
		or.b	d1,obRender(a0)
		bra.w	4b
# ===========================================================================

13:
		move.w	obInertia(a0),d2 /* get Sonic's speed */
		bmi.s	20f
		neg.w	d2

	20:
		addi.w	#0x800,d2
		bpl.s	21f	
		moveq	#0,d2

	21:
		lsr.w	#6,d2
		move.b	d2,obTimeFrame(a0) /* modify frame duration */
		lea	(SonAni_Push).l,a1
		move.b	obStatus(a0),d1
		andi.b	#1,d1
		andi.b	#0xFC,obRender(a0)
		or.b	d1,obRender(a0)
		bra.w	4b

# End of function Sonic_Animate

