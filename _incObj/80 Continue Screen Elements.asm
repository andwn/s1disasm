# ---------------------------------------------------------------------------
# Object 80 - Continue screen elements
# ---------------------------------------------------------------------------

ContScrItem:
		moveq	#0,d0
		move.b	0x24(a0),d0
		move.w	CSI_Index(pc,d0.w),d1
		jmp	CSI_Index(pc,d1.w)
# ===========================================================================
CSI_Index:	dc.w CSI_Main-CSI_Index
		dc.w CSI_Display-CSI_Index
		dc.w CSI_MakeMiniSonic-CSI_Index
		dc.w CSI_ChkDel-CSI_Index
# ===========================================================================

CSI_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_ContScr,obMap(a0)
		move.w	#0x8500,obGfx(a0)
		move.b	#0,obRender(a0)
		move.b	#0x3C,obActWid(a0)
		move.w	#0x120,obX(a0)
		move.w	#0xC0,obScreenY(a0)
		move.w	#0,(v_rings).w	/* clear rings */

CSI_Display:	/* Routine 2 */
		jmp	(DisplaySprite).l
# ===========================================================================

	CSI_MiniSonicPos:
		dc.w 0x116, 0x12A, 0x102, 0x13E, 0xEE, 0x152, 0xDA, 0x166, 0xC6
		dc.w 0x17A, 0xB2,	0x18E, 0x9E, 0x1A2, 0x8A

CSI_MakeMiniSonic:
#		 Routine 4
		movea.l	a0,a1
		lea	(CSI_MiniSonicPos).l,a2
		moveq	#0,d1
		move.b	(v_continues).w,d1
		subq.b	#2,d1
		bcc.s	CSI_MoreThan1
		jmp	(DeleteObject).l	/* cancel if you have 0-1 continues */

	CSI_MoreThan1:
		moveq	#1,d3
		cmpi.b	#14,d1		/* do you have fewer than 16 continues */
		bcs.s	CSI_FewerThan16	/* if yes, branch */

		moveq	#0,d3
		moveq	#14,d1		/* cap at 15 mini-Sonics */

	CSI_FewerThan16:
		move.b	d1,d2
		andi.b	#1,d2

CSI_MiniSonicLoop:
		move.b	#id_ContScrItem,0(a1) /* load mini-Sonic object */
		move.w	(a2)+,obX(a1)	/* use above data for x-axis position */
		tst.b	d2		/* do you have an even number of continues? */
		beq.s	CSI_Even	/* if yes, branch */
		subi.w	#0xA,obX(a1)	/* shift mini-Sonics slightly to the right */

	CSI_Even:
		move.w	#0xD0,obScreenY(a1)
		move.b	#6,obFrame(a1)
		move.b	#6,obRoutine(a1)
		move.l	#Map_ContScr,obMap(a1)
		move.w	#0x8551,obGfx(a1)
		move.b	#0,obRender(a1)
		lea	0x40(a1),a1
		dbf	d1,CSI_MiniSonicLoop /* repeat for number of continues */

		lea	-0x40(a1),a1
		move.b	d3,obSubtype(a1)

CSI_ChkDel:	/* Routine 6 */
		tst.b	obSubtype(a0)	/* do you have 16 or more continues? */
		beq.s	CSI_Animate	/* if yes, branch */
		cmpi.b	#6,(v_player+obRoutine).w /* is Sonic running? */
		bcs.s	CSI_Animate	/* if not, branch */
		move.b	(v_vbla_byte).w,d0
		andi.b	#1,d0
		bne.s	CSI_Animate
		tst.w	(v_player+obVelX).w /* is Sonic running? */
		bne.s	CSI_Delete	/* if yes, goto delete */
		rts	

CSI_Animate:
		move.b	(v_vbla_byte).w,d0
		andi.b	#0xF,d0
		bne.s	CSI_Display2
		bchg	#0,obFrame(a0)

	CSI_Display2:
		jmp	(DisplaySprite).l
# ===========================================================================

CSI_Delete:
		jmp	(DeleteObject).l

