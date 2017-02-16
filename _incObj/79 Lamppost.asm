# ---------------------------------------------------------------------------
# Object 79 - lamppost
# ---------------------------------------------------------------------------

Lamppost:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Lamp_Index(pc,d0.w),d1
		jsr	Lamp_Index(pc,d1.w)
		jmp	(RememberState).l
# ===========================================================================
Lamp_Index:	dc.w Lamp_Main-Lamp_Index
		dc.w Lamp_Blue-Lamp_Index
		dc.w Lamp_Finish-Lamp_Index
		dc.w Lamp_Twirl-Lamp_Index

.equ lamp_origX, 0x30		/* original x-axis position */
.equ lamp_origY, 0x32		/* original y-axis position */
.equ lamp_time, 0x36		/* length of time to twirl the lamp */
# ===========================================================================

Lamp_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Lamp,obMap(a0)
		move.w	#0x7A0,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#8,obActWid(a0)
		move.b	#5,obPriority(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bclr	#7,2(a2,d0.w)
		btst	#0,2(a2,d0.w)
		bne.s	1f
		move.b	(v_lastlamp).w,d1
		andi.b	#0x7F,d1
		move.b	obSubtype(a0),d2 /* get lamppost number */
		andi.b	#0x7F,d2
		cmp.b	d2,d1		/* is this a "new" lamppost? */
		bcs.s	Lamp_Blue	/* if yes, branch */

1:
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0) /* goto Lamp_Finish next */
		move.b	#3,obFrame(a0)	/* use red lamppost frame */
		rts	
# ===========================================================================

Lamp_Blue:	/* Routine 2 */
		tst.w	(v_debuguse).w	/* is debug mode	being used? */
		bne.w	1f	/* if yes, branch */
		tst.b	(f_lockmulti).w
		bmi.w	1f
		move.b	(v_lastlamp).w,d1
		andi.b	#0x7F,d1
		move.b	obSubtype(a0),d2
		andi.b	#0x7F,d2
		cmp.b	d2,d1		/* is this a "new" lamppost? */
		bcs.s	2f		/* if yes, branch */
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0)
		move.b	#3,obFrame(a0)
		bra.w	1f
# ===========================================================================

2:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		addq.w	#8,d0
		cmpi.w	#0x10,d0
		bcc.w	1f
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		addi.w	#0x40,d0
		cmpi.w	#0x68,d0
		bcc.s	1f

		sfx	sfx_Lamppost,0,0,0	/* play lamppost sound */
		addq.b	#2,obRoutine(a0)
		jsr	(FindFreeObj).l
		bne.s	3f
		move.b	#id_Lamppost,0(a1)	/* load twirling	lamp object */
		nop /* padding for bindiff */
		move.b	#6,obRoutine(a1) /* goto Lamp_Twirl next */
		move.w	obX(a0),lamp_origX(a1)
		move.w	obY(a0),lamp_origY(a1)
		subi.w	#0x18,lamp_origY(a1)
		move.l	#Map_Lamp,obMap(a1)
		move.w	#0x7A0,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#8,obActWid(a1)
		move.b	#4,obPriority(a1)
		move.b	#2,obFrame(a1)	/* use "ball only" frame */
		move.w	#0x20,lamp_time(a1)

	3:
		move.b	#1,obFrame(a0)	/* use "post only" frame */
		bsr.w	Lamp_StoreInfo
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)

	1:
		rts	
# ===========================================================================

Lamp_Finish:	/* Routine 4 */
		rts	
# ===========================================================================

Lamp_Twirl:	/* Routine 6 */
		subq.w	#1,lamp_time(a0) /* decrement timer */
		bpl.s	1f	/* if time remains, keep twirling */
		move.b	#4,obRoutine(a0) /* goto Lamp_Finish next */

	1:
		move.b	obAngle(a0),d0
		subi.b	#0x10,obAngle(a0)
		subi.b	#0x40,d0
		jsr	(CalcSine).l
		muls.w	#0xC00,d1
		swap	d1
		add.w	lamp_origX(a0),d1
		move.w	d1,obX(a0)
		muls.w	#0xC00,d0
		swap	d0
		add.w	lamp_origY(a0),d0
		move.w	d0,obY(a0)
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Subroutine to	store information when you hit a lamppost
# ---------------------------------------------------------------------------

Lamp_StoreInfo:
		move.b	obSubtype(a0),(v_lastlamp).w 	/* lamppost number */
		move.b	(v_lastlamp).w,(0xFFFFFE31).w
		move.w	obX(a0),(0xFFFFFE32).w		/* x-position */
		move.w	obY(a0),(0xFFFFFE34).w		/* y-position */
		move.w	(v_rings).w,(0xFFFFFE36).w 	/* rings */
		move.b	(v_lifecount).w,(0xFFFFFE54).w 	/* lives */
		move.l	(v_time).w,(0xFFFFFE38).w 	/* time */
		move.b	(v_dle_routine).w,(0xFFFFFE3C).w /* routine counter for dynamic level mod */
		move.w	(v_limitbtm2).w,(0xFFFFFE3E).w 	/* lower y-boundary of level */
		move.w	(v_screenposx).w,(0xFFFFFE40).w 	/* screen x-position */
		move.w	(v_screenposy).w,(0xFFFFFE42).w 	/* screen y-position */
		move.w	(v_bgscreenposx).w,(0xFFFFFE44).w /* bg position */
		move.w	(v_bgscreenposy).w,(0xFFFFFE46).w 	/* bg position */
		move.w	(v_bg2screenposx).w,(0xFFFFFE48).w 	/* bg position */
		move.w	(v_bg2screenposy).w,(0xFFFFFE4A).w 	/* bg position */
		move.w	(v_bg3screenposx).w,(0xFFFFFE4C).w 	/* bg position */
		move.w	(v_bg3screenposy).w,(0xFFFFFE4E).w 	/* bg position */
		move.w	(v_waterpos2).w,(0xFFFFFE50).w 	/* water height */
		move.b	(v_wtr_routine).w,(0xFFFFFE52).w /* rountine counter for water */
		move.b	(f_wtr_state).w,(0xFFFFFE53).w 	/* water direction */
		rts	

# ---------------------------------------------------------------------------
# Subroutine to	load stored info when you start	a level	from a lamppost
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Lamp_LoadInfo:
		move.b	(0xFFFFFE31).w,(v_lastlamp).w
		move.w	(0xFFFFFE32).w,(v_player+obX).w
		move.w	(0xFFFFFE34).w,(v_player+obY).w
		move.w	(0xFFFFFE36).w,(v_rings).w
		move.b	(0xFFFFFE54).w,(v_lifecount).w
		clr.w	(v_rings).w
		clr.b	(v_lifecount).w
		move.l	(0xFFFFFE38).w,(v_time).w
		move.b	#59,(v_timecent).w
		subq.b	#1,(v_timesec).w
		move.b	(0xFFFFFE3C).w,(v_dle_routine).w
		move.b	(0xFFFFFE52).w,(v_wtr_routine).w
		move.w	(0xFFFFFE3E).w,(v_limitbtm2).w
		move.w	(0xFFFFFE3E).w,(v_limitbtm1).w
		move.w	(0xFFFFFE40).w,(v_screenposx).w
		move.w	(0xFFFFFE42).w,(v_screenposy).w
		move.w	(0xFFFFFE44).w,(v_bgscreenposx).w
		move.w	(0xFFFFFE46).w,(v_bgscreenposy).w
		move.w	(0xFFFFFE48).w,(v_bg2screenposx).w
		move.w	(0xFFFFFE4A).w,(v_bg2screenposy).w
		move.w	(0xFFFFFE4C).w,(v_bg3screenposx).w
		move.w	(0xFFFFFE4E).w,(v_bg3screenposy).w
		cmpi.b	#1,(v_zone).w	/* is this Labyrinth Zone? */
		bne.s	1f	/* if not, branch */

		move.w	(0xFFFFFE50).w,(v_waterpos2).w
		move.b	(0xFFFFFE52).w,(v_wtr_routine).w
		move.b	(0xFFFFFE53).w,(f_wtr_state).w

	1:
		tst.b	(v_lastlamp).w
		bpl.s	locret_170F6
		move.w	(0xFFFFFE32).w,d0
		subi.w	#0xA0,d0
		move.w	d0,(v_limitleft2).w

locret_170F6:
		rts	

