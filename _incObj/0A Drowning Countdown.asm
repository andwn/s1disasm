# ---------------------------------------------------------------------------
# Object 0A - drowning countdown numbers and small bubbles that float out of
# Sonic's mouth (LZ)
# ---------------------------------------------------------------------------

DrownCount:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Drown_Index(pc,d0.w),d1
		jmp	Drown_Index(pc,d1.w)
# ===========================================================================
Drown_Index:
ptr_Drown_Main:		dc.w Drown_Main-Drown_Index
ptr_Drown_Animate:	dc.w Drown_Animate-Drown_Index
ptr_Drown_ChkWater:	dc.w Drown_ChkWater-Drown_Index
ptr_Drown_Display:	dc.w Drown_Display-Drown_Index
ptr_Drown_Delete:	dc.w Drown_Delete-Drown_Index
ptr_Drown_Countdown:	dc.w Drown_Countdown-Drown_Index
ptr_Drown_AirLeft:	dc.w Drown_AirLeft-Drown_Index
			dc.w Drown_Display-Drown_Index
			dc.w Drown_Delete-Drown_Index

.equ drown_origX, 0x30		/* original x-axis position */
.equ drown_time, 0x38		/* time between each number changes */

.equ id_Drown_Main, ptr_Drown_Main-Drown_Index		/* 0 */
.equ id_Drown_Animate, ptr_Drown_Animate-Drown_Index		/* 2 */
.equ id_Drown_ChkWater, ptr_Drown_ChkWater-Drown_Index	/* 4 */
.equ id_Drown_Display, ptr_Drown_Display-Drown_Index		/* 6 */
.equ id_Drown_Delete, ptr_Drown_Delete-Drown_Index		/* 8 */
.equ id_Drown_Countdown, ptr_Drown_Countdown-Drown_Index	/* $A */
.equ id_Drown_AirLeft, ptr_Drown_AirLeft-Drown_Index		/* $C */
# ===========================================================================

Drown_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bub,obMap(a0)
		move.w	#0x8348,obGfx(a0)
		move.b	#0x84,obRender(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	obSubtype(a0),d0 /* get bubble type */
		bpl.s	1f	/* branch if $00-$7F */

		addq.b	#8,obRoutine(a0) /* goto Drown_Countdown next */
		move.l	#Map_Drown,obMap(a0)
		move.w	#0x440,obGfx(a0)
		andi.w	#0x7F,d0
		move.b	d0,0x33(a0)
		bra.w	Drown_Countdown
# ===========================================================================

1:
		move.b	d0,obAnim(a0)
		move.w	obX(a0),drown_origX(a0)
		move.w	#-0x88,obVelY(a0)

Drown_Animate:	/* Routine 2 */
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l

Drown_ChkWater:	/* Routine 4 */
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	/* has bubble reached the water surface? */
		bcs.s	1f		/* if not, branch */

		move.b	#id_Drown_Display,obRoutine(a0) /* goto Drown_Display next */
		addq.b	#7,obAnim(a0)
		cmpi.b	#0xD,obAnim(a0)
		beq.s	Drown_Display
		bra.s	Drown_Display
# ===========================================================================

1:
		tst.b	(f_wtunnelmode).w /* is Sonic in a water tunnel? */
		beq.s	2f	/* if not, branch */
		addq.w	#4,drown_origX(a0)

	2:
		move.b	obAngle(a0),d0
		addq.b	#1,obAngle(a0)
		andi.w	#0x7F,d0
		lea	(Drown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	drown_origX(a0),d0
		move.w	d0,obX(a0)
		bsr.s	Drown_ShowNumber
		jsr	(SpeedToPos).l
		tst.b	obRender(a0)
		bpl.s	3f
		jmp	(DisplaySprite).l

	3:
		jmp	(DeleteObject).l
# ===========================================================================

Drown_Display:	/* Routine 6, Routine $E */
		bsr.s	Drown_ShowNumber
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
# ===========================================================================

Drown_Delete:	/* Routine 8, Routine $10 */
		jmp	(DeleteObject).l
# ===========================================================================

Drown_AirLeft:	/* Routine $C */
		cmpi.w	#0xC,(v_air).w	/* check air remaining */
		bhi.s	Drown_AirLeft_Delete		/* if higher than $C, branch */
		subq.w	#1,drown_time(a0)
		bne.s	1f
		move.b	#id_Drown_Display+8,obRoutine(a0) /* goto Drown_Display next */
		addq.b	#7,obAnim(a0)
		bra.s	Drown_Display
# ===========================================================================

	1:
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l
		tst.b	obRender(a0)
		bpl.s	Drown_AirLeft_Delete
		jmp	(DisplaySprite).l

Drown_AirLeft_Delete:	
		jmp	(DeleteObject).l
# ===========================================================================

Drown_ShowNumber:
		tst.w	drown_time(a0)
		beq.s	1f
		subq.w	#1,drown_time(a0)	/* decrement timer */
		bne.s	1f	/* if time remains, branch */
		cmpi.b	#7,obAnim(a0)
		bcc.s	1f

		move.w	#15,drown_time(a0)
		clr.w	obVelY(a0)
		move.b	#0x80,obRender(a0)
		move.w	obX(a0),d0
		sub.w	(v_screenposx).w,d0
		addi.w	#0x80,d0
		move.w	d0,obX(a0)
		move.w	obY(a0),d0
		sub.w	(v_screenposy).w,d0
		addi.w	#0x80,d0
		move.w	d0,obScreenY(a0)
		move.b	#id_Drown_AirLeft,obRoutine(a0) /* goto Drown_AirLeft next */

	1:
		rts	
# ===========================================================================
Drown_WobbleData:
		.if Revision==0
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		.else
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		.endc
# ===========================================================================

Drown_Countdown:/* Routine $A */
		tst.w	0x2C(a0)
		bne.w	1f
		cmpi.b	#6,(v_player+obRoutine).w
		bcc.w	2f
		btst	#6,(v_player+obStatus).w /* is Sonic underwater? */
		beq.w	2f	/* if not, branch */

		subq.w	#1,drown_time(a0)	/* decrement timer */
		bpl.w	3f	/* branch if time remains */
		move.w	#59,drown_time(a0)
		move.w	#1,0x36(a0)
		jsr	(RandomNumber).l
		andi.w	#1,d0
		move.b	d0,0x34(a0)
		move.w	(v_air).w,d0	/* check air remaining */
		cmpi.w	#25,d0
		beq.s	4f	/* play sound if	air is 25 */
		cmpi.w	#20,d0
		beq.s	4f
		cmpi.w	#15,d0
		beq.s	4f
		cmpi.w	#12,d0
		bhi.s	5f	/* if air is above 12, branch */

		bne.s	6f	/* if air is less than 12, branch */
		music	bgm_Drowning,0,0,0	/* play countdown music */

	6:
		subq.b	#1,0x32(a0)
		bpl.s	5f
		move.b	0x33(a0),0x32(a0)
		bset	#7,0x36(a0)
		bra.s	5f
# ===========================================================================

4:
		sfx	sfx_Warning,0,0,0	/* play "ding-ding" warning sound */

5:
		subq.w	#1,(v_air).w	/* subtract 1 from air remaining */
		bcc.w	7f	/* if air is above 0, branch */

#		 Sonic drowns here
		bsr.w	ResumeMusic
		move.b	#0x81,(f_lockmulti).w /* lock controls */
		sfx	sfx_Drown,0,0,0	/* play drowning sound */
		move.b	#0xA,0x34(a0)
		move.w	#1,0x36(a0)
		move.w	#0x78,0x2C(a0)
		move.l	a0,-(sp)
		lea	(v_player).w,a0
		bsr.w	Sonic_ResetOnFloor
		move.b	#id_Drown,obAnim(a0)	/* use Sonic's drowning animation */
		bset	#1,obStatus(a0)
		bset	#7,obGfx(a0)
		move.w	#0,obVelY(a0)
		move.w	#0,obVelX(a0)
		move.w	#0,obInertia(a0)
		move.b	#1,(f_nobgscroll).w
		movea.l	(sp)+,a0
		rts	
# ===========================================================================

1:
		subq.w	#1,0x2C(a0)
		bne.s	8f
		move.b	#6,(v_player+obRoutine).w
		rts	
# ===========================================================================

	8:
		move.l	a0,-(sp)
		lea	(v_player).w,a0
		jsr	(SpeedToPos).l
		addi.w	#0x10,obVelY(a0)
		movea.l	(sp)+,a0
		bra.s	3f
# ===========================================================================

7:
		bra.s	9f
# ===========================================================================

3:
		tst.w	0x36(a0)
		beq.w	2f
		subq.w	#1,0x3A(a0)
		bpl.w	2f

9:
		jsr	(RandomNumber).l
		andi.w	#0xF,d0
		move.w	d0,0x3A(a0)
		jsr	(FindFreeObj).l
		bne.w	2f
		move.b	#id_DrownCount,0(a1) /* load object */
		nop /* padding for bindiff */
		move.w	(v_player+obX).w,obX(a1) /* match X position to Sonic */
		moveq	#6,d0
		btst	#0,(v_player+obStatus).w
		beq.s	10f
		neg.w	d0
		move.b	#0x40,obAngle(a1)

	10:
		add.w	d0,obX(a1)
		move.w	(v_player+obY).w,obY(a1)
		move.b	#6,obSubtype(a1)
		tst.w	0x2C(a0)
		beq.w	11f
		andi.w	#7,0x3A(a0)
		addi.w	#0,0x3A(a0)
		move.w	(v_player+obY).w,d0
		subi.w	#0xC,d0
		move.w	d0,obY(a1)
		jsr	(RandomNumber).l
		move.b	d0,obAngle(a1)
		move.w	(v_framecount).w,d0
		andi.b	#3,d0
		bne.s	12f
		move.b	#0xE,obSubtype(a1)
		bra.s	12f
# ===========================================================================

11:
		btst	#7,0x36(a0)
		beq.s	12f
		move.w	(v_air).w,d2
		lsr.w	#1,d2
		jsr	(RandomNumber).l
		andi.w	#3,d0
		bne.s	13f
		bset	#6,0x36(a0)
		bne.s	12f
		move.b	d2,obSubtype(a1)
		move.w	#0x1C,drown_time(a1)

	13:
		tst.b	0x34(a0)
		bne.s	12f
		bset	#6,0x36(a0)
		bne.s	12f
		move.b	d2,obSubtype(a1)
		move.w	#0x1C,drown_time(a1)

12:
		subq.b	#1,0x34(a0)
		bpl.s	2f
		clr.w	0x36(a0)

2:
		rts	

