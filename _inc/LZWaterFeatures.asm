# ---------------------------------------------------------------------------
# Subroutine to	do special water effects in Labyrinth Zone
# ---------------------------------------------------------------------------

LZWaterFeatures:
		cmpi.b	#id_LZ,(v_zone).w /* check if level is LZ */
		bne.s	1f	/* if not, branch */
		.if Revision==0
		.else
			tst.b   (f_nobgscroll).w
			bne.s	2f
		.endc
		cmpi.b	#6,(v_player+obRoutine).w /* has Sonic just died? */
		bcc.s	2f	/* if yes, skip other effects */

		bsr.w	LZWindTunnels
		bsr.w	LZWaterSlides
		bsr.w	LZDynamicWater

2:
		clr.b	(f_wtr_state).w
		moveq	#0,d0
		move.b	(v_oscillate+2).w,d0
		lsr.w	#1,d0
		add.w	(v_waterpos2).w,d0
		move.w	d0,(v_waterpos1).w
		move.w	(v_waterpos1).w,d0
		sub.w	(v_screenposy).w,d0
		bcc.s	3f
		tst.w	d0
		bpl.s	3f	/* if water is below top of screen, branch */

		move.b	#223,(v_hbla_line).w
		move.b	#1,(f_wtr_state).w /* screen is all underwater */

	3:
		cmpi.w	#223,d0		/* is water within 223 pixels of top of screen? */
		bcs.s	4f	/* if yes, branch */
		move.w	#223,d0

	4:
		move.b	d0,(v_hbla_line).w /* set water surface as on-screen */

1:
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Initial water heights
# ---------------------------------------------------------------------------
WaterHeight:	dc.w 0xB8	/* Labyrinth 1 */
		dc.w 0x328	/* Labyrinth 2 */
		dc.w 0x900	/* Labyrinth 3 */
		dc.w 0x228	/* Scrap Brain 3 */
		.align 2
# ===========================================================================

# ---------------------------------------------------------------------------
# Labyrinth dynamic water routines
# ---------------------------------------------------------------------------

LZDynamicWater:
		moveq	#0,d0
		move.b	(v_act).w,d0
		add.w	d0,d0
		move.w	DynWater_Index(pc,d0.w),d0
		jsr	DynWater_Index(pc,d0.w)
		moveq	#0,d1
		move.b	(f_water).w,d1
		move.w	(v_waterpos3).w,d0
		sub.w	(v_waterpos2).w,d0
		beq.s	1f		/* if water level is correct, branch */
		bcc.s	2f	/* if water level is too high, branch */
		neg.w	d1		/* set water to move up instead */

	2:
		add.w	d1,(v_waterpos2).w /* move water up/down */

	1:
		rts	
# ===========================================================================
DynWater_Index:	dc.w DynWater_LZ1-DynWater_Index
		dc.w DynWater_LZ2-DynWater_Index
		dc.w DynWater_LZ3-DynWater_Index
		dc.w DynWater_SBZ3-DynWater_Index
# ===========================================================================

DynWater_LZ1:
		move.w	(v_screenposx).w,d0
		move.b	(v_wtr_routine).w,d2
		bne.s	1f
		move.w	#0xB8,d1		/* water height */
		cmpi.w	#0x600,d0	/* has screen reached next position? */
		bcs.s	2f	/* if not, branch */
		move.w	#0x108,d1
		cmpi.w	#0x200,(v_player+obY).w /* is Sonic above $200 y-axis? */
		bcs.s	3f	/* if yes, branch */
		cmpi.w	#0xC00,d0
		bcs.s	2f
		move.w	#0x318,d1
		cmpi.w	#0x1080,d0
		bcs.s	2f
		move.b	#0x80,(f_switch+5).w
		move.w	#0x5C8,d1
		cmpi.w	#0x1380,d0
		bcs.s	2f
		move.w	#0x3A8,d1
		cmp.w	(v_waterpos2).w,d1 /* has water reached last height? */
		bne.s	2f	/* if not, branch */
		move.b	#1,(v_wtr_routine).w /* use second routine next */

	2:
		move.w	d1,(v_waterpos3).w
		rts	
# ===========================================================================

3:
		cmpi.w	#0xC80,d0
		bcs.s	2b
		move.w	#0xE8,d1
		cmpi.w	#0x1500,d0
		bcs.s	2b
		move.w	#0x108,d1
		bra.s	2b
# ===========================================================================

1:
		subq.b	#1,d2
		bne.s	4f
		cmpi.w	#0x2E0,(v_player+obY).w /* is Sonic above $2E0 y-axis? */
		bcc.s	4f		/* if not, branch */
		move.w	#0x3A8,d1
		cmpi.w	#0x1300,d0
		bcs.s	5f
		move.w	#0x108,d1
		move.b	#2,(v_wtr_routine).w

	5:
		move.w	d1,(v_waterpos3).w

	4:
		rts	
# ===========================================================================

DynWater_LZ2:
		move.w	(v_screenposx).w,d0
		move.w	#0x328,d1
		cmpi.w	#0x500,d0
		bcs.s	1f
		move.w	#0x3C8,d1
		cmpi.w	#0xB00,d0
		bcs.s	1f
		move.w	#0x428,d1

	1:
		move.w	d1,(v_waterpos3).w
		rts	
# ===========================================================================

DynWater_LZ3:
		move.w	(v_screenposx).w,d0
		move.b	(v_wtr_routine).w,d2
		bne.s	1f

		move.w	#0x900,d1
		cmpi.w	#0x600,d0	/* has screen reached position? */
		bcs.s	2f	/* if not, branch */
		cmpi.w	#0x3C0,(v_player+obY).w
		bcs.s	2f
		cmpi.w	#0x600,(v_player+obY).w /* is Sonic in a y-axis range? */
		bcc.s	2f	/* if not, branch */

		move.w	#0x4C8,d1	/* set new water height */
		move.b	#0x4B,(v_lvllayout+0x106).w /* update level layout */
		move.b	#1,(v_wtr_routine).w /* use second routine next */
		sfx	sfx_Rumbling,0,1,0 /* play sound $B7 (rumbling) */

	2:
		move.w	d1,(v_waterpos3).w
		move.w	d1,(v_waterpos2).w /* change water height instantly */
		rts	
# ===========================================================================

1:
		subq.b	#1,d2
		bne.s	3f
		move.w	#0x4C8,d1
		cmpi.w	#0x770,d0
		bcs.s	4f
		move.w	#0x308,d1
		cmpi.w	#0x1400,d0
		bcs.s	4f
		cmpi.w	#0x508,(v_waterpos3).w
		beq.s	5f
		cmpi.w	#0x600,(v_player+obY).w /* is Sonic below $600 y-axis? */
		bcc.s	5f	/* if yes, branch */
		cmpi.w	#0x280,(v_player+obY).w
		bcc.s	4f

5:
		move.w	#0x508,d1
		move.w	d1,(v_waterpos2).w
		cmpi.w	#0x1770,d0
		bcs.s	4f
		move.b	#2,(v_wtr_routine).w

	4:
		move.w	d1,(v_waterpos3).w
		rts	
# ===========================================================================

3:
		subq.b	#1,d2
		bne.s	6f
		move.w	#0x508,d1
		cmpi.w	#0x1860,d0
		bcs.s	7f
		move.w	#0x188,d1
		cmpi.w	#0x1AF0,d0
		bcc.s	8f
		cmp.w	(v_waterpos2).w,d1
		bne.s	7f

	8:
		move.b	#3,(v_wtr_routine).w

	7:
		move.w	d1,(v_waterpos3).w
		rts	
# ===========================================================================

6:
		subq.b	#1,d2
		bne.s	9f
		move.w	#0x188,d1
		cmpi.w	#0x1AF0,d0
		bcs.s	10f
		move.w	#0x900,d1
		cmpi.w	#0x1BC0,d0
		bcs.s	10f
		move.b	#4,(v_wtr_routine).w
		move.w	#0x608,(v_waterpos3).w
		move.w	#0x7C0,(v_waterpos2).w
		move.b	#1,(f_switch+8).w
		rts	
# ===========================================================================

10:
		move.w	d1,(v_waterpos3).w
		move.w	d1,(v_waterpos2).w
		rts	
# ===========================================================================

9:
		cmpi.w	#0x1E00,d0	/* has screen passed final position? */
		bcs.s	11f	/* if not, branch */
		move.w	#0x128,(v_waterpos3).w

	11:
		rts	
# ===========================================================================

DynWater_SBZ3:
		move.w	#0x228,d1
		cmpi.w	#0xF00,(v_screenposx).w
		bcs.s	1f
		move.w	#0x4C8,d1

	1:
		move.w	d1,(v_waterpos3).w
		rts

# ---------------------------------------------------------------------------
# Labyrinth Zone "wind tunnels"	subroutine
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LZWindTunnels:
		tst.w	(v_debuguse).w	/* is debug mode	being used? */
		bne.w	1f	/* if yes, branch */
		lea	(LZWind_Data+8).l,a2
		moveq	#0,d0
		move.b	(v_act).w,d0	/* get act number */
		lsl.w	#3,d0		/* multiply by 8 */
		adda.w	d0,a2		/* add to address for data */
		moveq	#0,d1
		tst.b	(v_act).w	/* is act number 1? */
		bne.s	2f	/* if not, branch */
		moveq	#1,d1
		subq.w	#8,a2		/* use different data for act 1 */

	2:
		lea	(v_player).w,a1

3:
		move.w	obX(a1),d0
		cmp.w	(a2),d0
		bcs.w	4f
		cmp.w	4(a2),d0
		bcc.w	4f
		move.w	obY(a1),d2
		cmp.w	2(a2),d2
		bcs.s	4f
		cmp.w	6(a2),d2
		bcc.s	4f	/* branch if Sonic is outside a range */
		move.b	(v_vbla_byte).w,d0
		andi.b	#0x3F,d0		/* does VInt counter fall on 0, $40, $80 or $C0? */
		bne.s	5f	/* if not, branch */
		sfx	sfx_Waterfall,0,0,0	/* play rushing water sound (only every $40 frames) */

	5:
		tst.b	(f_wtunnelallow).w /* are wind tunnels disabled? */
		bne.w	1f	/* if yes, branch */
		cmpi.b	#4,obRoutine(a1) /* is Sonic hurt/dying? */
		bcc.s	6f	/* if yes, branch */
		move.b	#1,(f_wtunnelmode).w
		subi.w	#0x80,d0
		cmp.w	(a2),d0
		bcc.s	7f
		moveq	#2,d0
		cmpi.b	#1,(v_act).w	/* is act number 2? */
		bne.s	8f	/* if not, branch */
		neg.w	d0

	8:
		add.w	d0,obY(a1)	/* adjust Sonic's y-axis for curve of tunnel */

7:
		addq.w	#4,obX(a1)
		move.w	#0x400,obVelX(a1) /* move Sonic horizontally */
		move.w	#0,obVelY(a1)
		move.b	#id_Float2,obAnim(a1)	/* use floating animation */
		bset	#1,obStatus(a1)
		btst	#0,(v_jpadhold2).w /* is up pressed? */
		beq.s	9f		/* if not, branch */
		subq.w	#1,obY(a1)	/* move Sonic up on pole */

	9:
		btst	#1,(v_jpadhold2).w /* is down being pressed? */
		beq.s	10f		/* if not, branch */
		addq.w	#1,obY(a1)	/* move Sonic down on pole */

	10:
		rts	
# ===========================================================================

4:
		addq.w	#8,a2		/* use second set of values (act 1 only) */
		dbf d1,3b	/* on act 1, repeat for a second tunnel */
		tst.b	(f_wtunnelmode).w /* is Sonic still in a tunnel? */
		beq.s	1f		/* if yes, branch */
		move.b	#id_Walk,obAnim(a1)	/* use walking animation */

6:
		clr.b	(f_wtunnelmode).w /* finish tunnel */

1:
		rts	
# End of function LZWindTunnels

# ===========================================================================

#		    left, top,  right, bottom boundaries
LZWind_Data:	dc.w 0xA80, 0x300, 0xC10,  0x380 /* act 1 values (set 1) */
		dc.w 0xF80, 0x100, 0x1410,	0x180 /* act 1 values (set 2) */
		dc.w 0x460, 0x400, 0x710,  0x480 /* act 2 values */
		dc.w 0xA20, 0x600, 0x1610, 0x6E0 /* act 3 values */
		dc.w 0xC80, 0x600, 0x13D0, 0x680 /* SBZ act 3 values */
		.align 2

# ---------------------------------------------------------------------------
# Labyrinth Zone water slide subroutine
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LZWaterSlides:
		lea	(v_player).w,a1
		btst	#1,obStatus(a1)	/* is Sonic jumping? */
		bne.s	loc_3F6A	/* if not, branch */
		move.w	obY(a1),d0
		lsr.w	#1,d0
		andi.w	#0x380,d0
		move.b	obX(a1),d1
		andi.w	#0x7F,d1
		add.w	d1,d0
		lea	(v_lvllayout).w,a2
		move.b	(a2,d0.w),d0
		lea	Slide_Chunks_End(pc),a2
		moveq	#Slide_Chunks_End-Slide_Chunks-1,d1

loc_3F62:
		cmp.b	-(a2),d0
		dbeq	d1,loc_3F62
		beq.s	LZSlide_Move

loc_3F6A:
		tst.b	(f_jumponly).w
		beq.s	locret_3F7A
		move.w	#5,0x3E(a1)
		clr.b	(f_jumponly).w

locret_3F7A:
		rts	
# ===========================================================================

LZSlide_Move:
		cmpi.w	#3,d1
		bcc.s	loc_3F84
		nop	

loc_3F84:
		bclr	#0,obStatus(a1)
		move.b	Slide_Speeds(pc,d1.w),d0
		move.b	d0,obInertia(a1)
		bpl.s	loc_3F9A
		bset	#0,obStatus(a1)

loc_3F9A:
		clr.b	obInertia+1(a1)
		move.b	#id_WaterSlide,obAnim(a1) /* use Sonic's "sliding" animation */
		move.b	#1,(f_jumponly).w /* lock controls (except jumping) */
		move.b	(v_vbla_byte).w,d0
		andi.b	#0x1F,d0
		bne.s	locret_3FBE
		sfx	sfx_Waterfall,0,0,0	/* play water sound */

locret_3FBE:
		rts	
# End of function LZWaterSlides

# ===========================================================================
# byte_3FC0:
Slide_Speeds:
		dc.b 0xA, 0xF5, 0xA, 0xF6, 0xF5, 0xF4, 0xB
		.align 2

Slide_Chunks:
		dc.b 2, 7, 3, 0x4C, 0x4B, 8, 4
# byte_3FCF
Slide_Chunks_End:
		.align 2
