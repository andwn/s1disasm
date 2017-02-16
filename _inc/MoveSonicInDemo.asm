# ---------------------------------------------------------------------------
# Subroutine to	move Sonic in demo mode
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MoveSonicInDemo:
		tst.w	(f_demo).w	/* is demo mode on? */
		bne.s	MDemo_On	/* if yes, branch */
		rts	
# ===========================================================================

# This is an unused subroutine for recording a demo

DemoRecorder:
		lea	(0x80000).l,a1
		move.w	(v_btnpushtime1).w,d0
		adda.w	d0,a1
		move.b	(v_jpadhold1).w,d0
		cmp.b	(a1),d0
		bne.s	1f
		addq.b	#1,1(a1)
		cmpi.b	#0xFF,1(a1)
		beq.s	1f
		rts	

	1:
		move.b	d0,2(a1)
		move.b	#0,3(a1)
		addq.w	#2,(v_btnpushtime1).w
		andi.w	#0x3FF,(v_btnpushtime1).w
		rts	
# ===========================================================================

MDemo_On:
		tst.b	(v_jpadhold1).w	/* is start button pressed? */
		bpl.s	1f	/* if not, branch */
		tst.w	(f_demo).w	/* is this an ending sequence demo? */
		bmi.s	1f	/* if yes, branch */
		move.b	#id_Title,(v_gamemode).w /* go to title screen */

	1:
		lea	(DemoDataPtr).l,a1
		moveq	#0,d0
		move.b	(v_zone).w,d0
		cmpi.b	#id_Special,(v_gamemode).w /* is this a special stage? */
		bne.s	2f	/* if not, branch */
		moveq	#6,d0		/* use demo #6 */

	2:
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1	/* fetch address for demo data */
		tst.w	(f_demo).w	/* is this an ending sequence demo? */
		bpl.s	3f	/* if not, branch */
		lea	(DemoEndDataPtr).l,a1
		move.w	(v_creditsnum).w,d0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1	/* fetch address for credits demo */

	3:
		move.w	(v_btnpushtime1).w,d0
		adda.w	d0,a1
		move.b	(a1),d0
		lea	(v_jpadhold1).w,a0
		move.b	d0,d1
		.if Revision==0
		move.b	(a0),d2
		.else
			moveq	#0,d2
		.endc
		eor.b	d2,d0
		move.b	d1,(a0)+
		and.b	d1,d0
		move.b	d0,(a0)+
		subq.b	#1,(v_btnpushtime2).w
		bcc.s	4f
		move.b	3(a1),(v_btnpushtime2).w
		addq.w	#2,(v_btnpushtime1).w

	4:
		rts	
# End of function MoveSonicInDemo

# ===========================================================================
# ---------------------------------------------------------------------------
# Demo sequence	pointers
# ---------------------------------------------------------------------------
DemoDataPtr:	dc.l Demo_GHZ		/* demos run after the title screen */
		dc.l Demo_GHZ
		dc.l Demo_MZ
		dc.l Demo_MZ
		dc.l Demo_SYZ
		dc.l Demo_SYZ
		dc.l Demo_SS
		dc.l Demo_SS

DemoEndDataPtr:	dc.l Demo_EndGHZ1	/* demos run during the credits */
		dc.l Demo_EndMZ
		dc.l Demo_EndSYZ
		dc.l Demo_EndLZ
		dc.l Demo_EndSLZ
		dc.l Demo_EndSBZ1
		dc.l Demo_EndSBZ2
		dc.l Demo_EndGHZ2

		dc.b 0,	0x8B, 8,	0x37, 0,	0x42, 8,	0x5C, 0,	0x6A, 8,	0x5F, 0,	0x2F, 8,	0x2C
		dc.b 0,	0x21, 8,	3, 0x28,	0x30, 8,	8, 0, 0x2E, 8, 0x15, 0, 0xF, 8, 0x46
		dc.b 0,	0x1A, 8,	0xFF, 8,	0xCA, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
		.align 2

