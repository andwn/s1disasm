# ---------------------------------------------------------------------------
# Object 51 - smashable	green block (MZ)
# ---------------------------------------------------------------------------

SmashBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Smab_Index(pc,d0.w),d1
		jsr	Smab_Index(pc,d1.w)
		bra.w	RememberState
# ===========================================================================
Smab_Index:	dc.w Smab_Main-Smab_Index
		dc.w Smab_Solid-Smab_Index
		dc.w Smab_Points-Smab_Index
# ===========================================================================

Smab_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Smab,obMap(a0)
		move.w	#0x42B8,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),obFrame(a0)

Smab_Solid:	/* Routine 2 */

.equ sonicAniFrame, 0x32		/* Sonic's current animation number */
.equ hitCount, 0x34		/* number of blocks hit + previous stuff */

		move.w	(v_itembonus).w,0x34(a0)
		move.b	(v_player+obAnim).w,sonicAniFrame(a0) /* load Sonic's animation number */
		move.w	#0x1B,d1
		move.w	#0x10,d2
		move.w	#0x11,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#3,obStatus(a0)	/* has Sonic landed on the block? */
		bne.s	2f		/* if yes, branch */

	3:
		rts	
# ===========================================================================

2:
		cmpi.b	#id_Roll,sonicAniFrame(a0) /* is Sonic rolling/jumping? */
		bne.s	3b	/* if not, branch */
		move.w	hitCount(a0),(v_itembonus).w
		bset	#2,obStatus(a1)
		move.b	#0xE,obHeight(a1)
		move.b	#7,obWidth(a1)
		move.b	#id_Roll,obAnim(a1) /* make Sonic roll */
		move.w	#-0x300,obVelY(a1) /* rebound Sonic */
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)
		bclr	#3,obStatus(a0)
		clr.b	obSolid(a0)
		move.b	#1,obFrame(a0)
		lea	(Smab_Speeds).l,a4 /* load broken fragment speed data */
		moveq	#3,d1		/* set number of	fragments to 4 */
		move.w	#0x38,d2
		bsr.w	SmashObject
		bsr.w	FindFreeObj
		bne.s	Smab_Points
		move.b	#id_Points,0(a1) /* load points object */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	(v_itembonus).w,d2
		addq.w	#2,(v_itembonus).w /* increment bonus counter */
		cmpi.w	#6,d2		/* have fewer than 3 blocks broken? */
		bcs.s	4f		/* if yes, branch */
		moveq	#6,d2		/* set cap for points */

	4:
		moveq	#0,d0
		move.w	Smab_Scores(pc,d2.w),d0
		cmpi.w	#0x20,(v_itembonus).w /* have 16 blocks been smashed? */
		bcs.s	5f	/* if not, branch */
		move.w	#1000,d0	/* give higher points for 16th block */
		moveq	#10,d2

	5:
		jsr	(AddPoints).l
		lsr.w	#1,d2
		move.b	d2,obFrame(a1)

Smab_Points:	/* Routine 4 */
		bsr.w	SpeedToPos
		addi.w	#0x38,obVelY(a0)
		bsr.w	DisplaySprite
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		rts	
# ===========================================================================
Smab_Speeds:	dc.w -0x200, -0x200	/* x-speed, y-speed */
		dc.w -0x100, -0x100
		dc.w 0x200, -0x200
		dc.w 0x100, -0x100

Smab_Scores:	dc.w 10, 20, 50, 100

