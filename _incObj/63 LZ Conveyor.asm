# ---------------------------------------------------------------------------
# Object 63 - platforms	on a conveyor belt (LZ)
# ---------------------------------------------------------------------------

LabyrinthConvey:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	LCon_Index(pc,d0.w),d1
		jsr	LCon_Index(pc,d1.w)
		out_of_range_s	loc_1236A,0x30(a0)

LCon_Display:
		bra.w	DisplaySprite
# ===========================================================================

loc_1236A:
		cmpi.b	#2,(v_act).w
		bne.s	loc_12378
		cmpi.w	#-0x80,d0
		bcc.s	LCon_Display

loc_12378:
		move.b	0x2F(a0),d0
		bpl.w	DeleteObject
		andi.w	#0x7F,d0
		lea	(v_obj63).w,a2
		bclr	#0,(a2,d0.w)
		bra.w	DeleteObject
# ===========================================================================
LCon_Index:	dc.w LCon_Main-LCon_Index
		dc.w loc_124B2-LCon_Index
		dc.w loc_124C2-LCon_Index
		dc.w loc_124DE-LCon_Index
# ===========================================================================

LCon_Main:	/* Routine 0 */
		move.b	obSubtype(a0),d0
		bmi.w	loc_12460
		addq.b	#2,obRoutine(a0)
		move.l	#Map_LConv,obMap(a0)
		move.w	#0x43F6,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#0x10,obActWid(a0)
		move.b	#4,obPriority(a0)
		cmpi.b	#0x7F,obSubtype(a0)
		bne.s	loc_123E2
		addq.b	#4,obRoutine(a0)
		move.w	#0x3F6,obGfx(a0)
		move.b	#1,obPriority(a0)
		bra.w	loc_124DE
# ===========================================================================

loc_123E2:
		move.b	#4,obFrame(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		move.w	d0,d1
		lsr.w	#3,d0
		andi.w	#0x1E,d0
		lea	LCon_Data(pc),a2
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,0x38(a0)
		move.w	(a2)+,0x30(a0)
		move.l	a2,0x3C(a0)
		andi.w	#0xF,d1
		lsl.w	#2,d1
		move.b	d1,0x38(a0)
		move.b	#4,0x3A(a0)
		tst.b	(f_conveyrev).w
		beq.s	loc_1244C
		move.b	#1,0x3B(a0)
		neg.b	0x3A(a0)
		moveq	#0,d1
		move.b	0x38(a0),d1
		add.b	0x3A(a0),d1
		cmp.b	0x39(a0),d1
		bcs.s	loc_12448
		move.b	d1,d0
		moveq	#0,d1
		tst.b	d0
		bpl.s	loc_12448
		move.b	0x39(a0),d1
		subq.b	#4,d1

loc_12448:
		move.b	d1,0x38(a0)

loc_1244C:
		move.w	(a2,d1.w),0x34(a0)
		move.w	2(a2,d1.w),0x36(a0)
		bsr.w	LCon_ChangeDir
		bra.w	loc_124B2
# ===========================================================================

loc_12460:
		move.b	d0,0x2F(a0)
		andi.w	#0x7F,d0
		lea	(v_obj63).w,a2
		bset	#0,(a2,d0.w)
		bne.w	DeleteObject
		add.w	d0,d0
		andi.w	#0x1E,d0
		addi.w	#ObjPosLZPlatform_Index-ObjPos_Index,d0
		lea	(ObjPos_Index).l,a2
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d1
		movea.l	a0,a1
		bra.s	LCon_MakePtfms
# ===========================================================================

LCon_Loop:
		bsr.w	FindFreeObj
		bne.s	loc_124AA

LCon_MakePtfms:
		move.b	#id_LabyrinthConvey,0(a1)
		move.w	(a2)+,obX(a1)
		move.w	(a2)+,obY(a1)
		move.w	(a2)+,d0
		move.b	d0,obSubtype(a1)

loc_124AA:
		dbf	d1,LCon_Loop

		addq.l	#4,sp
		rts	
# ===========================================================================

loc_124B2:	/* Routine 2 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(PlatformObject).l
		bra.w	sub_12502
# ===========================================================================

loc_124C2:	/* Routine 4 */
		moveq	#0,d1
		move.b	obActWid(a0),d1
		jsr	(ExitPlatform).l
		move.w	obX(a0),-(sp)
		bsr.w	sub_12502
		move.w	(sp)+,d2
		jmp	(MvSonicOnPtfm2).l
# ===========================================================================

loc_124DE:	/* Routine 6 */
		move.w	(v_framecount).w,d0
		andi.w	#3,d0
		bne.s	loc_124FC
		moveq	#1,d1
		tst.b	(f_conveyrev).w
		beq.s	loc_124F2
		neg.b	d1

loc_124F2:
		add.b	d1,obFrame(a0)
		andi.b	#3,obFrame(a0)

loc_124FC:
		addq.l	#4,sp
		bra.w	RememberState

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_12502:
		tst.b	(f_switch+0xE).w
		beq.s	loc_12520
		tst.b	0x3B(a0)
		bne.s	loc_12520
		move.b	#1,0x3B(a0)
		move.b	#1,(f_conveyrev).w
		neg.b	0x3A(a0)
		bra.s	loc_12534
# ===========================================================================

loc_12520:
		move.w	obX(a0),d0
		cmp.w	0x34(a0),d0
		bne.s	loc_1256A
		move.w	obY(a0),d0
		cmp.w	0x36(a0),d0
		bne.s	loc_1256A

loc_12534:
		moveq	#0,d1
		move.b	0x38(a0),d1
		add.b	0x3A(a0),d1
		cmp.b	0x39(a0),d1
		bcs.s	loc_12552
		move.b	d1,d0
		moveq	#0,d1
		tst.b	d0
		bpl.s	loc_12552
		move.b	0x39(a0),d1
		subq.b	#4,d1

loc_12552:
		move.b	d1,0x38(a0)
		movea.l	0x3C(a0),a1
		move.w	(a1,d1.w),0x34(a0)
		move.w	2(a1,d1.w),0x36(a0)
		bsr.w	LCon_ChangeDir

loc_1256A:
		bsr.w	SpeedToPos
		rts	
# End of function sub_12502


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LCon_ChangeDir:
		moveq	#0,d0
		move.w	#-0x100,d2
		move.w	obX(a0),d0
		sub.w	0x34(a0),d0
		bcc.s	loc_12584
		neg.w	d0
		neg.w	d2

loc_12584:
		moveq	#0,d1
		move.w	#-0x100,d3
		move.w	obY(a0),d1
		sub.w	0x36(a0),d1
		bcc.s	loc_12598
		neg.w	d1
		neg.w	d3

loc_12598:
		cmp.w	d0,d1
		bcs.s	loc_125C2
		move.w	obX(a0),d0
		sub.w	0x34(a0),d0
		beq.s	loc_125AE
		ext.l	d0
		asl.l	#8,d0
		divs.w	d1,d0
		neg.w	d0

loc_125AE:
		move.w	d0,obVelX(a0)
		move.w	d3,obVelY(a0)
		swap	d0
		move.w	d0,obX+2(a0)
		clr.w	obY+2(a0)
		rts	
# ===========================================================================

loc_125C2:
		move.w	obY(a0),d1
		sub.w	0x36(a0),d1
		beq.s	loc_125D4
		ext.l	d1
		asl.l	#8,d1
		divs.w	d0,d1
		neg.w	d1

loc_125D4:
		move.w	d1,obVelY(a0)
		move.w	d2,obVelX(a0)
		swap	d1
		move.w	d1,obY+2(a0)
		clr.w	obX+2(a0)
		rts	
# End of function LCon_ChangeDir

# ===========================================================================
LCon_Data:	dc.w word_125F4-LCon_Data
		dc.w word_12610-LCon_Data
		dc.w word_12628-LCon_Data
		dc.w word_1263C-LCon_Data
		dc.w word_12650-LCon_Data
		dc.w word_12668-LCon_Data
word_125F4:	dc.w 0x18, 0x1070, 0x1078,	0x21A, 0x10BE, 0x260, 0x10BE, 0x393
		dc.w 0x108C, 0x3C5, 0x1022, 0x390, 0x1022, 0x244
word_12610:	dc.w 0x14, 0x1280, 0x127E,	0x280, 0x12CE, 0x2D0, 0x12CE, 0x46E
		dc.w 0x1232, 0x420, 0x1232, 0x2CC
word_12628:	dc.w 0x10, 0xD68,	0xD22, 0x482, 0xD22, 0x5DE,	0xDAE, 0x5DE, 0xDAE, 0x482
word_1263C:	dc.w 0x10, 0xDA0,	0xD62, 0x3A2, 0xDEE, 0x3A2,	0xDEE, 0x4DE, 0xD62, 0x4DE
word_12650:	dc.w 0x14, 0xD00,	0xCAC, 0x242, 0xDDE, 0x242,	0xDDE, 0x3DE, 0xC52, 0x3DE,	0xC52, 0x29C
word_12668:	dc.w 0x10, 0x1300, 0x1252,	0x20A, 0x13DE, 0x20A, 0x13DE, 0x2BE,	0x1252, 0x2BE

