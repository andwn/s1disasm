# ---------------------------------------------------------------------------
# Subroutine to	animate	level graphics
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


AnimateLevelGfx:
		tst.w	(f_pause).w	/* is the game paused? */
		bne.s	1f	/* if yes, branch */
		lea	(vdp_data_port).l,a6
		bsr.w	AniArt_GiantRing
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		move.w	AniArt_Index(pc,d0.w),d0
		jmp	AniArt_Index(pc,d0.w)

	1:
		rts	

# ===========================================================================
AniArt_Index:	dc.w AniArt_GHZ-AniArt_Index, AniArt_none-AniArt_Index
		dc.w AniArt_MZ-AniArt_Index, AniArt_none-AniArt_Index
		dc.w AniArt_none-AniArt_Index, AniArt_SBZ-AniArt_Index
		dc.w AniArt_Ending-AniArt_Index
#		zonewarning AniArt_Index,2
# ===========================================================================
# ---------------------------------------------------------------------------
# Animated pattern routine - Green Hill
# ---------------------------------------------------------------------------

AniArt_GHZ:

AniArt_GHZ_Waterfall:

.equ waterfallSize, 8	/* number of tiles per frame */

		subq.b	#1,(v_lani0_time).w /* decrement timer */
		bpl.s	AniArt_GHZ_Bigflower /* branch if not 0 */

		move.b	#5,(v_lani0_time).w /* time to display each frame */
		lea	(Art_GhzWater).l,a1 /* load waterfall patterns */
		move.b	(v_lani0_frame).w,d0
		addq.b	#1,(v_lani0_frame).w /* increment frame counter */
		andi.w	#1,d0		/* there are only 2 frames */
		beq.s	2f	/* branch if frame 0 */
		lea	waterfallSize*0x20(a1),a1 /* use graphics for frame 1 */

	2:
		locVRAM	0x6F00		/* VRAM address */
		move.w	#waterfallSize-1,d1	/* number of 8x8	tiles */
		bra.w	LoadTiles
# ===========================================================================

AniArt_GHZ_Bigflower:

.equ bigflowerSize, 16	/* number of tiles per frame */

		subq.b	#1,(v_lani1_time).w
		bpl.s	AniArt_GHZ_Smallflower

		move.b	#0xF,(v_lani1_time).w
		lea	(Art_GhzFlower1).l,a1 /*	load big flower	patterns */
		move.b	(v_lani1_frame).w,d0
		addq.b	#1,(v_lani1_frame).w
		andi.w	#1,d0
		beq.s	2f
		lea	bigflowerSize*0x20(a1),a1

	2:
		locVRAM	0x6B80
		move.w	#bigflowerSize-1,d1
		bra.w	LoadTiles
# ===========================================================================

AniArt_GHZ_Smallflower:

.equ smallflowerSize, 12	/* number of tiles per frame */

		subq.b	#1,(v_lani2_time).w
		bpl.s	2f

		move.b	#7,(v_lani2_time).w
		move.b	(v_lani2_frame).w,d0
		addq.b	#1,(v_lani2_frame).w /* increment frame counter */
		andi.w	#3,d0		/* there are 4 frames */
		move.b	smallflowerArray(pc,d0.w),d0
		btst	#0,d0		/* is frame 0 or 2? (actual frame, not frame counter) */
		bne.s	4f	/* if not, branch */
		move.b	#0x7F,(v_lani2_time).w /* set longer duration for frames 0 and 2 */

	4:
		lsl.w	#7,d0		/* multiply frame num by $80 */
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0		/* multiply that by 3 (i.e. frame num times 12 * $20) */
		locVRAM	0x6D80
		lea	(Art_GhzFlower2).l,a1 /*	load small flower patterns */
		lea	(a1,d0.w),a1	/* jump to appropriate tile */
		move.w	#smallflowerSize-1,d1
		bsr.w	LoadTiles

2:
		rts	

smallflowerArray:	dc.b 0,	1, 2, 1
# ===========================================================================
# ---------------------------------------------------------------------------
# Animated pattern routine - Marble
# ---------------------------------------------------------------------------

AniArt_MZ:

AniArt_MZ_Lava:

.equ lavaSize, 8	/* number of tiles per frame */

		subq.b	#1,(v_lani0_time).w /* decrement timer */
		bpl.s	AniArt_MZ_Magma	/* branch if not 0 */

		move.b	#0x13,(v_lani0_time).w /* time to display each frame */
		lea	(Art_MzLava1).l,a1 /* load lava surface patterns */
		moveq	#0,d0
		move.b	(v_lani0_frame).w,d0
		addq.b	#1,d0		/* increment frame counter */
		cmpi.b	#3,d0		/* there are 3 frames */
		bne.s	2f	/* branch if frame 0, 1 or 2 */
		moveq	#0,d0

	2:
		move.b	d0,(v_lani0_frame).w
		mulu.w	#lavaSize*0x20,d0
		adda.w	d0,a1		/* jump to appropriate tile */
		locVRAM	0x5C40
		move.w	#lavaSize-1,d1
		bsr.w	LoadTiles

AniArt_MZ_Magma:
		subq.b	#1,(v_lani1_time).w /* decrement timer */
		bpl.s	AniArt_MZ_Torch	/* branch if not 0 */
		
		move.b	#1,(v_lani1_time).w /* time between each gfx change */
		moveq	#0,d0
		move.b	(v_lani0_frame).w,d0 /* get surface lava frame number */
		lea	(Art_MzLava2).l,a4 /* load magma gfx */
		ror.w	#7,d0		/* multiply frame num by $200 */
		adda.w	d0,a4		/* jump to appropriate tile */
		locVRAM	0x5A40
		moveq	#0,d3
		move.b	(v_lani1_frame).w,d3
		addq.b	#1,(v_lani1_frame).w /* increment frame counter (unused) */
		move.b	(v_oscillate+0xA).w,d3 /* get oscillating value */
		move.w	#3,d2

	1:
		move.w	d3,d0
		add.w	d0,d0
		andi.w	#0x1E,d0
		lea	(AniArt_MZextra).l,a3
		move.w	(a3,d0.w),d0
		lea	(a3,d0.w),a3
		movea.l	a4,a1
		move.w	#0x1F,d1
		jsr	(a3)
		addq.w	#4,d3
		dbf d2,1b
		rts	
# ===========================================================================

AniArt_MZ_Torch:

.equ torchSize, 6	/* number of tiles per frame */

		subq.b	#1,(v_lani2_time).w /* decrement timer */
		bpl.w	2f		/* branch if not 0 */
		
		move.b	#7,(v_lani2_time).w /* time to display each frame */
		lea	(Art_MzTorch).l,a1 /* load torch	patterns */
		moveq	#0,d0
		move.b	(v_lani3_frame).w,d0
		addq.b	#1,(v_lani3_frame).w /* increment frame counter */
		andi.b	#3,(v_lani3_frame).w /* there are 3 frames */
		mulu.w	#torchSize*0x20,d0
		adda.w	d0,a1		/* jump to appropriate tile */
		locVRAM	0x5E40
		move.w	#torchSize-1,d1
		bra.w	LoadTiles

2:
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Animated pattern routine - Scrap Brain
# ---------------------------------------------------------------------------

AniArt_SBZ:

.equ sbSize, 12	/* number of tiles per frame */

		tst.b	(v_lani2_frame).w
		beq.s	2f	/* branch if counter hits 0 */
		
		subq.b	#1,(v_lani2_frame).w /* decrement counter */
		bra.s	3f
# ===========================================================================

2:
		subq.b	#1,(v_lani0_time).w /* decrement timer */
		bpl.s	3f /* branch if not 0 */
		
		move.b	#7,(v_lani0_time).w /* time to display each frame */
		lea	(Art_SbzSmoke).l,a1 /* load smoke patterns */
		locVRAM	0x8900
		move.b	(v_lani0_frame).w,d0
		addq.b	#1,(v_lani0_frame).w /* increment frame counter */
		andi.w	#7,d0
		beq.s	4f	/* branch if frame 0 */
		subq.w	#1,d0
		mulu.w	#sbSize*0x20,d0
		lea	(a1,d0.w),a1
		move.w	#sbSize-1,d1
		bra.w	LoadTiles
# ===========================================================================

4:
		move.b	#180,(v_lani2_frame).w /* time between smoke puffs (3 seconds) */

5:
		move.w	#(sbSize/2)-1,d1
		bsr.w	LoadTiles
		lea	(Art_SbzSmoke).l,a1
		move.w	#(sbSize/2)-1,d1
		bra.w	LoadTiles	/* load blank tiles for no smoke puff */
# ===========================================================================

3:
		tst.b	(v_lani2_time).w
		beq.s	6f	/* branch if counter hits 0 */
		
		subq.b	#1,(v_lani2_time).w /* decrement counter */
		bra.s	7f
# ===========================================================================

6:
		subq.b	#1,(v_lani1_time).w /* decrement timer */
		bpl.s	7f		/* branch if not 0 */
		
		move.b	#7,(v_lani1_time).w /* time to display each frame */
		lea	(Art_SbzSmoke).l,a1 /* load smoke patterns */
		locVRAM	0x8A80
		move.b	(v_lani1_frame).w,d0
		addq.b	#1,(v_lani1_frame).w /* increment frame counter */
		andi.w	#7,d0
		beq.s	8f	/* branch if frame 0 */
		subq.w	#1,d0
		mulu.w	#sbSize*0x20,d0
		lea	(a1,d0.w),a1
		move.w	#sbSize-1,d1
		bra.w	LoadTiles
# ===========================================================================

8:
		move.b	#120,(v_lani2_time).w /* time between smoke puffs (2 seconds) */
		bra.s	5b
# ===========================================================================

7:
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Animated pattern routine - ending sequence
# ---------------------------------------------------------------------------

AniArt_Ending:

AniArt_Ending_BigFlower:

.equ fsize1, 16	/* number of tiles per frame */

		subq.b	#1,(v_lani1_time).w /* decrement timer */
		bpl.s	AniArt_Ending_SmallFlower /* branch if not 0 */
		
		move.b	#7,(v_lani1_time).w
		lea	(Art_GhzFlower1).l,a1 /*	load big flower	patterns */
		lea	(0xFFFF9400).w,a2 /* load 2nd big flower from RAM */
		move.b	(v_lani1_frame).w,d0
		addq.b	#1,(v_lani1_frame).w /* increment frame counter */
		andi.w	#1,d0		/* only 2 frames */
		beq.s	2f	/* branch if frame 0 */
		lea	fsize1*0x20(a1),a1
		lea	fsize1*0x20(a2),a2

	2:
		locVRAM	0x6B80
		move.w	#fsize1-1,d1
		bsr.w	LoadTiles
		movea.l	a2,a1
		locVRAM	0x7200
		move.w	#fsize1-1,d1
		bra.w	LoadTiles
# ===========================================================================

AniArt_Ending_SmallFlower:

.equ fsize2, 12	/* number of tiles per frame */

		subq.b	#1,(v_lani2_time).w /* decrement timer */
		bpl.s	AniArt_Ending_Flower3 /* branch if not 0 */
		
		move.b	#7,(v_lani2_time).w
		move.b	(v_lani2_frame).w,d0
		addq.b	#1,(v_lani2_frame).w /* increment frame counter */
		andi.w	#7,d0		/* max 8 frames */
		move.b	f2Array(pc,d0.w),d0 /* get actual frame num from sequence data */
		lsl.w	#7,d0		/* multiply by $80 */
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0		/* multiply by 3 */
		locVRAM	0x6D80
		lea	(Art_GhzFlower2).l,a1 /*	load small flower patterns */
		lea	(a1,d0.w),a1	/* jump to appropriate tile */
		move.w	#fsize2-1,d1
		bra.w	LoadTiles
# ===========================================================================
f2Array:	dc.b 0,	0, 0, 1, 2, 2, 2, 1
# ===========================================================================

AniArt_Ending_Flower3:

.equ fsize3, 16	/* number of tiles per frame */

		subq.b	#1,(v_lani4_time).w /* decrement timer */
		bpl.s	AniArt_Ending_Flower4 /* branch if not 0 */
		
		move.b	#0xE,(v_lani4_time).w
		move.b	(v_lani4_frame).w,d0
		addq.b	#1,(v_lani4_frame).w /* increment frame counter */
		andi.w	#3,d0		/* max 4 frames */
		move.b	AniArt_Ending_Flower3_sequence(pc,d0.w),d0 /* get actual frame num from sequence data */
		lsl.w	#8,d0		/* multiply by $100 */
		add.w	d0,d0		/* multiply by 2 */
		locVRAM	0x7000
		lea	(0xFFFF9800).w,a1 /* load	special	flower patterns	(from RAM) */
		lea	(a1,d0.w),a1	/* jump to appropriate tile */
		move.w	#fsize3-1,d1
		bra.w	LoadTiles
# ===========================================================================
AniArt_Ending_Flower3_sequence:	dc.b 0,	1, 2, 1
# ===========================================================================

AniArt_Ending_Flower4:

.equ fsize4, 16	/* number of tiles per frame */

		subq.b	#1,(v_lani5_time).w /* decrement timer */
		bpl.s	2f		/* branch if not 0 */
		
		move.b	#0xB,(v_lani5_time).w
		move.b	(v_lani5_frame).w,d0
		addq.b	#1,(v_lani5_frame).w /* increment frame counter */
		andi.w	#3,d0
		move.b	AniArt_Ending_Flower3_sequence(pc,d0.w),d0 /* get actual frame num from sequence data */
		lsl.w	#8,d0		/* multiply by $100 */
		add.w	d0,d0		/* multiply by 2 */
		locVRAM	0x6800
		lea	(0xFFFF9E00).w,a1 /* load	special	flower patterns	(from RAM) */
		lea	(a1,d0.w),a1	/* jump to appropriate tile */
		move.w	#fsize4-1,d1
		bra.w	LoadTiles
# ===========================================================================

2:
		rts	
# ===========================================================================

AniArt_none:
		rts	

# ---------------------------------------------------------------------------
# Subroutine to	transfer graphics to VRAM

# input:
#	a1 = source address
#	a6 = vdp_data_port ($C00000)
#	d1 = number of tiles to load (minus one)
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LoadTiles:
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a6)
		dbf	d1,LoadTiles
		rts	
# End of function LoadTiles

# ===========================================================================
# ---------------------------------------------------------------------------
# Animated pattern routine - more Marble Zone
# ---------------------------------------------------------------------------
AniArt_MZextra:	dc.w loc_1C3EE-AniArt_MZextra, loc_1C3FA-AniArt_MZextra
		dc.w loc_1C410-AniArt_MZextra, loc_1C41E-AniArt_MZextra
		dc.w loc_1C434-AniArt_MZextra, loc_1C442-AniArt_MZextra
		dc.w loc_1C458-AniArt_MZextra, loc_1C466-AniArt_MZextra
		dc.w loc_1C47C-AniArt_MZextra, loc_1C48A-AniArt_MZextra
		dc.w loc_1C4A0-AniArt_MZextra, loc_1C4AE-AniArt_MZextra
		dc.w loc_1C4C4-AniArt_MZextra, loc_1C4D2-AniArt_MZextra
		dc.w loc_1C4E8-AniArt_MZextra, loc_1C4FA-AniArt_MZextra
# ===========================================================================

loc_1C3EE:
		move.l	(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C3EE
		rts	
# ===========================================================================

loc_1C3FA:
		move.l	2(a1),d0
		move.b	1(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C3FA
		rts	
# ===========================================================================

loc_1C410:
		move.l	2(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C410
		rts	
# ===========================================================================

loc_1C41E:
		move.l	4(a1),d0
		move.b	3(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C41E
		rts	
# ===========================================================================

loc_1C434:
		move.l	4(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C434
		rts	
# ===========================================================================

loc_1C442:
		move.l	6(a1),d0
		move.b	5(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C442
		rts	
# ===========================================================================

loc_1C458:
		move.l	6(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C458
		rts	
# ===========================================================================

loc_1C466:
		move.l	8(a1),d0
		move.b	7(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C466
		rts	
# ===========================================================================

loc_1C47C:
		move.l	8(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C47C
		rts	
# ===========================================================================

loc_1C48A:
		move.l	0xA(a1),d0
		move.b	9(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C48A
		rts	
# ===========================================================================

loc_1C4A0:
		move.l	0xA(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C4A0
		rts	
# ===========================================================================

loc_1C4AE:
		move.l	0xC(a1),d0
		move.b	0xB(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C4AE
		rts	
# ===========================================================================

loc_1C4C4:
		move.l	0xC(a1),(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C4C4
		rts	
# ===========================================================================

loc_1C4D2:
		move.l	0xC(a1),d0
		rol.l	#8,d0
		move.b	0(a1),d0
		nop /* padding for bindiff */
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C4D2
		rts	
# ===========================================================================

loc_1C4E8:
		move.w	0xE(a1),(a6)
		move.w	0(a1),(a6)
		nop /* padding for bindiff */
		lea	0x10(a1),a1
		dbf	d1,loc_1C4E8
		rts	
# ===========================================================================

loc_1C4FA:
		move.l	0(a1),d0
		nop /* padding for bindiff */
		move.b	0xF(a1),d0
		ror.l	#8,d0
		move.l	d0,(a6)
		lea	0x10(a1),a1
		dbf	d1,loc_1C4FA
		rts	

# ---------------------------------------------------------------------------
# Animated pattern routine - giant ring
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


AniArt_GiantRing:

.equ bigringSize, 14

		tst.w	(v_gfxbigring).w	/* Is there any of the art left to load? */
		bne.s	2f		/* If so, get to work */
		rts	
# ===========================================================================
# loc_1C518:
2:
		subi.w	#bigringSize*0x20,(v_gfxbigring).w	/* Count-down the 14 tiles we're going to load now */
		lea	(Art_BigRing).l,a1 /* load giant	ring patterns */
		moveq	#0,d0
		move.w	(v_gfxbigring).w,d0
		lea	(a1,d0.w),a1
#		 Turn VRAM address into VDP command
		addi.w	#0x8000,d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#0x4000,d0
		swap	d0
#		 Send VDP command (write to VRAM at address contained in v_gfxbigring)
		move.l	d0,4(a6)

		move.w	#bigringSize-1,d1
		bra.w	LoadTiles

# End of function AniArt_GiantRing

