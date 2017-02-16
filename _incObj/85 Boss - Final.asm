# ---------------------------------------------------------------------------
# Object 85 - Eggman (FZ)
# ---------------------------------------------------------------------------

Obj85_Delete:
		jmp	(DeleteObject).l
# ===========================================================================

BossFinal:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj85_Index(pc,d0.w),d0
		jmp	Obj85_Index(pc,d0.w)
# ===========================================================================
Obj85_Index:	dc.w Obj85_Main-Obj85_Index
		dc.w Obj85_Eggman-Obj85_Index
		dc.w loc_1A38E-Obj85_Index
		dc.w loc_1A346-Obj85_Index
		dc.w loc_1A2C6-Obj85_Index
		dc.w loc_1A3AC-Obj85_Index
		dc.w loc_1A264-Obj85_Index

Obj85_ObjData:	dc.w 0x100, 0x100, 0x470	/* X pos, Y pos,	VRAM setting */
		dc.l Map_SEgg		/* mappings pointer */
		dc.w 0x25B0, 0x590, 0x300
		dc.l Map_EggCyl
		dc.w 0x26E0, 0x596, 0x3A0
		dc.l Map_FZLegs
		dc.w 0x26E0, 0x596, 0x470
		dc.l Map_SEgg
		dc.w 0x26E0, 0x596, 0x400
		dc.l Map_Eggman
		dc.w 0x26E0, 0x596, 0x400
		dc.l Map_Eggman

Obj85_ObjData2:	dc.b 2,	0, 4, 0x20, 0x19	/* routine num, animation, sprite priority, width, height */
		dc.b 4,	0, 1, 0x12, 8
		dc.b 6,	0, 3, 0, 0
		dc.b 8,	0, 3, 0, 0
		dc.b 0xA, 0, 3, 0x20, 0x20
		dc.b 0xC, 0, 3, 0, 0
# ===========================================================================

Obj85_Main:	/* Routine 0 */
		lea	Obj85_ObjData(pc),a2
		lea	Obj85_ObjData2(pc),a3
		movea.l	a0,a1
		moveq	#5,d1
		bra.s	Obj85_LoadBoss
# ===========================================================================

Obj85_Loop:
		jsr	(FindNextFreeObj).l
		bne.s	loc_19E20

Obj85_LoadBoss:
		move.b	#id_BossFinal,(a1)
		move.w	(a2)+,obX(a1)
		move.w	(a2)+,obY(a1)
		move.w	(a2)+,obGfx(a1)
		move.l	(a2)+,obMap(a1)
		move.b	(a3)+,obRoutine(a1)
		move.b	(a3)+,obAnim(a1)
		move.b	(a3)+,obPriority(a1)
		.if Revision==0
		move.b	(a3)+,obWidth(a1)
		.else
			move.b	(a3)+,obActWid(a1)
		.endc
		move.b	(a3)+,obHeight(a1)
		move.b	#4,obRender(a1)
		bset	#7,obRender(a0)
		move.l	a0,0x34(a1)
		dbf	d1,Obj85_Loop

loc_19E20:
		lea	0x36(a0),a2
		jsr	(FindFreeObj).l
		bne.s	loc_19E5A
		move.b	#id_BossPlasma,(a1) /* load energy ball object */
		move.w	a1,(a2)
		move.l	a0,0x34(a1)
		lea	0x38(a0),a2
		moveq	#0,d2
		moveq	#3,d1

loc_19E3E:
		jsr	(FindNextFreeObj).l
		bne.s	loc_19E5A
		move.w	a1,(a2)+
		move.b	#id_EggmanCylinder,(a1) /* load crushing	cylinder object */
		move.l	a0,0x34(a1)
		move.b	d2,obSubtype(a1)
		addq.w	#2,d2
		dbf	d1,loc_19E3E

loc_19E5A:
		move.w	#0,0x34(a0)
		move.b	#8,obColProp(a0) /* set number of hits to 8 */
		move.w	#-1,0x30(a0)

Obj85_Eggman:	/* Routine 2 */
		moveq	#0,d0
		move.b	0x34(a0),d0
		move.w	off_19E80(pc,d0.w),d0
		jsr	off_19E80(pc,d0.w)
		jmp	(DisplaySprite).l
# ===========================================================================
off_19E80:	dc.w loc_19E90-off_19E80, loc_19EA8-off_19E80
		dc.w loc_19FE6-off_19E80, loc_1A02A-off_19E80
		dc.w loc_1A074-off_19E80, loc_1A112-off_19E80
		dc.w loc_1A192-off_19E80, loc_1A1D4-off_19E80
# ===========================================================================

loc_19E90:
		tst.l	(v_plc_buffer).w
		bne.s	loc_19EA2
		cmpi.w	#0x2450,(v_screenposx).w
		bcs.s	loc_19EA2
		addq.b	#2,0x34(a0)

loc_19EA2:
		addq.l	#1,(v_random).w
		rts	
# ===========================================================================

loc_19EA8:
		tst.w	0x30(a0)
		bpl.s	loc_19F10
		clr.w	0x30(a0)
		jsr	(RandomNumber).l
		andi.w	#0xC,d0
		move.w	d0,d1
		addq.w	#2,d1
		tst.l	d0
		bpl.s	loc_19EC6
		exg	d1,d0

loc_19EC6:
		lea	word_19FD6(pc),a1
		move.w	(a1,d0.w),d0
		move.w	(a1,d1.w),d1
		move.w	d0,0x30(a0)
		moveq	#-1,d2
		move.w	0x38(a0,d0.w),d2
		movea.l	d2,a1
		move.b	#-1,0x29(a1)
		move.w	#-1,0x30(a1)
		move.w	0x38(a0,d1.w),d2
		movea.l	d2,a1
		move.b	#1,0x29(a1)
		move.w	#0,0x30(a1)
		move.w	#1,0x32(a0)
		clr.b	0x35(a0)
		sfx	sfx_Rumbling,0,0,0	/* play rumbling sound */

loc_19F10:
		tst.w	0x32(a0)
		bmi.w	loc_19FA6
		bclr	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcs.s	loc_19F2E
		bset	#0,obStatus(a0)

loc_19F2E:
		move.w	#0x2B,d1
		move.w	#0x14,d2
		move.w	#0x14,d3
		move.w	obX(a0),d4
		jsr	(SolidObject).l
		tst.w	d4
		bgt.s	loc_19F50

loc_19F48:
		tst.b	0x35(a0)
		bne.s	loc_19F88
		bra.s	loc_19F96
# ===========================================================================

loc_19F50:
		addq.w	#7,(v_random).w
		cmpi.b	#id_Roll,(v_player+obAnim).w
		bne.s	loc_19F48
		move.w	#0x300,d0
		btst	#0,obStatus(a0)
		bne.s	loc_19F6A
		neg.w	d0

loc_19F6A:
		move.w	d0,(v_player+obVelX).w
		tst.b	0x35(a0)
		bne.s	loc_19F88
		subq.b	#1,obColProp(a0)
		move.b	#0x64,0x35(a0)
		sfx	sfx_HitBoss,0,0,0	/* play boss damage sound */

loc_19F88:
		subq.b	#1,0x35(a0)
		beq.s	loc_19F96
		move.b	#3,obAnim(a0)
		bra.s	loc_19F9C
# ===========================================================================

loc_19F96:
		move.b	#1,obAnim(a0)

loc_19F9C:
		lea	Ani_SEgg(pc),a1
		jmp	(AnimateSprite).l
# ===========================================================================

loc_19FA6:
		tst.b	obColProp(a0)
		beq.s	loc_19FBC
		addq.b	#2,0x34(a0)
		move.w	#-1,0x30(a0)
		clr.w	0x32(a0)
		rts	
# ===========================================================================

loc_19FBC:
		.if Revision==0
		.else
			moveq	#100,d0
			bsr.w	AddPoints
		.endc
		move.b	#6,0x34(a0)
		move.w	#0x25C0,obX(a0)
		move.w	#0x53C,obY(a0)
		move.b	#0x14,obHeight(a0)
		rts	
# ===========================================================================
word_19FD6:	dc.w 0,	2, 2, 4, 4, 6, 6, 0
# ===========================================================================

loc_19FE6:
		moveq	#-1,d0
		move.w	0x36(a0),d0
		movea.l	d0,a1
		tst.w	0x30(a0)
		bpl.s	loc_1A000
		clr.w	0x30(a0)
		move.b	#-1,0x29(a1)
		bsr.s	loc_1A020

loc_1A000:
		moveq	#0xF,d0
		and.w	(v_vbla_word).w,d0
		bne.s	loc_1A00A
		bsr.s	loc_1A020

loc_1A00A:
		tst.w	0x32(a0)
		beq.s	locret_1A01E
		subq.b	#2,0x34(a0)
		move.w	#-1,0x30(a0)
		clr.w	0x32(a0)

locret_1A01E:
		rts	
# ===========================================================================

loc_1A020:
		sfx	sfx_Electric,1,0,0	/* play electricity sound */
# ===========================================================================

loc_1A02A:
		.if Revision==0
		move.b	#0x30,obWidth(a0)
		.else
			move.b	#0x30,obActWid(a0)
		.endc
		bset	#0,obStatus(a0)
		jsr	(SpeedToPos).l
		move.b	#6,obFrame(a0)
		addi.w	#0x10,obVelY(a0)
		cmpi.w	#0x59C,obY(a0)
		bcs.s	loc_1A070
		move.w	#0x59C,obY(a0)
		addq.b	#2,0x34(a0)
		.if Revision==0
		move.b	#0x20,obWidth(a0)
		.else
			move.b	#0x20,obActWid(a0)
		.endc
		move.w	#0x100,obVelX(a0)
		move.w	#-0x100,obVelY(a0)
		addq.b	#2,(v_dle_routine).w

loc_1A070:
		bra.w	loc_1A166
# ===========================================================================

loc_1A074:
		bset	#0,obStatus(a0)
		move.b	#4,obAnim(a0)
		jsr	(SpeedToPos).l
		addi.w	#0x10,obVelY(a0)
		cmpi.w	#0x5A3,obY(a0)
		bcs.s	loc_1A09A
		move.w	#-0x40,obVelY(a0)

loc_1A09A:
		move.w	#0x400,obVelX(a0)
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bpl.s	loc_1A0B4
		move.w	#0x500,obVelX(a0)
		bra.w	loc_1A0F2
# ===========================================================================

loc_1A0B4:
		subi.w	#0x70,d0
		bcs.s	loc_1A0F2
		subi.w	#0x100,obVelX(a0)
		subq.w	#8,d0
		bcs.s	loc_1A0F2
		subi.w	#0x100,obVelX(a0)
		subq.w	#8,d0
		bcs.s	loc_1A0F2
		subi.w	#0x80,obVelX(a0)
		subq.w	#8,d0
		bcs.s	loc_1A0F2
		subi.w	#0x80,obVelX(a0)
		subq.w	#8,d0
		bcs.s	loc_1A0F2
		subi.w	#0x80,obVelX(a0)
		subi.w	#0x38,d0
		bcs.s	loc_1A0F2
		clr.w	obVelX(a0)

loc_1A0F2:
		cmpi.w	#0x26A0,obX(a0)
		bcs.s	loc_1A110
		move.w	#0x26A0,obX(a0)
		move.w	#0x240,obVelX(a0)
		move.w	#-0x4C0,obVelY(a0)
		addq.b	#2,0x34(a0)

loc_1A110:
		bra.s	loc_1A15C
# ===========================================================================

loc_1A112:
		jsr	(SpeedToPos).l
		cmpi.w	#0x26E0,obX(a0)
		bcs.s	loc_1A124
		clr.w	obVelX(a0)

loc_1A124:
		addi.w	#0x34,obVelY(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_1A142
		cmpi.w	#0x592,obY(a0)
		bcs.s	loc_1A142
		move.w	#0x592,obY(a0)
		clr.w	obVelY(a0)

loc_1A142:
		move.w	obVelX(a0),d0
		or.w	obVelY(a0),d0
		bne.s	loc_1A15C
		addq.b	#2,0x34(a0)
		move.w	#-0x180,obVelY(a0)
		move.b	#1,obColProp(a0)

loc_1A15C:
		lea	Ani_SEgg(pc),a1
		jsr	(AnimateSprite).l

loc_1A166:
		cmpi.w	#0x2700,(v_limitright2).w
		bge.s	loc_1A172
		addq.w	#2,(v_limitright2).w

loc_1A172:
		cmpi.b	#0xC,0x34(a0)
		bge.s	locret_1A190
		move.w	#0x1B,d1
		move.w	#0x70,d2
		move.w	#0x71,d3
		move.w	obX(a0),d4
		jmp	(SolidObject).l
# ===========================================================================

locret_1A190:
		rts	
# ===========================================================================

loc_1A192:
		move.l	#Map_Eggman,obMap(a0)
		move.w	#0x400,obGfx(a0)
		move.b	#0,obAnim(a0)
		bset	#0,obStatus(a0)
		jsr	(SpeedToPos).l
		cmpi.w	#0x544,obY(a0)
		bcc.s	loc_1A1D0
		move.w	#0x180,obVelX(a0)
		move.w	#-0x18,obVelY(a0)
		move.b	#0xF,obColType(a0)
		addq.b	#2,0x34(a0)

loc_1A1D0:
		bra.w	loc_1A15C
# ===========================================================================

loc_1A1D4:
		bset	#0,obStatus(a0)
		jsr	(SpeedToPos).l
		tst.w	0x30(a0)
		bne.s	loc_1A1FC
		tst.b	obColType(a0)
		bne.s	loc_1A216
		move.w	#0x1E,0x30(a0)
		sfx	sfx_HitBoss,0,0,0	/* play boss damage sound */

loc_1A1FC:
		subq.w	#1,0x30(a0)
		bne.s	loc_1A216
		tst.b	obStatus(a0)
		bpl.s	loc_1A210
		move.w	#0x60,obVelY(a0)
		bra.s	loc_1A216
# ===========================================================================

loc_1A210:
		move.b	#0xF,obColType(a0)

loc_1A216:
		cmpi.w	#0x2790,(v_player+obX).w
		blt.s	loc_1A23A
		move.b	#1,(f_lockctrl).w
		move.w	#0,(v_jpadhold2).w
		clr.w	(v_player+obInertia).w
		tst.w	obVelY(a0)
		bpl.s	loc_1A248
		move.w	#0x100,(v_jpadhold2).w

loc_1A23A:
		cmpi.w	#0x27E0,(v_player+obX).w
		blt.s	loc_1A248
		move.w	#0x27E0,(v_player+obX).w

loc_1A248:
		cmpi.w	#0x2900,obX(a0)
		bcs.s	loc_1A260
		tst.b	obRender(a0)
		bmi.s	loc_1A260
		move.b	#0x18,(v_gamemode).w
		bra.w	Obj85_Delete
# ===========================================================================

loc_1A260:
		bra.w	loc_1A15C
# ===========================================================================

loc_1A264:	/* Routine 4 */
		movea.l	0x34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.w	Obj85_Delete
		move.b	#7,obAnim(a0)
		cmpi.b	#0xC,0x34(a1)
		bge.s	loc_1A280
		bra.s	loc_1A2A6
# ===========================================================================

loc_1A280:
		tst.w	obVelX(a1)
		beq.s	loc_1A28C
		move.b	#0xB,obAnim(a0)

loc_1A28C:
		lea	Ani_Eggman(pc),a1
		jsr	(AnimateSprite).l

loc_1A296:
		movea.l	0x34(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)

loc_1A2A6:
		movea.l	0x34(a0),a1
		move.b	obStatus(a1),obStatus(a0)
		moveq	#3,d0
		and.b	obStatus(a0),d0
		andi.b	#0xFC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite).l
# ===========================================================================

loc_1A2C6:	/* Routine 6 */
		movea.l	0x34(a0),a1
		move.b	(a1),d0
		cmp.b	(a0),d0
		bne.w	Obj85_Delete
		cmpi.l	#Map_Eggman,obMap(a1)
		beq.s	loc_1A2E4
		move.b	#0xA,obFrame(a0)
		bra.s	loc_1A2A6
# ===========================================================================

loc_1A2E4:
		move.b	#1,obAnim(a0)
		tst.b	obColProp(a1)
		ble.s	loc_1A312
		move.b	#6,obAnim(a0)
		move.l	#Map_Eggman,obMap(a0)
		move.w	#0x400,obGfx(a0)
		lea	Ani_Eggman(pc),a1
		jsr	(AnimateSprite).l
		bra.w	loc_1A296
# ===========================================================================

loc_1A312:
		tst.b	1(a0)
		bpl.w	Obj85_Delete
		bsr.w	BossDefeated
		move.b	#2,obPriority(a0)
		move.b	#0,obAnim(a0)
		move.l	#Map_FZDamaged,obMap(a0)
		move.w	#0x3A0,obGfx(a0)
		lea	Ani_FZEgg(pc),a1
		jsr	(AnimateSprite).l
		bra.w	loc_1A296
# ===========================================================================

loc_1A346:	/* Routine 8 */
		bset	#0,obStatus(a0)
		movea.l	0x34(a0),a1
		cmpi.l	#Map_Eggman,obMap(a1)
		beq.s	loc_1A35E
		bra.w	loc_1A2A6
# ===========================================================================

loc_1A35E:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		tst.b	obTimeFrame(a0)
		bne.s	loc_1A376
		move.b	#0x14,obTimeFrame(a0)

loc_1A376:
		subq.b	#1,obTimeFrame(a0)
		bgt.s	loc_1A38A
		addq.b	#1,obFrame(a0)
		cmpi.b	#2,obFrame(a0)
		bgt.w	Obj85_Delete

loc_1A38A:
		bra.w	loc_1A296
# ===========================================================================

loc_1A38E:	/* Routine $A */
		move.b	#0xB,obFrame(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bcs.s	loc_1A3A6
		tst.b	obRender(a0)
		bpl.w	Obj85_Delete

loc_1A3A6:
		jmp	(DisplaySprite).l
# ===========================================================================

loc_1A3AC:	/* Routine $C */
		move.b	#0,obFrame(a0)
		bset	#0,obStatus(a0)
		movea.l	0x34(a0),a1
		cmpi.b	#0xC,0x34(a1)
		bne.s	loc_1A3D0
		cmpi.l	#Map_Eggman,obMap(a1)
		beq.w	Obj85_Delete

loc_1A3D0:
		bra.w	loc_1A2A6

