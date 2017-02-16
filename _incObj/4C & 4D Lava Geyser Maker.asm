# ---------------------------------------------------------------------------
# Object 4C - lava geyser / lavafall producer (MZ)
# ---------------------------------------------------------------------------

GeyserMaker:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	GMake_Index(pc,d0.w),d1
		jsr	GMake_Index(pc,d1.w)
		bra.w	Geyser_ChkDel
# ===========================================================================
GMake_Index:	dc.w GMake_Main-GMake_Index
		dc.w GMake_Wait-GMake_Index
		dc.w GMake_ChkType-GMake_Index
		dc.w GMake_MakeLava-GMake_Index
		dc.w GMake_Display-GMake_Index
		dc.w GMake_Delete-GMake_Index

.equ gmake_time, 0x34		/* time delay (2 bytes) */
.equ gmake_timer, 0x32		/* current time remaining (2 bytes) */
.equ gmake_parent, 0x3C		/* address of parent object */
# ===========================================================================

GMake_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Geyser,obMap(a0)
		move.w	#0xE3A8,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#0x38,obActWid(a0)
		move.w	#120,gmake_time(a0) /* set time delay to 2 seconds */

GMake_Wait:	/* Routine 2 */
		subq.w	#1,gmake_timer(a0) /* decrement timer */
		bpl.s	1f		/* if time remains, branch */

		move.w	gmake_time(a0),gmake_timer(a0) /* reset timer */
		move.w	(v_player+obY).w,d0
		move.w	obY(a0),d1
		cmp.w	d1,d0
		bcc.s	1f
		subi.w	#0x170,d1
		cmp.w	d1,d0
		bcs.s	1f
		addq.b	#2,obRoutine(a0) /* if Sonic is within range, goto GMake_ChkType */

	1:
		rts	
# ===========================================================================

GMake_MakeLava:	/* Routine 6 */
		addq.b	#2,obRoutine(a0)
		bsr.w	FindNextFreeObj
		bne.s	1f
		move.b	#id_LavaGeyser,0(a1) /* load lavafall object */
		nop /* padding for bindiff */
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obSubtype(a0),obSubtype(a1)
		move.l	a0,gmake_parent(a1)

	1:
		move.b	#1,obAnim(a0)
		tst.b	obSubtype(a0)	/* is object type 0 (geyser) ? */
		beq.s	2f	/* if yes, branch */
		move.b	#4,obAnim(a0)
		bra.s	GMake_Display
# ===========================================================================

	2:
		movea.l	gmake_parent(a0),a1 /* get parent object address */
		bset	#1,obStatus(a1)
		move.w	#-0x580,obVelY(a1)
		bra.s	GMake_Display
# ===========================================================================

GMake_ChkType:	/* Routine 4 */
		tst.b	obSubtype(a0)	/* is object type 00 (geyser) ? */
		beq.s	GMake_Display	/* if yes, branch */
		addq.b	#2,obRoutine(a0)
		rts	
# ===========================================================================

GMake_Display:	/* Routine 8 */
		lea	(Ani_Geyser).l,a1
		bsr.w	AnimateSprite
		bsr.w	DisplaySprite
		rts	
# ===========================================================================

GMake_Delete:	/* Routine $A */
		move.b	#0,obAnim(a0)
		move.b	#2,obRoutine(a0)
		tst.b	obSubtype(a0)
		beq.w	DeleteObject
		rts	


# ---------------------------------------------------------------------------
# Object 4D - lava geyser / lavafall (MZ)
# ---------------------------------------------------------------------------

LavaGeyser:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Geyser_Index(pc,d0.w),d1
		jsr	Geyser_Index(pc,d1.w)
		bra.w	DisplaySprite
# ===========================================================================
Geyser_Index:	dc.w Geyser_Main-Geyser_Index
		dc.w Geyser_Action-Geyser_Index
		dc.w loc_EFFC-Geyser_Index
		dc.w Geyser_Delete-Geyser_Index

Geyser_Speeds:	dc.w 0xFB00, 0
# ===========================================================================

Geyser_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.w	obY(a0),0x30(a0)
		tst.b	obSubtype(a0)
		beq.s	1f
		subi.w	#0x250,obY(a0)

	1:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		move.w	Geyser_Speeds(pc,d0.w),obVelY(a0)
		movea.l	a0,a1
		moveq	#1,d1
		bsr.s	2f
		bra.s	3f
# ===========================================================================

	4:
		bsr.w	FindNextFreeObj
		bne.s	5f

2:
		move.b	#id_LavaGeyser,0(a1)
		nop /* padding for bindiff */
		move.l	#Map_Geyser,obMap(a1)
		move.w	#0x63A8,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#0x20,obActWid(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obSubtype(a0),obSubtype(a1)
		move.b	#1,obPriority(a1)
		move.b	#5,obAnim(a1)
		tst.b	obSubtype(a0)
		beq.s	5f
		move.b	#2,obAnim(a1)

	5:
		dbf d1,4b
		rts	
# ===========================================================================

3:
		addi.w	#0x60,obY(a1)
		move.w	0x30(a0),0x30(a1)
		addi.w	#0x60,0x30(a1)
		move.b	#0x93,obColType(a1)
		move.b	#0x80,obHeight(a1)
		bset	#4,obRender(a1)
		addq.b	#4,obRoutine(a1)
		move.l	a0,0x3C(a1)
		tst.b	obSubtype(a0)
		beq.s	6f
		moveq	#0,d1
		bsr.w	4b
		addq.b	#2,obRoutine(a1)
		bset	#4,obGfx(a1)
		addi.w	#0x100,obY(a1)
		move.b	#0,obPriority(a1)
		move.w	0x30(a0),0x30(a1)
		move.l	0x3C(a0),0x3C(a1)
		move.b	#0,obSubtype(a0)

	6:
		sfx	sfx_Burning,0,0,0	/* play flame sound */

Geyser_Action:	/* Routine 2 */
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		move.w	Geyser_Types(pc,d0.w),d1
		jsr	Geyser_Types(pc,d1.w)
		bsr.w	SpeedToPos
		lea	(Ani_Geyser).l,a1
		bsr.w	AnimateSprite

Geyser_ChkDel:
		out_of_range	DeleteObject
		rts	
# ===========================================================================
Geyser_Types:	dc.w Geyser_Type00-Geyser_Types
		dc.w Geyser_Type01-Geyser_Types
# ===========================================================================

Geyser_Type00:
		addi.w	#0x18,obVelY(a0)	/* increase object's falling speed */
		move.w	0x30(a0),d0
		cmp.w	obY(a0),d0
		bcc.s	locret_EFDA
		addq.b	#4,obRoutine(a0)
		movea.l	0x3C(a0),a1
		move.b	#3,obAnim(a1)

locret_EFDA:
		rts	
# ===========================================================================

Geyser_Type01:
		addi.w	#0x18,obVelY(a0)	/* increase object's falling speed */
		move.w	0x30(a0),d0
		cmp.w	obY(a0),d0
		bcc.s	locret_EFFA
		addq.b	#4,obRoutine(a0)
		movea.l	0x3C(a0),a1
		move.b	#1,obAnim(a1)

locret_EFFA:
		rts	
# ===========================================================================

loc_EFFC:	/* Routine 4 */
		movea.l	0x3C(a0),a1
		cmpi.b	#6,obRoutine(a1)
		beq.w	Geyser_Delete
		move.w	obY(a1),d0
		addi.w	#0x60,d0
		move.w	d0,obY(a0)
		sub.w	0x30(a0),d0
		neg.w	d0
		moveq	#8,d1
		cmpi.w	#0x40,d0
		bge.s	loc_F026
		moveq	#0xB,d1

loc_F026:
		cmpi.w	#0x80,d0
		ble.s	loc_F02E
		moveq	#0xE,d1

loc_F02E:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_F04C
		move.b	#7,obTimeFrame(a0)
		addq.b	#1,obAniFrame(a0)
		cmpi.b	#2,obAniFrame(a0)
		bcs.s	loc_F04C
		move.b	#0,obAniFrame(a0)

loc_F04C:
		move.b	obAniFrame(a0),d0
		add.b	d1,d0
		move.b	d0,obFrame(a0)
		bra.w	Geyser_ChkDel
# ===========================================================================

Geyser_Delete:	/* Routine 6 */
		bra.w	DeleteObject

