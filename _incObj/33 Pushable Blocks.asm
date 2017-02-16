# ---------------------------------------------------------------------------
# Object 33 - pushable blocks (MZ, LZ)
# ---------------------------------------------------------------------------

PushBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	PushB_Index(pc,d0.w),d1
		jmp	PushB_Index(pc,d1.w)
# ===========================================================================
PushB_Index:	dc.w PushB_Main-PushB_Index
		dc.w loc_BF6E-PushB_Index
		dc.w loc_C02C-PushB_Index

PushB_Var:	dc.b 0x10, 0	/* object width,	frame number */
		dc.b 0x40, 1
# ===========================================================================

PushB_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.b	#0xF,obHeight(a0)
		move.b	#0xF,obWidth(a0)
		move.l	#Map_Push,obMap(a0)
		move.w	#0x42B8,obGfx(a0) /* MZ specific code */
		cmpi.b	#1,(v_zone).w
		bne.s	1f
		move.w	#0x43DE,obGfx(a0) /* LZ specific code */

	1:
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.w	obX(a0),0x34(a0)
		move.w	obY(a0),0x36(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		andi.w	#0xE,d0
		lea	PushB_Var(pc,d0.w),a2
		move.b	(a2)+,obActWid(a0)
		move.b	(a2)+,obFrame(a0)
		tst.b	obSubtype(a0)
		beq.s	2f
		move.w	#0xC2B8,obGfx(a0)

	2:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	loc_BF6E
		bclr	#7,2(a2,d0.w)
		bset	#0,2(a2,d0.w)
		bne.w	DeleteObject

loc_BF6E:	/* Routine 2 */
		tst.b	0x32(a0)
		bne.w	loc_C046
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		move.w	#0x10,d2
		move.w	#0x11,d3
		move.w	obX(a0),d4
		bsr.w	loc_C186
		cmpi.w	#(id_MZ<<8)+0,(v_zone).w /* is the level MZ act 1? */
		bne.s	loc_BFC6	/* if not, branch */
		bclr	#7,obSubtype(a0)
		move.w	obX(a0),d0
		cmpi.w	#0xA20,d0
		bcs.s	loc_BFC6
		cmpi.w	#0xAA1,d0
		bcc.s	loc_BFC6
		move.w	(v_obj31ypos).w,d0
		subi.w	#0x1C,d0
		move.w	d0,obY(a0)
		bset	#7,(v_obj31ypos).w
		bset	#7,obSubtype(a0)

	loc_BFC6:
		out_of_range_s	loc_ppppp
		bra.w	DisplaySprite
# ===========================================================================

loc_ppppp:
		out_of_range_s	loc_C016,0x34(a0)
		move.w	0x34(a0),obX(a0)
		move.w	0x36(a0),obY(a0)
		move.b	#4,obRoutine(a0)
		bra.s	loc_C02C
# ===========================================================================

loc_C016:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	loc_C028
		bclr	#0,2(a2,d0.w)

loc_C028:
		bra.w	DeleteObject
# ===========================================================================

loc_C02C:	/* Routine 4 */
		bsr.w	ChkPartiallyVisible
		beq.s	locret_C044
		move.b	#2,obRoutine(a0)
		clr.b	0x32(a0)
		clr.w	obVelX(a0)
		clr.w	obVelY(a0)

locret_C044:
		rts	
# ===========================================================================

loc_C046:
		move.w	obX(a0),-(sp)
		cmpi.b	#4,ob2ndRout(a0)
		bcc.s	loc_C056
		bsr.w	SpeedToPos

loc_C056:
		btst	#1,obStatus(a0)
		beq.s	loc_C0A0
		addi.w	#0x18,obVelY(a0)
		jsr	(ObjFloorDist).l
		tst.w	d1
		bpl.w	loc_C09E
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)
		bclr	#1,obStatus(a0)
		move.w	(a1),d0
		andi.w	#0x3FF,d0
		cmpi.w	#0x16A,d0
		bcs.s	loc_C09E
		move.w	0x30(a0),d0
		asr.w	#3,d0
		move.w	d0,obVelX(a0)
		move.b	#1,0x32(a0)
		clr.w	0xE(a0)

loc_C09E:
		bra.s	loc_C0E6
# ===========================================================================

loc_C0A0:
		tst.w	obVelX(a0)
		beq.w	loc_C0D6
		bmi.s	loc_C0BC
		moveq	#0,d3
		move.b	obActWid(a0),d3
		jsr	(ObjHitWallRight).l
		tst.w	d1		/* has block touched a wall? */
		bmi.s	PushB_StopPush	/* if yes, branch */
		bra.s	loc_C0E6
# ===========================================================================

loc_C0BC:
		moveq	#0,d3
		move.b	obActWid(a0),d3
		not.w	d3
		jsr	(ObjHitWallLeft).l
		tst.w	d1		/* has block touched a wall? */
		bmi.s	PushB_StopPush	/* if yes, branch */
		bra.s	loc_C0E6
# ===========================================================================

PushB_StopPush:
		clr.w	obVelX(a0)		/* stop block moving */
		bra.s	loc_C0E6
# ===========================================================================

loc_C0D6:
		addi.l	#0x2001,obY(a0)
		cmpi.b	#0xA0,obY+3(a0)
		bcc.s	loc_C104

loc_C0E6:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		move.w	#0x10,d2
		move.w	#0x11,d3
		move.w	(sp)+,d4
		bsr.w	loc_C186
		bsr.s	PushB_ChkLava
		bra.w	loc_BFC6
# ===========================================================================

loc_C104:
		move.w	(sp)+,d4
		lea	(v_player).w,a1
		bclr	#3,obStatus(a1)
		bclr	#3,obStatus(a0)
		bra.w	loc_ppppp
# ===========================================================================

PushB_ChkLava:
		cmpi.w	#(id_MZ<<8)+1,(v_zone).w /* is the level MZ act 2? */
		bne.s	PushB_ChkLava2	/* if not, branch */
		move.w	#-0x20,d2
		cmpi.w	#0xDD0,obX(a0)
		beq.s	PushB_LoadLava
		cmpi.w	#0xCC0,obX(a0)
		beq.s	PushB_LoadLava
		cmpi.w	#0xBA0,obX(a0)
		beq.s	PushB_LoadLava
		rts	
# ===========================================================================

PushB_ChkLava2:
		cmpi.w	#(id_MZ<<8)+2,(v_zone).w /* is the level MZ act 3? */
		bne.s	PushB_NoLava	/* if not, branch */
		move.w	#0x20,d2
		cmpi.w	#0x560,obX(a0)
		beq.s	PushB_LoadLava
		cmpi.w	#0x5C0,obX(a0)
		beq.s	PushB_LoadLava

PushB_NoLava:
		rts	
# ===========================================================================

PushB_LoadLava:
		bsr.w	FindFreeObj
		bne.s	locret_C184
		move.b	#id_GeyserMaker,0(a1) /* load lava geyser object */
		move.w	obX(a0),obX(a1)
		add.w	d2,obX(a1)
		move.w	obY(a0),obY(a1)
		addi.w	#0x10,obY(a1)
		move.l	a0,0x3C(a1)

locret_C184:
		rts	
# ===========================================================================

loc_C186:
		move.b	ob2ndRout(a0),d0
		beq.w	loc_C218
		subq.b	#2,d0
		bne.s	loc_C1AA
		bsr.w	ExitPlatform
		btst	#3,obStatus(a1)
		bne.s	loc_C1A4
		clr.b	ob2ndRout(a0)
		rts	
# ===========================================================================

loc_C1A4:
		move.w	d4,d2
		bra.w	MvSonicOnPtfm
# ===========================================================================

loc_C1AA:
		subq.b	#2,d0
		bne.s	loc_C1F2
		bsr.w	SpeedToPos
		addi.w	#0x18,obVelY(a0)
		jsr	(ObjFloorDist).l
		tst.w	d1
		bpl.w	locret_C1F0
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)
		clr.b	ob2ndRout(a0)
		move.w	(a1),d0
		andi.w	#0x3FF,d0
		cmpi.w	#0x16A,d0
		bcs.s	locret_C1F0
		move.w	0x30(a0),d0
		asr.w	#3,d0
		move.w	d0,obVelX(a0)
		move.b	#1,0x32(a0)
		clr.w	obY+2(a0)

locret_C1F0:
		rts	
# ===========================================================================

loc_C1F2:
		bsr.w	SpeedToPos
		move.w	obX(a0),d0
		andi.w	#0xC,d0
		bne.w	locret_C2E4
		andi.w	#-0x10,obX(a0)
		move.w	obVelX(a0),0x30(a0)
		clr.w	obVelX(a0)
		subq.b	#2,ob2ndRout(a0)
		rts	
# ===========================================================================

loc_C218:
		bsr.w	Solid_ChkEnter
		tst.w	d4
		beq.w	locret_C2E4
		bmi.w	locret_C2E4
		tst.b	0x32(a0)
		beq.s	loc_C230
		bra.w	locret_C2E4
# ===========================================================================

loc_C230:
		tst.w	d0
		beq.w	locret_C2E4
		bmi.s	loc_C268
		btst	#0,obStatus(a1)
		bne.w	locret_C2E4
		move.w	d0,-(sp)
		moveq	#0,d3
		move.b	obActWid(a0),d3
		jsr	(ObjHitWallRight).l
		move.w	(sp)+,d0
		tst.w	d1
		bmi.w	locret_C2E4
		addi.l	#0x10000,obX(a0)
		moveq	#1,d0
		move.w	#0x40,d1
		bra.s	loc_C294
# ===========================================================================

loc_C268:
		btst	#0,obStatus(a1)
		beq.s	locret_C2E4
		move.w	d0,-(sp)
		moveq	#0,d3
		move.b	obActWid(a0),d3
		not.w	d3
		jsr	(ObjHitWallLeft).l
		move.w	(sp)+,d0
		tst.w	d1
		bmi.s	locret_C2E4
		subi.l	#0x10000,obX(a0)
		moveq	#-1,d0
		move.w	#-0x40,d1

loc_C294:
		lea	(v_player).w,a1
		add.w	d0,obX(a1)
		move.w	d1,obInertia(a1)
		move.w	#0,obVelX(a1)
		move.w	d0,-(sp)
		sfx	sfx_Push,0,0,0	 /* play pushing sound */
		move.w	(sp)+,d0
		tst.b	obSubtype(a0)
		bmi.s	locret_C2E4
		move.w	d0,-(sp)
		jsr	(ObjFloorDist).l
		move.w	(sp)+,d0
		cmpi.w	#4,d1
		ble.s	loc_C2E0
		move.w	#0x400,obVelX(a0)
		tst.w	d0
		bpl.s	loc_C2D8
		neg.w	obVelX(a0)

loc_C2D8:
		move.b	#6,ob2ndRout(a0)
		bra.s	locret_C2E4
# ===========================================================================

loc_C2E0:
		add.w	d1,obY(a0)

locret_C2E4:
		rts	

