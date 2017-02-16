# ---------------------------------------------------------------------------
# Subroutine to display Sonic and set music
# ---------------------------------------------------------------------------
.equ flashtime, 0x30		/* time between flashes after getting hit */
.equ invtime, 0x32		/* time left for invincibility */
.equ shoetime, 0x34		/* time left for speed shoes */

Sonic_Display:
		move.w	flashtime(a0),d0
		beq.s	1f
		subq.w	#1,flashtime(a0)
		lsr.w	#3,d0
		bcc.s	2f

	1:
		jsr	(DisplaySprite).l

	2:
		tst.b	(v_invinc).w	/* does Sonic have invincibility? */
		beq.s	3f	/* if not, branch */
		tst.w	invtime(a0)	/* check	time remaining for invinciblity */
		beq.s	3f	/* if no	time remains, branch */
		subq.w	#1,invtime(a0)	/* subtract 1 from time */
		bne.s	3f
		tst.b	(f_lockscreen).w
		bne.s	4f
		cmpi.w	#0xC,(v_air).w
		bcs.s	4f
		moveq	#0,d0
		move.b	(v_zone).w,d0
		cmpi.w	#(id_LZ<<8)+3,(v_zone).w /* check if level is SBZ3 */
		bne.s	5f
		moveq	#5,d0		/* play SBZ music */

	5:
		lea	(MusicList2).l,a1
		move.b	(a1,d0.w),d0
		jsr	(PlaySound).l	/* play normal music */

	4:
		move.b	#0,(v_invinc).w /* cancel invincibility */

	3:
		tst.b	(v_shoes).w	/* does Sonic have speed	shoes? */
		beq.s	6f		/* if not, branch */
		tst.w	shoetime(a0)	/* check	time remaining */
		beq.s	6f
		subq.w	#1,shoetime(a0)	/* subtract 1 from time */
		bne.s	6f
		move.w	#0x600,(v_sonspeedmax).w /* restore Sonic's speed */
		move.w	#0xC,(v_sonspeedacc).w /* restore Sonic's acceleration */
		move.w	#0x80,(v_sonspeeddec).w /* restore Sonic's deceleration */
		move.b	#0,(v_shoes).w	/* cancel speed shoes */
		music	bgm_Slowdown,1,0,0	/* run music at normal speed */

	6:
		rts	

