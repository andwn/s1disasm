# ---------------------------------------------------------------------------
# Object 34 - zone title cards
# ---------------------------------------------------------------------------

TitleCard:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Card_Index(pc,d0.w),d1
		jmp	Card_Index(pc,d1.w)
# ===========================================================================
Card_Index:	dc.w Card_CheckSBZ3-Card_Index
		dc.w Card_ChkPos-Card_Index
		dc.w Card_Wait-Card_Index
		dc.w Card_Wait-Card_Index

.equ card_mainX, 0x30		/* position for card to display on */
.equ card_finalX, 0x32		/* position for card to finish on */
# ===========================================================================

Card_CheckSBZ3:	/* Routine 0 */
		movea.l	a0,a1
		moveq	#0,d0
		move.b	(v_zone).w,d0
		cmpi.w	#(id_LZ<<8)+3,(v_zone).w /* check if level is SBZ 3 */
		bne.s	Card_CheckFZ
		moveq	#5,d0		/* load title card number 5 (SBZ) */

	Card_CheckFZ:
		move.w	d0,d2
		cmpi.w	#(id_SBZ<<8)+2,(v_zone).w /* check if level is FZ */
		bne.s	Card_LoadConfig
		moveq	#6,d0		/* load title card number 6 (FZ) */
		moveq	#0xB,d2		/* use "FINAL" mappings */

	Card_LoadConfig:
		lea	(Card_ConData).l,a3
		lsl.w	#4,d0
		adda.w	d0,a3
		lea	(Card_ItemData).l,a2
		moveq	#3,d1

Card_Loop:
		move.b	#id_TitleCard,0(a1)
		move.w	(a3),obX(a1)	/* load start x-position */
		move.w	(a3)+,card_finalX(a1) /* load finish x-position (same as start) */
		move.w	(a3)+,card_mainX(a1) /* load main x-position */
		move.w	(a2)+,obScreenY(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,d0
		bne.s	Card_ActNumber
		move.b	d2,d0

	Card_ActNumber:
		cmpi.b	#7,d0
		bne.s	Card_MakeSprite
		add.b	(v_act).w,d0
		cmpi.b	#3,(v_act).w
		bne.s	Card_MakeSprite
		subq.b	#1,d0

	Card_MakeSprite:
		move.b	d0,obFrame(a1)	/* display frame	number d0 */
		move.l	#Map_Card,obMap(a1)
		move.w	#0x8580,obGfx(a1)
		move.b	#0x78,obActWid(a1)
		move.b	#0,obRender(a1)
		move.b	#0,obPriority(a1)
		move.w	#60,obTimeFrame(a1) /* set time delay to 1 second */
		lea	0x40(a1),a1	/* next object */
		dbf	d1,Card_Loop	/* repeat sequence another 3 times */

Card_ChkPos:	/* Routine 2 */
		moveq	#0x10,d1		/* set horizontal speed */
		move.w	card_mainX(a0),d0
		cmp.w	obX(a0),d0	/* has item reached the target position? */
		beq.s	Card_NoMove	/* if yes, branch */
		bge.s	Card_Move
		neg.w	d1

Card_Move:
		add.w	d1,obX(a0)	/* change item's position */

Card_NoMove:
		move.w	obX(a0),d0
		bmi.s	locret_C3D8
		cmpi.w	#0x200,d0	/* has item moved beyond	$200 on	x-axis? */
		bcc.s	locret_C3D8	/* if yes, branch */
		bra.w	DisplaySprite
# ===========================================================================

locret_C3D8:
		rts	
# ===========================================================================

Card_Wait:	/* Routine 4/6 */
		tst.w	obTimeFrame(a0)	/* is time remaining zero? */
		beq.s	Card_ChkPos2	/* if yes, branch */
		subq.w	#1,obTimeFrame(a0) /* subtract 1 from time */
		bra.w	DisplaySprite
# ===========================================================================

Card_ChkPos2:
		tst.b	obRender(a0)
		bpl.s	Card_ChangeArt
		moveq	#0x20,d1
		move.w	card_finalX(a0),d0
		cmp.w	obX(a0),d0	/* has item reached the finish position? */
		beq.s	Card_ChangeArt	/* if yes, branch */
		bge.s	Card_Move2
		neg.w	d1

Card_Move2:
		add.w	d1,obX(a0)	/* change item's position */
		move.w	obX(a0),d0
		bmi.s	locret_C412
		cmpi.w	#0x200,d0	/* has item moved beyond	$200 on	x-axis? */
		bcc.s	locret_C412	/* if yes, branch */
		bra.w	DisplaySprite
# ===========================================================================

locret_C412:
		rts	
# ===========================================================================

Card_ChangeArt:
		cmpi.b	#4,obRoutine(a0)
		bne.s	Card_Delete
		moveq	#plcid_Explode,d0
		jsr	(AddPLC).l	/* load explosion patterns */
		moveq	#0,d0
		move.b	(v_zone).w,d0
		addi.w	#plcid_GHZAnimals,d0
		jsr	(AddPLC).l	/* load animal patterns */

Card_Delete:
		bra.w	DeleteObject
# ===========================================================================
Card_ItemData:	dc.w 0xD0	/* y-axis position */
		dc.b 2,	0	/* routine number, frame	number (changes) */
		dc.w 0xE4
		dc.b 2,	6
		dc.w 0xEA
		dc.b 2,	7
		dc.w 0xE0
		dc.b 2,	0xA
# ---------------------------------------------------------------------------
# Title	card configuration data
# Format:
# 4 bytes per item (YYYY XXXX)
# 4 items per level (GREEN HILL, ZONE, ACT X, oval)
# ---------------------------------------------------------------------------
Card_ConData:	dc.w 0,	0x120, 0xFEFC, 0x13C, 0x414, 0x154, 0x214, 0x154 /* GHZ */
		dc.w 0,	0x120, 0xFEF4, 0x134, 0x40C, 0x14C, 0x20C, 0x14C /* LZ */
		dc.w 0,	0x120, 0xFEE0, 0x120, 0x3F8, 0x138, 0x1F8, 0x138 /* MZ */
		dc.w 0,	0x120, 0xFEFC, 0x13C, 0x414, 0x154, 0x214, 0x154 /* SLZ */
		dc.w 0,	0x120, 0xFF04, 0x144, 0x41C, 0x15C, 0x21C, 0x15C /* SYZ */
		dc.w 0,	0x120, 0xFF04, 0x144, 0x41C, 0x15C, 0x21C, 0x15C /* SBZ */
		dc.w 0,	0x120, 0xFEE4, 0x124, 0x3EC, 0x3EC, 0x1EC, 0x12C /* FZ */
# ===========================================================================

