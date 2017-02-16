# ---------------------------------------------------------------------------
# Subroutine to	prevent	Sonic leaving the boundaries of	a level
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_LevelBound:
		move.l	obX(a0),d1
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(v_limitleft2).w,d0
		addi.w	#0x10,d0
		cmp.w	d1,d0		/* has Sonic touched the	side boundary? */
		bhi.s	1f		/* if yes, branch */
		move.w	(v_limitright2).w,d0
		addi.w	#0x128,d0
		tst.b	(f_lockscreen).w
		bne.s	2f
		addi.w	#0x40,d0

	2:
		cmp.w	d1,d0		/* has Sonic touched the	side boundary? */
		bls.s	1f		/* if yes, branch */

	3:
		move.w	(v_limitbtm2).w,d0
		addi.w	#0xE0,d0
		cmp.w	obY(a0),d0	/* has Sonic touched the	bottom boundary? */
		blt.s	4f		/* if yes, branch */
		rts	
# ===========================================================================

4:
		cmpi.w	#(id_SBZ<<8)+1,(v_zone).w /* is level SBZ2 ? */
		bne.w	KillSonic	/* if not, kill Sonic */
		cmpi.w	#0x2000,(v_player+obX).w
		bcs.w	KillSonic
		clr.b	(v_lastlamp).w	/* clear	lamppost counter */
		move.w	#1,(f_restart).w /* restart the level */
		move.w	#(id_LZ<<8)+3,(v_zone).w /* set level to SBZ3 (LZ4) */
		rts	
# ===========================================================================

1:
		move.w	d0,obX(a0)
		move.w	#0,obX+2(a0)
		move.w	#0,obVelX(a0)	/* stop Sonic moving */
		move.w	#0,obInertia(a0)
		bra.s	3b
# End of function Sonic_LevelBound

