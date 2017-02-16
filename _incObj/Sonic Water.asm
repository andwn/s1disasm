# ---------------------------------------------------------------------------
# Subroutine for Sonic when he's underwater
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Water:
		cmpi.b	#1,(v_zone).w	/* is level LZ? */
		beq.s	1f	/* if yes, branch */

	2:
		rts	
# ===========================================================================

	1:
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	/* is Sonic above the water? */
		bge.s	3f	/* if yes, branch */
		bset	#6,obStatus(a0)
		bne.s	2b
		bsr.w	ResumeMusic
		move.b	#id_DrownCount,(v_objspace+0x340).w /* load bubbles object from Sonic's mouth */
		move.b	#0x81,(v_objspace+0x340+obSubtype).w
		move.w	#0x300,(v_sonspeedmax).w /* change Sonic's top speed */
		move.w	#6,(v_sonspeedacc).w /* change Sonic's acceleration */
		move.w	#0x40,(v_sonspeeddec).w /* change Sonic's deceleration */
		asr	obVelX(a0)
		asr	obVelY(a0)
		asr	obVelY(a0)	/* slow Sonic */
		beq.s	2b		/* branch if Sonic stops moving */
		move.b	#id_Splash,(v_objspace+0x300).w /* load splash object */
		sfx	sfx_Splash,1,0,0	 /* play splash sound */
# ===========================================================================

3:
		bclr	#6,obStatus(a0)
		beq.s	2b
		bsr.w	ResumeMusic
		move.w	#0x600,(v_sonspeedmax).w /* restore Sonic's speed */
		move.w	#0xC,(v_sonspeedacc).w /* restore Sonic's acceleration */
		move.w	#0x80,(v_sonspeeddec).w /* restore Sonic's deceleration */
		asl	obVelY(a0)
		beq.w	2b
		move.b	#id_Splash,(v_objspace+0x300).w /* load splash object */
		cmpi.w	#-0x1000,obVelY(a0)
		bgt.s	4f
		move.w	#-0x1000,obVelY(a0) /* set maximum speed on leaving water */

	4:
		sfx	sfx_Splash,1,0,0	 /* play splash sound */
# End of function Sonic_Water

