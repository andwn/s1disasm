# ---------------------------------------------------------------------------
# Object 56 - floating blocks (SYZ/SLZ), large doors (LZ)
# ---------------------------------------------------------------------------

FloatingBlock:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	FBlock_Index(pc,d0.w),d1
		jmp	FBlock_Index(pc,d1.w)
# ===========================================================================
FBlock_Index:	dc.w FBlock_Main-FBlock_Index
		dc.w FBlock_Action-FBlock_Index

.equ fb_origX, 0x34		/* original x-axis position */
.equ fb_origY, 0x30		/* original y-axis position */
.equ fb_height, 0x3A		/* total object height */
.equ fb_type, 0x3C		/* subtype (2nd digit only) */

FBlock_Var:	/* width/2, height/2 */
		dc.b  0x10, 0x10	/* subtype 0x/8x */
		dc.b  0x20, 0x20	/* subtype 1x/9x */
		dc.b  0x10, 0x20	/* subtype 2x/Ax */
		dc.b  0x20, 0x1A	/* subtype 3x/Bx */
		dc.b  0x10, 0x27	/* subtype 4x/Cx */
		dc.b  0x10, 0x10	/* subtype 5x/Dx */
		dc.b	8, 0x20	/* subtype 6x/Ex */
		dc.b  0x40, 0x10	/* subtype 7x/Fx */
# ===========================================================================

FBlock_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_FBlock,obMap(a0)
		move.w	#0x4000,obGfx(a0)
		cmpi.b	#id_LZ,(v_zone).w /* check if level is LZ */
		bne.s	1f
		move.w	#0x43C4,obGfx(a0) /* LZ specific code */

	1:
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* get subtype */
		lsr.w	#3,d0
		andi.w	#0xE,d0		/* read only the 1st digit */
		lea	FBlock_Var(pc,d0.w),a2 /* get size data */
		move.b	(a2)+,obActWid(a0)
		move.b	(a2),obHeight(a0)
		lsr.w	#1,d0
		move.b	d0,obFrame(a0)
		move.w	obX(a0),fb_origX(a0)
		move.w	obY(a0),fb_origY(a0)
		moveq	#0,d0
		move.b	(a2),d0
		add.w	d0,d0
		move.w	d0,fb_height(a0)
		.if Revision==0
		.else
			cmpi.b	#0x37,obSubtype(a0)
			bne.s	2f
			cmpi.w	#0x1BB8,obX(a0)
			bne.s	3f
			tst.b	(0xFFFFF7CE).w
			beq.s	2f
			jmp	(DeleteObject).l
	3:
			clr.b	obSubtype(a0)
			tst.b	(0xFFFFF7CE).w
			bne.s	2f
			jmp	(DeleteObject).l
	2:
		.endc
		moveq	#0,d0
		cmpi.b	#id_LZ,(v_zone).w /* check if level is LZ */
		beq.s	4f
		move.b	obSubtype(a0),d0 /* SYZ/SLZ specific code */
		andi.w	#0xF,d0
		subq.w	#8,d0
		bcs.s	4f
		lsl.w	#2,d0
		lea	(v_oscillate+0x2C).w,a2
		lea	(a2,d0.w),a2
		tst.w	(a2)
		bpl.s	4f
		bchg	#0,obStatus(a0)

	4:
		move.b	obSubtype(a0),d0
		bpl.s	FBlock_Action
		andi.b	#0xF,d0
		move.b	d0,fb_type(a0)
		move.b	#5,obSubtype(a0)
		cmpi.b	#7,obFrame(a0)
		bne.s	5f
		move.b	#0xC,obSubtype(a0)
		move.w	#0x80,fb_height(a0)

5:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	FBlock_Action
		bclr	#7,2(a2,d0.w)
		btst	#0,2(a2,d0.w)
		beq.s	FBlock_Action
		addq.b	#1,obSubtype(a0)
		clr.w	fb_height(a0)

FBlock_Action:	/* Routine 2 */
		move.w	obX(a0),-(sp)
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* get object subtype */
		andi.w	#0xF,d0		/* read only the	2nd digit */
		add.w	d0,d0
		move.w	blkIndex(pc,d0.w),d1
		jsr	blkIndex(pc,d1.w)	/* move block subroutines */
		move.w	(sp)+,d4
		tst.b	obRender(a0)
		bpl.s	2f
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		moveq	#0,d2
		move.b	obHeight(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		bsr.w	SolidObject

	2:
		.if Revision==0
		out_of_range	DeleteObject,fb_origX(a0)
		bra.w	DisplaySprite
		.else
			out_of_range_s	3f,fb_origX(a0)
		4:
			bra.w	DisplaySprite
		3:
			cmpi.b	#0x37,obSubtype(a0)
			bne.s	5f
			tst.b	0x38(a0)
			bne.s	4b
		5:
			jmp	(DeleteObject).l
		.endc
# ===========================================================================
blkIndex:	dc.w blk00-blkIndex, blk01-blkIndex
		dc.w blk02-blkIndex, blk03-blkIndex
		dc.w blk04-blkIndex, blk05-blkIndex
		dc.w blk06-blkIndex, blk07-blkIndex
		dc.w blk08-blkIndex, blk09-blkIndex
		dc.w blk0A-blkIndex, blk0B-blkIndex
		dc.w blk0C-blkIndex, blk0D-blkIndex
# ===========================================================================

blk00:
12:
# doesn't move
		rts	
# ===========================================================================

blk01:
13:
# moves side-to-side
		move.w	#0x40,d1		/* set move distance */
		moveq	#0,d0
		move.b	(v_oscillate+0xA).w,d0
		bra.s	14f
# ===========================================================================

blk02:
6:
# moves side-to-side
		move.w	#0x80,d1		/* set move distance */
		moveq	#0,d0
		move.b	(v_oscillate+0x1E).w,d0

	14:
		btst	#0,obStatus(a0)
		beq.s	15f
		neg.w	d0
		add.w	d1,d0

	15:
		move.w	fb_origX(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)	/* move object horizontally */
		rts	
# ===========================================================================

blk03:
16:
# moves up/down
		move.w	#0x40,d1		/* set move distance */
		moveq	#0,d0
		move.b	(v_oscillate+0xA).w,d0
		bra.s	17f
# ===========================================================================

blk04:
7:
# moves up/down
		move.w	#0x80,d1		/* set move distance */
		moveq	#0,d0
		move.b	(v_oscillate+0x1E).w,d0

	17:
		btst	#0,obStatus(a0)
		beq.s	18f
		neg.w	d0
		add.w	d1,d0

	18:
		move.w	fb_origY(a0),d1
		sub.w	d0,d1
		move.w	d1,obY(a0)	/* move object vertically */
		rts	
# ===========================================================================

blk05:
19:
# moves up when a switch is pressed
		tst.b	0x38(a0)
		bne.s	20f
		cmpi.w	#(id_LZ<<8)+0,(v_zone).w /* is level LZ1 ? */
		bne.s	21f		/* if not, branch */
		cmpi.b	#3,fb_type(a0)
		bne.s	21f
		clr.b	(f_wtunnelallow).w
		move.w	(v_player+obX).w,d0
		cmp.w	obX(a0),d0
		bcc.s	21f
		move.b	#1,(f_wtunnelallow).w

	21:
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	fb_type(a0),d0
		btst	#0,(a2,d0.w)
		beq.s	22f
		cmpi.w	#(id_LZ<<8)+0,(v_zone).w /* is level LZ1 ? */
		bne.s	23f	/* if not, branch */
		cmpi.b	#3,d0
		bne.s	23f
		clr.b	(f_wtunnelallow).w

23:
		move.b	#1,0x38(a0)

20:
		tst.w	fb_height(a0)
		beq.s	24f
		subq.w	#2,fb_height(a0)

22:
		move.w	fb_height(a0),d0
		btst	#0,0x22(a0)
		beq.s	25f
		neg.w	d0

25:
		move.w	fb_origY(a0),d1
		add.w	d0,d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

24:
		addq.b	#1,0x28(a0)
		clr.b	0x38(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	22b
		bset	#0,2(a2,d0.w)
		bra.s	22b
# ===========================================================================

blk06:
8:
		tst.b	0x38(a0)
		bne.s	26f
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	fb_type(a0),d0
		tst.b	(a2,d0.w)
		bpl.s	27f
		move.b	#1,0x38(a0)

26:
		moveq	#0,d0
		move.b	obHeight(a0),d0
		add.w	d0,d0
		cmp.w	fb_height(a0),d0
		beq.s	28f
		addq.w	#2,fb_height(a0)

27:
		move.w	fb_height(a0),d0
		btst	#0,obStatus(a0)
		beq.s	29f
		neg.w	d0

29:
		move.w	fb_origY(a0),d1
		add.w	d0,d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

28:
		subq.b	#1,obSubtype(a0)
		clr.b	0x38(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	27b
		bclr	#0,2(a2,d0.w)
		bra.s	27b
# ===========================================================================

blk07:
30:
		tst.b	0x38(a0)
		bne.s	31f
		tst.b	(f_switch+0xF).w	/* has switch number $F been pressed? */
		beq.s	32f
		move.b	#1,0x38(a0)
		clr.w	fb_height(a0)

31:
		addq.w	#1,obX(a0)
		move.w	obX(a0),fb_origX(a0)
		addq.w	#1,fb_height(a0)
		cmpi.w	#0x380,fb_height(a0)
		bne.s	32f
		.if Revision==0
		.else
			move.b	#1,(0xFFFFF7CE).w
			clr.b	0x38(a0)
		.endc
		clr.b	obSubtype(a0)

32:
		rts	
# ===========================================================================

blk0C:
11:
		tst.b	0x38(a0)
		bne.s	33f
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	fb_type(a0),d0
		btst	#0,(a2,d0.w)
		beq.s	34f
		move.b	#1,0x38(a0)

33:
		tst.w	fb_height(a0)
		beq.s	35f
		subq.w	#2,fb_height(a0)

34:
		move.w	fb_height(a0),d0
		btst	#0,obStatus(a0)
		beq.s	36f
		neg.w	d0
		addi.w	#0x80,d0

36:
		move.w	fb_origX(a0),d1
		add.w	d0,d1
		move.w	d1,obX(a0)
		rts	
# ===========================================================================

35:
		addq.b	#1,obSubtype(a0)
		clr.b	0x38(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	34b
		bset	#0,2(a2,d0.w)
		bra.s	34b
# ===========================================================================

blk0D:
37:
		tst.b	0x38(a0)
		bne.s	38f
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	fb_type(a0),d0
		tst.b	(a2,d0.w)
		bpl.s	39f
		move.b	#1,0x38(a0)

38:
		move.w	#0x80,d0
		cmp.w	fb_height(a0),d0
		beq.s	40f
		addq.w	#2,fb_height(a0)

39:
		move.w	fb_height(a0),d0
		btst	#0,obStatus(a0)
		beq.s	41f
		neg.w	d0
		addi.w	#0x80,d0

41:
		move.w	fb_origX(a0),d1
		add.w	d0,d1
		move.w	d1,obX(a0)
		rts	
# ===========================================================================

40:
		subq.b	#1,obSubtype(a0)
		clr.b	0x38(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	39b
		bclr	#0,2(a2,d0.w)
		bra.s	39b
# ===========================================================================

blk08:
9:
		move.w	#0x10,d1
		moveq	#0,d0
		move.b	(v_oscillate+0x2A).w,d0
		lsr.w	#1,d0
		move.w	(v_oscillate+0x2C).w,d3
		bra.s	42f
# ===========================================================================

blk09:
43:
		move.w	#0x30,d1
		moveq	#0,d0
		move.b	(v_oscillate+0x2E).w,d0
		move.w	(v_oscillate+0x30).w,d3
		bra.s	42f
# ===========================================================================

blk0A:
10:
		move.w	#0x50,d1
		moveq	#0,d0
		move.b	(v_oscillate+0x32).w,d0
		move.w	(v_oscillate+0x34).w,d3
		bra.s	42f
# ===========================================================================

blk0B:
44:
		move.w	#0x70,d1
		moveq	#0,d0
		move.b	(v_oscillate+0x36).w,d0
		move.w	(v_oscillate+0x38).w,d3

42:
		tst.w	d3
		bne.s	45f
		addq.b	#1,obStatus(a0)
		andi.b	#3,obStatus(a0)

45:
		move.b	obStatus(a0),d2
		andi.b	#3,d2
		bne.s	46f
		sub.w	d1,d0
		add.w	fb_origX(a0),d0
		move.w	d0,obX(a0)
		neg.w	d1
		add.w	fb_origY(a0),d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

46:
		subq.b	#1,d2
		bne.s	47f
		subq.w	#1,d1
		sub.w	d1,d0
		neg.w	d0
		add.w	fb_origY(a0),d0
		move.w	d0,obY(a0)
		addq.w	#1,d1
		add.w	fb_origX(a0),d1
		move.w	d1,obX(a0)
		rts	
# ===========================================================================

47:
		subq.b	#1,d2
		bne.s	48f
		subq.w	#1,d1
		sub.w	d1,d0
		neg.w	d0
		add.w	fb_origX(a0),d0
		move.w	d0,obX(a0)
		addq.w	#1,d1
		add.w	fb_origY(a0),d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

48:
		sub.w	d1,d0
		add.w	fb_origY(a0),d0
		move.w	d0,obY(a0)
		neg.w	d1
		add.w	fb_origX(a0),d1
		move.w	d1,obX(a0)
		rts	

