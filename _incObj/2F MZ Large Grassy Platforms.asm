# ---------------------------------------------------------------------------
# Object 2F - large grass-covered platforms (MZ)
# ---------------------------------------------------------------------------

LargeGrass:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	LGrass_Index(pc,d0.w),d1
		jmp	LGrass_Index(pc,d1.w)
# ===========================================================================
LGrass_Index:	dc.w LGrass_Main-LGrass_Index
		dc.w LGrass_Action-LGrass_Index

.equ lgrass_origX, 0x2A
.equ lgrass_origY, 0x2C

LGrass_Data:	dc.w LGrass_Data1-LGrass_Data 	/* collision angle data */
		dc.b 0,	0x40			/* frame	number,	platform width */
		dc.w LGrass_Data3-LGrass_Data
		dc.b 1,	0x40
		dc.w LGrass_Data2-LGrass_Data
		dc.b 2,	0x20
# ===========================================================================

LGrass_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_LGrass,obMap(a0)
		move.w	#0xC000,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#5,obPriority(a0)
		move.w	obY(a0),lgrass_origY(a0)
		move.w	obX(a0),lgrass_origX(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		lsr.w	#2,d0
		andi.w	#0x1C,d0
		lea	LGrass_Data(pc,d0.w),a1
		move.w	(a1)+,d0
		lea	LGrass_Data(pc,d0.w),a2
		move.l	a2,0x30(a0)
		move.b	(a1)+,obFrame(a0)
		move.b	(a1),obActWid(a0)
		andi.b	#0xF,obSubtype(a0)
		move.b	#0x40,obHeight(a0)
		bset	#4,1(a0)

LGrass_Action:	/* Routine 2 */
		bsr.w	LGrass_Types
		tst.b	ob2ndRout(a0)
		beq.s	LGrass_Solid
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		bsr.w	ExitPlatform
		btst	#3,obStatus(a1)
		bne.w	LGrass_Slope
		clr.b	ob2ndRout(a0)
		bra.s	LGrass_Display
# ===========================================================================

LGrass_Slope:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		movea.l	0x30(a0),a2
		move.w	obX(a0),d2
		bsr.w	SlopeObject2
		bra.s	LGrass_Display
# ===========================================================================

LGrass_Solid:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		move.w	#0x20,d2
		cmpi.b	#2,obFrame(a0)
		bne.s	loc_AF8E
		move.w	#0x30,d2

loc_AF8E:
		movea.l	0x30(a0),a2
		bsr.w	SolidObject2F

LGrass_Display:
		bsr.w	DisplaySprite
		bra.w	LGrass_ChkDel

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LGrass_Types:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#7,d0
		add.w	d0,d0
		move.w	LGrass_TypeIndex(pc,d0.w),d1
		jmp	LGrass_TypeIndex(pc,d1.w)
# End of function LGrass_Types

# ===========================================================================
LGrass_TypeIndex:dc.w LGrass_Type00-LGrass_TypeIndex
		dc.w LGrass_Type01-LGrass_TypeIndex
		dc.w LGrass_Type02-LGrass_TypeIndex
		dc.w LGrass_Type03-LGrass_TypeIndex
		dc.w LGrass_Type04-LGrass_TypeIndex
		dc.w LGrass_Type05-LGrass_TypeIndex
# ===========================================================================

LGrass_Type00:
		rts			/* type 00 platform doesn't move */
# ===========================================================================

LGrass_Type01:
		move.b	(v_oscillate+2).w,d0
		move.w	#0x20,d1
		bra.s	LGrass_Move
# ===========================================================================

LGrass_Type02:
		move.b	(v_oscillate+6).w,d0
		move.w	#0x30,d1
		bra.s	LGrass_Move
# ===========================================================================

LGrass_Type03:
		move.b	(v_oscillate+0xA).w,d0
		move.w	#0x40,d1
		bra.s	LGrass_Move
# ===========================================================================

LGrass_Type04:
		move.b	(v_oscillate+0xE).w,d0
		move.w	#0x60,d1

LGrass_Move:
		btst	#3,obSubtype(a0)
		beq.s	loc_AFF2
		neg.w	d0
		add.w	d1,d0

loc_AFF2:
		move.w	lgrass_origY(a0),d1
		sub.w	d0,d1
		move.w	d1,obY(a0)	/* update position on y-axis */
		rts	
# ===========================================================================

LGrass_Type05:
		move.b	0x34(a0),d0
		tst.b	ob2ndRout(a0)
		bne.s	loc_B010
		subq.b	#2,d0
		bcc.s	loc_B01C
		moveq	#0,d0
		bra.s	loc_B01C
# ===========================================================================

loc_B010:
		addq.b	#4,d0
		cmpi.b	#0x40,d0
		bcs.s	loc_B01C
		move.b	#0x40,d0

loc_B01C:
		move.b	d0,0x34(a0)
		jsr	(CalcSine).l
		lsr.w	#4,d0
		move.w	d0,d1
		add.w	lgrass_origY(a0),d0
		move.w	d0,obY(a0)
		cmpi.b	#0x20,0x34(a0)
		bne.s	loc_B07A
		tst.b	0x35(a0)
		bne.s	loc_B07A
		move.b	#1,0x35(a0)
		bsr.w	FindNextFreeObj
		bne.s	loc_B07A
		move.b	#id_GrassFire,0(a1) /* load sitting flame object */
		move.w	obX(a0),obX(a1)
		move.w	lgrass_origY(a0),lgrass_origY(a1)
		addq.w	#8,lgrass_origY(a1)
		subq.w	#3,lgrass_origY(a1)
		subi.w	#0x40,obX(a1)
		move.l	0x30(a0),0x30(a1)
		move.l	a0,0x38(a1)
		movea.l	a0,a2
		bsr.s	sub_B09C

loc_B07A:
		moveq	#0,d2
		lea	0x36(a0),a2
		move.b	(a2)+,d2
		subq.b	#1,d2
		bcs.s	locret_B09A

loc_B086:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#6,d0
		addi.w	#0xD000,d0
		movea.w	d0,a1
		move.w	d1,0x3C(a1)
		dbf	d2,loc_B086

locret_B09A:
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_B09C:
		lea	0x36(a2),a2
		moveq	#0,d0
		move.b	(a2),d0
		addq.b	#1,(a2)
		lea	1(a2,d0.w),a2
		move.w	a1,d0
		subi.w	#0xD000,d0
		lsr.w	#6,d0
		andi.w	#0x7F,d0
		move.b	d0,(a2)
		rts	
# End of function sub_B09C

# ===========================================================================

LGrass_ChkDel:
		tst.b	0x35(a0)
		beq.s	loc_B0C6
		tst.b	obRender(a0)
		bpl.s	LGrass_DelFlames

loc_B0C6:
		out_of_range	DeleteObject,lgrass_origX(a0)
		rts	
# ===========================================================================

LGrass_DelFlames:
		moveq	#0,d2

loc_B0E8:
		lea	0x36(a0),a2
		move.b	(a2),d2
		clr.b	(a2)+
		subq.b	#1,d2
		bcs.s	locret_B116

loc_B0F4:
		moveq	#0,d0
		move.b	(a2),d0
		clr.b	(a2)+
		lsl.w	#6,d0
		addi.w	#0xD000,d0
		movea.w	d0,a1
		bsr.w	DeleteChild
		dbf	d2,loc_B0F4
		move.b	#0,0x35(a0)
		move.b	#0,0x34(a0)

locret_B116:
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Collision data for large moving platforms (MZ)
# ---------------------------------------------------------------------------
LGrass_Data1:	.incbin	"misc/mz_pfm1.bin"
		.align 2
LGrass_Data2:	.incbin	"misc/mz_pfm2.bin"
		.align 2
LGrass_Data3:	.incbin	"misc/mz_pfm3.bin"
		.align 2

