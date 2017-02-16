# ---------------------------------------------------------------------------
# Object 6B - stomper and sliding door (SBZ)
# ---------------------------------------------------------------------------

ScrapStomp:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Sto_Index(pc,d0.w),d1
		jmp	Sto_Index(pc,d1.w)
# ===========================================================================
Sto_Index:	dc.w Sto_Main-Sto_Index
		dc.w Sto_Action-Sto_Index

.equ sto_height, 0x16
.equ sto_origX, 0x34		/* original x-axis position */
.equ sto_origY, 0x30		/* original y-axis position */
.equ sto_active, 0x38		/* flag set when a switch is pressed */

Sto_Var:	dc.b  0x40,  0xC,	0x80,   1 /* width, height, ????,	type number */
		dc.b  0x1C, 0x20,	0x38,   3
		dc.b  0x1C, 0x20,	0x40,   4
		dc.b  0x1C, 0x20,	0x60,   4
		dc.b  0x80, 0x40,	  0,   5
# ===========================================================================

Sto_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		lsr.w	#2,d0
		andi.w	#0x1C,d0
		lea	Sto_Var(pc,d0.w),a3
		move.b	(a3)+,obActWid(a0)
		move.b	(a3)+,sto_height(a0)
		lsr.w	#2,d0
		move.b	d0,obFrame(a0)
		move.l	#Map_Stomp,obMap(a0)
		move.w	#0x22C0,obGfx(a0)
		cmpi.b	#id_LZ,(v_zone).w /* check if level is LZ/SBZ3 */
		bne.s	1f	/* if not, branch */
		bset	#0,(v_obj6B).w
		beq.s	2f

3:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	4f
		bclr	#7,2(a2,d0.w)

	4:
		jmp	(DeleteObject).l
# ===========================================================================

2:
		move.w	#0x41F0,obGfx(a0)
		cmpi.w	#0xA80,obX(a0)
		bne.s	1f
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	1f
		btst	#0,2(a2,d0.w)
		beq.s	1f
		clr.b	(v_obj6B).w
		bra.s	3b
# ===========================================================================

1:
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.w	obX(a0),sto_origX(a0)
		move.w	obY(a0),sto_origY(a0)
		moveq	#0,d0
		move.b	(a3)+,d0
		move.w	d0,0x3C(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		bpl.s	Sto_Action
		andi.b	#0xF,d0
		move.b	d0,0x3E(a0)
		move.b	(a3),obSubtype(a0)
		cmpi.b	#5,(a3)
		bne.s	5f
		bset	#4,obRender(a0)

	5:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	Sto_Action
		bclr	#7,2(a2,d0.w)

Sto_Action:	/* Routine 2 */
		move.w	obX(a0),-(sp)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#0xF,d0
		add.w	d0,d0
		move.w	stoIndex(pc,d0.w),d1
		jsr	stoIndex(pc,d1.w)
		move.w	(sp)+,d4
		tst.b	obRender(a0)
		bpl.s	2f
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#0xB,d1
		moveq	#0,d2
		move.b	sto_height(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		bsr.w	SolidObject

	2:
		out_of_range_s	3f,sto_origX(a0)
		jmp	(DisplaySprite).l

	3:
		cmpi.b	#id_LZ,(v_zone).w
		bne.s	4f
		clr.b	(v_obj6B).w
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	4f
		bclr	#7,2(a2,d0.w)

	4:
		jmp	(DeleteObject).l
# ===========================================================================
stoIndex:		dc.w 7f-stoIndex, 8f-stoIndex
		dc.w 5f-stoIndex, 17f-stoIndex
		dc.w 6f-stoIndex, 27f-stoIndex
# ===========================================================================

7:
		rts
# ===========================================================================

8:
		tst.b	sto_active(a0)
		bne.s	9f
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	0x3E(a0),d0
		btst	#0,(a2,d0.w)
		beq.s	10f
		move.b	#1,sto_active(a0)

	9:
		move.w	0x3C(a0),d0
		cmp.w	0x3A(a0),d0
		beq.s	11f
		addq.w	#2,0x3A(a0)

	10:
		move.w	0x3A(a0),d0
		btst	#0,obStatus(a0)
		beq.s	12f
		neg.w	d0
		addi.w	#0x80,d0

	12:
		move.w	sto_origX(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)
		rts	
# ===========================================================================

11:
		addq.b	#1,obSubtype(a0)
		move.w	#0xB4,0x36(a0)
		clr.b	sto_active(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	10b
		bset	#0,2(a2,d0.w)
		bra.s	10b
# ===========================================================================

5:
		tst.b	sto_active(a0)
		bne.s	13f
		subq.w	#1,0x36(a0)
		bne.s	14f
		move.b	#1,sto_active(a0)

	13:
		tst.w	0x3A(a0)
		beq.s	15f
		subq.w	#2,0x3A(a0)

	14:
		move.w	0x3A(a0),d0
		btst	#0,obStatus(a0)
		beq.s	16f
		neg.w	d0
		addi.w	#0x80,d0

	16:
		move.w	sto_origX(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)
		rts	
# ===========================================================================

15:
		subq.b	#1,obSubtype(a0)
		clr.b	sto_active(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	14b
		bclr	#0,2(a2,d0.w)
		bra.s	14b
# ===========================================================================

17:
		tst.b	sto_active(a0)
		bne.s	18f
		tst.w	0x3A(a0)
		beq.s	19f
		subq.w	#1,0x3A(a0)
		bra.s	20f
# ===========================================================================

19:
		subq.w	#1,0x36(a0)
		bpl.s	20f
		move.w	#0x3C,0x36(a0)
		move.b	#1,sto_active(a0)

18:
		addq.w	#8,0x3A(a0)
		move.w	0x3A(a0),d0
		cmp.w	0x3C(a0),d0
		bne.s	20f
		clr.b	sto_active(a0)

20:
		move.w	0x3A(a0),d0
		btst	#0,obStatus(a0)
		beq.s	21f
		neg.w	d0
		addi.w	#0x38,d0

	21:
		move.w	sto_origY(a0),d1
		add.w	d0,d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

6:
		tst.b	sto_active(a0)
		bne.s	22f
		tst.w	0x3A(a0)
		beq.s	23f
		subq.w	#8,0x3A(a0)
		bra.s	24f
# ===========================================================================

23:
		subq.w	#1,0x36(a0)
		bpl.s	24f
		move.w	#0x3C,0x36(a0)
		move.b	#1,sto_active(a0)

22:
		move.w	0x3A(a0),d0
		cmp.w	0x3C(a0),d0
		beq.s	25f
		addq.w	#8,0x3A(a0)
		bra.s	24f
# ===========================================================================

25:
		subq.w	#1,0x36(a0)
		bpl.s	24f
		move.w	#0x3C,0x36(a0)
		clr.b	sto_active(a0)

24:
		move.w	0x3A(a0),d0
		btst	#0,obStatus(a0)
		beq.s	26f
		neg.w	d0
		addi.w	#0x38,d0

	26:
		move.w	sto_origY(a0),d1
		add.w	d0,d1
		move.w	d1,obY(a0)
		rts	
# ===========================================================================

27:
		tst.b	sto_active(a0)
		bne.s	28f
		lea	(f_switch).w,a2
		moveq	#0,d0
		move.b	0x3E(a0),d0
		btst	#0,(a2,d0.w)
		beq.s	29f
		move.b	#1,sto_active(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	28f
		bset	#0,2(a2,d0.w)

28:
		subi.l	#0x10000,obX(a0)
		addi.l	#0x8000,obY(a0)
		move.w	obX(a0),sto_origX(a0)
		cmpi.w	#0x980,obX(a0)
		beq.s	30f

29:
		rts	
# ===========================================================================

30:
		clr.b	obSubtype(a0)
		clr.b	sto_active(a0)
		rts	

