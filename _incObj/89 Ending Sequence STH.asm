# ---------------------------------------------------------------------------
# Object 89 - "SONIC THE HEDGEHOG" text	on the ending sequence
# ---------------------------------------------------------------------------

EndSTH:
		moveq	#0,d0
		move.b	0x24(a0),d0
		move.w	ESth_Index(pc,d0.w),d1
		.if Revision==0
		jmp	ESth_Index(pc,d1.w)
		.else
		jsr	ESth_Index(pc,d1.w)
		jmp	(DisplaySprite).l
		.endc
# ===========================================================================
ESth_Index:	dc.w ESth_Main-ESth_Index
		dc.w ESth_Move-ESth_Index
		dc.w ESth_GotoCredits-ESth_Index

.equ esth_time, 0x30		/* time until exit */
# ===========================================================================

ESth_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.w	#-0x20,obX(a0)	/* object starts	outside	the level boundary */
		move.w	#0xD8,obScreenY(a0)
		move.l	#Map_ESth,obMap(a0)
		move.w	#0x5C5,obGfx(a0)
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)

ESth_Move:	/* Routine 2 */
		cmpi.w	#0xC0,obX(a0)	/* has object reached $C0? */
		beq.s	ESth_Delay	/* if yes, branch */
		addi.w	#0x10,obX(a0)	/* move object to the right */
		.if Revision==0
		bra.w	DisplaySprite
		.else
		rts
		.endc

ESth_Delay:
		addq.b	#2,obRoutine(a0)
		.if Revision==0
		move.w	#120,esth_time(a0) /* set duration for delay (2 seconds) */
		.else
		move.w	#300,esth_time(a0) /* set duration for delay (5 seconds) */
		.endc

ESth_GotoCredits:
#		 Routine 4
		subq.w	#1,esth_time(a0) /* subtract 1 from duration */
		bpl.s	ESth_Wait
		move.b	#id_Credits,(v_gamemode).w /* exit to credits */

	ESth_Wait:
		.if Revision==0
		bra.w	DisplaySprite
		.else
		rts
		.endc
