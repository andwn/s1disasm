# ---------------------------------------------------------------------------
# Object 6E - electrocution orbs (SBZ)
# ---------------------------------------------------------------------------

Electro:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Elec_Index(pc,d0.w),d1
		jmp	Elec_Index(pc,d1.w)
# ===========================================================================
Elec_Index:	dc.w Elec_Main-Elec_Index
		dc.w Elec_Shock-Elec_Index

.equ elec_freq, 0x34		/* frequency */
# ===========================================================================

Elec_Main:	/* Routine 0 */
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Elec,obMap(a0)
		move.w	#0x47E,obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#0x28,obActWid(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0 /* read object type */
		lsl.w	#4,d0		/* multiply by $10 */
		subq.w	#1,d0
		move.w	d0,elec_freq(a0)

Elec_Shock:	/* Routine 2 */
		move.w	(v_framecount).w,d0
		and.w	elec_freq(a0),d0 /* is it time to zap? */
		bne.s	1f	/* if not, branch */

		move.b	#1,obAnim(a0)	/* run "zap" animation */
		tst.b	obRender(a0)
		bpl.s	1f
		sfx	sfx_Electric,0,0,0	/* play electricity sound */

	1:
		lea	(Ani_Elec).l,a1
		jsr	(AnimateSprite).l
		move.b	#0,obColType(a0)
		cmpi.b	#4,obFrame(a0)	/* is 4th frame displayed? */
		bne.s	2f	/* if not, branch */
		move.b	#0xA4,obColType(a0) /* if yes, make object hurt Sonic */

	2:
		bra.w	RememberState

