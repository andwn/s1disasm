# ---------------------------------------------------------------------------
# Modified (early?) SMPS 68k Type 1b
# ---------------------------------------------------------------------------
# Go_SoundTypes:
Go_SoundPriorities:	dc.l SoundPriorities
# Go_SoundD0:
Go_SpecSoundIndex:	dc.l SpecSoundIndex
Go_MusicIndex:		dc.l MusicIndex
Go_SoundIndex:		dc.l SoundIndex
# off_719A0:
Go_SpeedUpIndex:	dc.l SpeedUpIndex
Go_PSGIndex:		dc.l PSG_Index
# ---------------------------------------------------------------------------
# PSG instruments used in music
# ---------------------------------------------------------------------------
PSG_Index:
		dc.l PSG1, PSG2, PSG3
		dc.l PSG4, PSG5, PSG6
		dc.l PSG7, PSG8, PSG9
PSG1:		.incbin	"sound/psg/psg1.bin"
PSG2:		.incbin	"sound/psg/psg2.bin"
PSG3:		.incbin	"sound/psg/psg3.bin"
PSG4:		.incbin	"sound/psg/psg4.bin"
PSG6:		.incbin	"sound/psg/psg6.bin"
PSG5:		.incbin	"sound/psg/psg5.bin"
PSG7:		.incbin	"sound/psg/psg7.bin"
PSG8:		.incbin	"sound/psg/psg8.bin"
PSG9:		.incbin	"sound/psg/psg9.bin"
# ---------------------------------------------------------------------------
# New tempos for songs during speed shoes
# ---------------------------------------------------------------------------
# DANGER! several songs will use the first few bytes of MusicIndex as their main
# tempos while speed shoes are active. If you don't want that, you should add
# their "correct" sped-up main tempos to the list.
# byte_71A94:
SpeedUpIndex:
		dc.b 7		/* GHZ */
		dc.b 0x72	/* LZ */
		dc.b 0x73	/* MZ */
		dc.b 0x26	/* SLZ */
		dc.b 0x15	/* SYZ */
		dc.b 8		/* SBZ */
		dc.b 0xFF	/* Invincibility */
		dc.b 5		/* Extra Life */
#		dc.b ?		; Special Stage
#		dc.b ?		; Title Screen
#		dc.b ?		; Ending
#		dc.b ?		; Boss
#		dc.b ?		; FZ
#		dc.b ?		; Sonic Got Through
#		dc.b ?		; Game Over
#		dc.b ?		; Continue Screen
#		dc.b ?		; Credits
#		dc.b ?		; Drowning
#		dc.b ?		; Get Emerald

# ---------------------------------------------------------------------------
# Music	Pointers
# ---------------------------------------------------------------------------
MusicIndex:
ptr_mus81:	dc.l Music81
ptr_mus82:	dc.l Music82
ptr_mus83:	dc.l Music83
ptr_mus84:	dc.l Music84
ptr_mus85:	dc.l Music85
ptr_mus86:	dc.l Music86
ptr_mus87:	dc.l Music87
ptr_mus88:	dc.l Music88
ptr_mus89:	dc.l Music89
ptr_mus8A:	dc.l Music8A
ptr_mus8B:	dc.l Music8B
ptr_mus8C:	dc.l Music8C
ptr_mus8D:	dc.l Music8D
ptr_mus8E:	dc.l Music8E
ptr_mus8F:	dc.l Music8F
ptr_mus90:	dc.l Music90
ptr_mus91:	dc.l Music91
ptr_mus92:	dc.l Music92
ptr_mus93:	dc.l Music93
ptr_musend:
# ---------------------------------------------------------------------------
# Priority of sound. New music or SFX must have a priority higher than or equal
# to what is stored in v_sndprio or it won't play. If bit 7 of new priority is
# set ($80 and up), the new music or SFX will not set its priority -- meaning
# any music or SFX can override it (as long as it can override whatever was
# playing before). Usually, SFX will only override SFX, special SFX ($D0-$DF)
# will only override special SFX and music will only override music.
# ---------------------------------------------------------------------------
# SoundTypes:
SoundPriorities:
		dc.b     0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90	/* $81 */
		dc.b 0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90	/* $90 */
		dc.b 0x80,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x68,0x70,0x70,0x70,0x60,0x70	/* $A0 */
		dc.b 0x70,0x60,0x70,0x60,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x7F	/* $B0 */
		dc.b 0x60,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70,0x70	/* $C0 */
		dc.b 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80	/* $D0 */
		dc.b 0x90,0x90,0x90,0x90,0x90                                            	/* $E0 */

# ---------------------------------------------------------------------------
# Subroutine to update music more than once per frame
# (Called by horizontal & vert. interrupts)
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71B4C:
UpdateMusic:
		stopZ80
		nop	
		nop	
		nop	
# loc_71B5A:
1:
		btst	#0,(z80_bus_request).l		/* Is the z80 busy? */
		bne.s	1b			/* If so, wait */

		btst	#7,(z80_dac_status).l		/* Is DAC accepting new samples? */
		beq.s	2f			/* Branch if yes */
		startZ80
		nop	
		nop	
		nop	
		nop	
		nop	
		bra.s	UpdateMusic
# ===========================================================================
# loc_71B82:
2:
		lea	(v_snddriver_ram&0xFFFFFF).l,a6
		clr.b	f_voice_selector(a6)
		tst.b	f_stopmusic(a6)			/* is music paused? */
		bne.w	PauseMusic			/* if yes, branch */
		subq.b	#1,v_main_tempo_timeout(a6)	/* Has main tempo timer expired? */
		bne.s	3f
		jsr	TempoWait(pc)
# loc_71B9E:
3:
		move.b	v_fadeout_counter(a6),d0
		beq.s	4f
		jsr	DoFadeOut(pc)
# loc_71BA8:
4:
		tst.b	f_fadein_flag(a6)
		beq.s	5f
		jsr	DoFadeIn(pc)
# loc_71BB2:
5:
#		 DANGER! The following line only checks v_playsnd1 and v_playsnd2, breaking v_playnull.
		tst.w	v_playsnd1(a6)		/* is a music or sound queued for played? */
		beq.s	6f		/* if not, branch */
		jsr	CycleSoundQueue(pc)
# loc_71BBC:
6:
		cmpi.b	#0x80,v_playsnd0(a6)	/* is song queue set for silence (empty)? */
		beq.s	7f		/* If yes, branch */
		jsr	PlaySoundID(pc)
# loc_71BC8:
7:
		lea	v_music_dac_track(a6),a5
		tst.b	(a5)			/* Is DAC track playing? (zTrackPlaybackControl) */
		bpl.s	8f		/* Branch if not */
		jsr	DACUpdateTrack(pc)
# loc_71BD4:
8:
		clr.b	f_updating_dac(a6)
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/zTrackSz)-1,d7	/* 6 FM tracks */
# loc_71BDA:
9:
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	10f		/* Branch if not */
		jsr	FMUpdateTrack(pc)
# loc_71BE6:
10:
		dbf	d7,9b

		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d7 /* 3 PSG tracks */
# loc_71BEC:
11:
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	12f		/* Branch if not */
		jsr	PSGUpdateTrack(pc)
# loc_71BF8:
12:
		dbf	d7,11b

		move.b	#0x80,f_voice_selector(a6)			/* Now at SFX tracks */
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/zTrackSz)-1,d7	/* 3 FM tracks (SFX) */
# loc_71C04:
13:
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	14f		/* Branch if not */
		jsr	FMUpdateTrack(pc)
# loc_71C10:
14:
		dbf	d7,13b

		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/zTrackSz)-1,d7 /* 3 PSG tracks (SFX) */
# loc_71C16:
15:
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	16f		/* Branch of not */
		jsr	PSGUpdateTrack(pc)
# loc_71C22:
16:
		dbf	d7,15b
		
		move.b	#0x40,f_voice_selector(a6) /* Now at special SFX tracks */
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	17f		/* Branch if not */
		jsr	FMUpdateTrack(pc)
# loc_71C38:
17:
		adda.w	#zTrackSz,a5
		tst.b	(a5)			/* Is track playing (zTrackPlaybackControl) */
		bpl.s	DoStartZ80		/* Branch if not */
		jsr	PSGUpdateTrack(pc)
# loc_71C44:
DoStartZ80:
		startZ80
		rts	
# End of function UpdateMusic


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71C4E: UpdateDAC:
DACUpdateTrack:
		subq.b	#1,zTrackDurationTimeout(a5)	/* Has DAC sample timeout expired? */
		bne.s	1f				/* Return if not */
		move.b	#0x80,f_updating_dac(a6)		/* Set flag to indicate this is the DAC */
		movea.l	zTrackDataPointer(a5),a4	/* DAC track data pointer */
# loc_71C5E:
2:
		moveq	#0,d5
		move.b	(a4)+,d5	/* Get next SMPS unit */
		cmpi.b	#0xE0,d5		/* Is it a coord. flag? */
		blo.s	3f	/* Branch if not */
		jsr	CoordFlag(pc)
		bra.s	2b
# ===========================================================================
# loc_71C6E:
3:
		tst.b	d5			/* Is it a sample? */
		bpl.s	4f		/* Branch if not (duration) */
		move.b	d5,zTrackSavedDAC(a5)	/* Store new sample */
		move.b	(a4)+,d5		/* Get another byte */
		bpl.s	4f		/* Branch if it is a duration */
		subq.w	#1,a4			/* Put byte back */
		move.b	zTrackSavedDuration(a5),zTrackDurationTimeout(a5) /* Use last duration */
		bra.s	5f
# ===========================================================================
# loc_71C84:
4:
		jsr	SetDuration(pc)
# loc_71C88:
5:
		move.l	a4,zTrackDataPointer(a5) /* Save pointer */
		btst	#2,(a5)			/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	1f			/* Return if yes */
		moveq	#0,d0
		move.b	zTrackSavedDAC(a5),d0	/* Get sample */
		cmpi.b	#0x80,d0			/* Is it a rest? */
		beq.s	1f			/* Return if yes */
		btst	#3,d0			/* Is bit 3 set (samples between $88-$8F)? */
		bne.s	6f		/* Various timpani */
		move.b	d0,(z80_dac_sample).l
# locret_71CAA:
1:
		rts	
# ===========================================================================
# loc_71CAC:
6:
		subi.b	#0x88,d0		/* Convert into an index */
		move.b	DAC_sample_rate(pc,d0.w),d0
#		 Warning: this affects the raw pitch of sample $83, meaning it will
#		 use this value from then on.
		move.b	d0,(z80_dac3_pitch).l
		move.b	#0x83,(z80_dac_sample).l	/* Use timpani */
		rts	
# End of function DACUpdateTrack

# ===========================================================================
# Note: this only defines rates for samples $88-$8D, meaning $8E-$8F are invalid.
# Also, $8C-$8D are so slow you may want to skip them.
# byte_71CC4:
DAC_sample_rate: dc.b 0x12, 0x15, 0x1C, 0x1D, 0xFF, 0xFF

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71CCA:
FMUpdateTrack:
		subq.b	#1,zTrackDurationTimeout(a5) /* Update duration timeout */
		bne.s	1f		/* Branch if it hasn't expired */
		bclr	#4,(a5)			/* Clear 'do not attack next note' bit (zTrackPlaybackControl) */
		jsr	FMDoNext(pc)
		jsr	FMPrepareNote(pc)
		bra.w	FMNoteOn
# ===========================================================================
# loc_71CE0:
1:
		jsr	NoteFillUpdate(pc)
		jsr	DoModulation(pc)
		bra.w	FMUpdateFreq
# End of function FMUpdateTrack


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71CEC:
FMDoNext:
		movea.l	zTrackDataPointer(a5),a4 /* Track data pointer */
		bclr	#1,(a5)			/* Clear 'track at rest' bit (zTrackPlaybackControl) */
# loc_71CF4:
1:
		moveq	#0,d5
		move.b	(a4)+,d5	/* Get byte from track */
		cmpi.b	#0xE0,d5		/* Is this a coord. flag? */
		blo.s	2f	/* Branch if not */
		jsr	CoordFlag(pc)
		bra.s	1b
# ===========================================================================
# loc_71D04:
2:
		jsr	FMNoteOff(pc)
		tst.b	d5		/* Is this a note? */
		bpl.s	3f	/* Branch if not */
		jsr	FMSetFreq(pc)
		move.b	(a4)+,d5	/* Get another byte */
		bpl.s	3f	/* Branch if it is a duration */
		subq.w	#1,a4		/* Otherwise, put it back */
		bra.w	FinishTrackUpdate
# ===========================================================================
# loc_71D1A:
3:
		jsr	SetDuration(pc)
		bra.w	FinishTrackUpdate
# End of function FMDoNext


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71D22:
FMSetFreq:
		subi.b	#0x80,d5			/* Make it a zero-based index */
		beq.s	TrackSetRest
		add.b	zTrackTranspose(a5),d5	/* Add track transposition */
		andi.w	#0x7F,d5			/* Clear high byte and sign bit */
		lsl.w	#1,d5
		lea	FMFrequencies(pc),a0
		move.w	(a0,d5.w),d6
		move.w	d6,zTrackFreq(a5)	/* Store new frequency */
		rts	
# End of function FMSetFreq


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71D40:
SetDuration:
		move.b	d5,d0
		move.b	zTrackTempoDivider(a5),d1	/* Get dividing timing */
# loc_71D46:
1:
		subq.b	#1,d1
		beq.s	2f
		add.b	d5,d0
		bra.s	1b
# ===========================================================================
# loc_71D4E:
2:
		move.b	d0,zTrackSavedDuration(a5)	/* Save duration */
		move.b	d0,zTrackDurationTimeout(a5)	/* Save duration timeout */
		rts	
# End of function SetDuration

# ===========================================================================
# loc_71D58:
TrackSetRest:
		bset	#1,(a5)		/* Set 'track at rest' bit (zTrackPlaybackControl) */
		clr.w	zTrackFreq(a5)	/* Clear frequency */

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71D60:
FinishTrackUpdate:
		move.l	a4,zTrackDataPointer(a5)	/* Store new track position */
		move.b	zTrackSavedDuration(a5),zTrackDurationTimeout(a5)	/* Reset note timeout */
		btst	#4,(a5)				/* Is track set to not attack note? (zTrackPlaybackControl) */
		bne.s	1f				/* If so, branch */
		move.b	zTrackNoteFillMaster(a5),zTrackNoteFillTimeout(a5)	/* Reset note fill timeout */
		clr.b	zTrackVolEnvIndex(a5)		/* Reset PSG volume envelope index (even on FM tracks...) */
		btst	#3,(a5)				/* Is modulation on? */
		beq.s	1f				/* If not, return (zTrackPlaybackControl) */
		movea.l	zTrackModulationPtr(a5),a0	/* Modulation data pointer */
		move.b	(a0)+,zTrackModulationWait(a5)	/* Reset wait */
		move.b	(a0)+,zTrackModulationSpeed(a5)	/* Reset speed */
		move.b	(a0)+,zTrackModulationDelta(a5)	/* Reset delta */
		move.b	(a0)+,d0			/* Get steps */
		lsr.b	#1,d0				/* Halve them */
		move.b	d0,zTrackModulationSteps(a5)	/* Then store */
		clr.w	zTrackModulationVal(a5)		/* Reset frequency change */
# locret_71D9C:
1:
		rts	
# End of function FinishTrackUpdate


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71D9E:
NoteFillUpdate:
		tst.b	zTrackNoteFillTimeout(a5)	/* Is note fill on? */
		beq.s	1f
		subq.b	#1,zTrackNoteFillTimeout(a5)	/* Update note fill timeout */
		bne.s	1f				/* Return if it hasn't expired */
		bset	#1,(a5)				/* Put track at rest (zTrackPlaybackControl) */
		tst.b	zTrackVoiceControl(a5)		/* Is this a psg track? */
		bmi.w	2f			/* If yes, branch */
		jsr	FMNoteOff(pc)
		addq.w	#4,sp				/* Do not return to caller */
		rts	
# ===========================================================================
# loc_71DBE:
2:
		jsr	PSGNoteOff(pc)
		addq.w	#4,sp		/* Do not return to caller */
# locret_71DC4:
1:
		rts	
# End of function NoteFillUpdate


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71DC6:
DoModulation:
		addq.w	#4,sp				/* Do not return to caller (but see below) */
		btst	#3,(a5)				/* Is modulation active? (zTrackPlaybackControl) */
		beq.s	1f				/* Return if not */
		tst.b	zTrackModulationWait(a5)	/* Has modulation wait expired? */
		beq.s	2f			/* If yes, branch */
		subq.b	#1,zTrackModulationWait(a5)	/* Update wait timeout */
		rts	
# ===========================================================================
# loc_71DDA:
2:
		subq.b	#1,zTrackModulationSpeed(a5)	/* Update speed */
		beq.s	3f		/* If it expired, want to update modulation */
		rts	
# ===========================================================================
# loc_71DE2:
3:
		movea.l	zTrackModulationPtr(a5),a0	/* Get modulation data */
		move.b	1(a0),zTrackModulationSpeed(a5)	/* Restore modulation speed */
		tst.b	zTrackModulationSteps(a5)	/* Check number of steps */
		bne.s	4f			/* If nonzero, branch */
		move.b	3(a0),zTrackModulationSteps(a5)	/* Restore from modulation data */
		neg.b	zTrackModulationDelta(a5)	/* Negate modulation delta */
		rts	
# ===========================================================================
# loc_71DFE:
4:
		subq.b	#1,zTrackModulationSteps(a5)	/* Update modulation steps */
		move.b	zTrackModulationDelta(a5),d6	/* Get modulation delta */
		ext.w	d6
		add.w	zTrackModulationVal(a5),d6	/* Add cumulative modulation change */
		move.w	d6,zTrackModulationVal(a5)	/* Store it */
		add.w	zTrackFreq(a5),d6		/* Add note frequency to it */
		subq.w	#4,sp		/* In this case, we want to return to caller after all */
# locret_71E16:
1:
		rts	
# End of function DoModulation


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_71E18:
FMPrepareNote:
		btst	#1,(a5)			/* Is track resting? (zTrackPlaybackControl) */
		bne.s	locret_71E48		/* Return if so */
		move.w	zTrackFreq(a5),d6	/* Get current note frequency */
		beq.s	FMSetRest		/* Branch if zero */
# loc_71E24:
FMUpdateFreq:
		move.b	zTrackDetune(a5),d0 	/* Get detune value */
		ext.w	d0
		add.w	d0,d6			/* Add note frequency */
		btst	#2,(a5)			/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	locret_71E48		/* Return if so */
		move.w	d6,d1
		lsr.w	#8,d1
		move.b	#0xA4,d0			/* Register for upper 6 bits of frequency */
		jsr	WriteFMIorII(pc)
		move.b	d6,d1
		move.b	#0xA0,d0			/* Register for lower 8 bits of frequency */
		jsr	WriteFMIorII(pc)	/* (It would be better if this were a jmp) */
# locret_71E48:
locret_71E48:
		rts	
# ===========================================================================
# loc_71E4A:
FMSetRest:
		bset	#1,(a5)		/* Set 'track at rest' bit (zTrackPlaybackControl) */
		rts	
# End of function FMPrepareNote

# ===========================================================================
# loc_71E50:
PauseMusic:
		bmi.s	1f		/* Branch if music is being unpaused */
		cmpi.b	#2,f_stopmusic(a6)
		beq.w	2f
		move.b	#2,f_stopmusic(a6)
		moveq	#2,d3
		move.b	#0xB4,d0		/* Command to set AMS/FMS/panning */
		moveq	#0,d1		/* No panning, AMS or FMS */
# loc_71E6A:
3:
		jsr	WriteFMI(pc)
		jsr	WriteFMII(pc)
		addq.b	#1,d0
		dbf	d3,3b

		moveq	#2,d3
		moveq	#0x28,d0		/* Key on/off register */
# loc_71E7C:
4:
		move.b	d3,d1		/* FM1, FM2, FM3 */
		jsr	WriteFMI(pc)
		addq.b	#4,d1		/* FM4, FM5, FM6 */
		jsr	WriteFMI(pc)
		dbf	d3,4b

		jsr	PSGSilenceAll(pc)
		bra.w	DoStartZ80
# ===========================================================================
# loc_71E94:
1:
		clr.b	f_stopmusic(a6)
		moveq	#zTrackSz,d3
		lea	v_music_fmdac_tracks(a6),a5
		moveq	#((v_music_fmdac_tracks_end-v_music_fmdac_tracks)/zTrackSz)-1,d4	/* 6 FM + 1 DAC tracks */
# loc_71EA0:
5:
		btst	#7,(a5)			/* Is track playing? (zTrackPlaybackControl) */
		beq.s	6f		/* Branch if not */
		btst	#2,(a5)			/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	6f		/* Branch if yes */
		move.b	#0xB4,d0			/* Command to set AMS/FMS/panning */
		move.b	zTrackAMSFMSPan(a5),d1	/* Get value from track RAM */
		jsr	WriteFMIorII(pc)
# loc_71EB8:
6:
		adda.w	d3,a5
		dbf	d4,5b

		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/zTrackSz)-1,d4	/* 3 FM tracks (SFX) */
# loc_71EC4:
7:
		btst	#7,(a5)			/* Is track playing? (zTrackPlaybackControl) */
		beq.s	8f		/* Branch if not */
		btst	#2,(a5)			/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	8f		/* Branch if yes */
		move.b	#0xB4,d0			/* Command to set AMS/FMS/panning */
		move.b	zTrackAMSFMSPan(a5),d1	/* Get value from track RAM */
		jsr	WriteFMIorII(pc)
# loc_71EDC:
8:
		adda.w	d3,a5
		dbf	d4,7b

		lea	v_spcsfx_track_ram(a6),a5
		btst	#7,(a5)			/* Is track playing? (zTrackPlaybackControl) */
		beq.s	2f		/* Branch if not */
		btst	#2,(a5)			/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	2f		/* Branch if yes */
		move.b	#0xB4,d0			/* Command to set AMS/FMS/panning */
		move.b	zTrackAMSFMSPan(a5),d1	/* Get value from track RAM */
		jsr	WriteFMIorII(pc)
# loc_71EFE:
2:
		bra.w	DoStartZ80

# ---------------------------------------------------------------------------
# Subroutine to	play a sound or	music track
# ---------------------------------------------------------------------------

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Sound_Play:
CycleSoundQueue:
		movea.l	(Go_SoundPriorities).l,a0
		lea	v_playsnd1(a6),a1	/* load music track number */
		move.b	v_sndprio(a6),d3	/* Get priority of currently playing SFX */
		nop /* doing this again for bindiff */
		moveq	#2,d4			/* Number of queues-1 (v_playsnd1, v_playsnd2, v_playnull) */
# loc_71F12:
1:
		move.b	(a1),d0			/* move track number to d0 */
		move.b	d0,d1
		clr.b	(a1)+			/* Clear entry */
		subi.b	#bgm__First,d0		/* Make it into 0-based index */
		blo.s	2f		/* If negative (i.e., it was $80 or lower), branch */
		cmpi.b	#0x80,v_playsnd0(a6)	/* Is v_playsnd0 a $80 (silence/empty)? */
		beq.s	3f		/* If yes, branch */
		move.b	d1,v_playsnd1(a6)	/* Put sound into v_playsnd1 */
		bra.s	2f
# ===========================================================================
# loc_71F2C:
3:
		andi.w	#0x7F,d0			/* Clear high byte and sign bit */
		move.b	(a0,d0.w),d2		/* Get sound type */
		cmp.b	d3,d2			/* Is it a lower priority sound? */
		blo.s	2f		/* Branch if yes */
		move.b	d2,d3			/* Store new priority */
		move.b	d1,v_playsnd0(a6)	/* Queue sound for play */
# loc_71F3E:
2:
		dbf	d4,1b

		tst.b	d3			/* We don't want to change sound priority if it is negative */
		bmi.s	4f
		nop /* doing this again for bindiff */
		move.b	d3,v_sndprio(a6)	/* Set new sound priority */
# locret_71F4A:
4:
		rts	
# End of function CycleSoundQueue


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Sound_ChkValue:
PlaySoundID:
		moveq	#0,d7
		move.b	v_playsnd0(a6),d7
		beq.w	StopAllSound
		bpl.s	1f			/* If >= 0, return (not a valid sound, bgm or command) */
		move.b	#0x80,v_playsnd0(a6)	/* reset	music flag */
#		 DANGER! Music ends at $93, yet this checks until $9F; attempting to
#		 play sounds $94-$9F will cause a crash! Remove the '+$C' to fix this.
#		 See LevSel_NoCheat for more.
		cmpi.b	#bgm__Last+0xC,d7	/* Is this music ($81-$9F)? */
		bls.w	Sound_PlayBGM		/* Branch if yes */
		cmpi.b	#sfx__First,d7		/* Is this after music but before sfx? (redundant check) */
		blo.w	1f			/* Return if yes */
		cmpi.b	#sfx__Last,d7		/* Is this sfx ($A0-$CF)? */
		bls.w	Sound_PlaySFX		/* Branch if yes */
		cmpi.b	#spec__First,d7		/* Is this after sfx but before special sfx? (redundant check) */
		blo.w	1f			/* Return if yes */
#		 DANGER! Special SFXes end at $D0, yet this checks until $DF; attempting to
#		 play sounds $D1-$DF will cause a crash! Remove the '+$10' and change the 'blo' to a 'bls'
#		 and uncomment the two lines below to fix this.
		cmpi.b	#spec__Last+0x10,d7	/* Is this special sfx ($D0-$DF)? */
		blo.w	Sound_PlaySpecial	/* Branch if yes */
#		cmpi.b	#flg__First,d7		; Is this after special sfx but before $E0?
#		blo.w	@locret			; Return if yes
		cmpi.b	#flg__Last,d7		/* Is this $E0-$E4? */
		bls.s	Sound_E0toE4		/* Branch if yes */
# locret_71F8C:
1:
		rts	
# ===========================================================================

Sound_E0toE4:
		subi.b	#flg__First,d7
		lsl.w	#2,d7
		jmp	Sound_ExIndex(pc,d7.w)
# ===========================================================================

Sound_ExIndex:
ptr_flgE0:	bra.w	FadeOutMusic		/* $E0 */
ptr_flgE1:	bra.w	PlaySegaSound		/* $E1 */
ptr_flgE2:	bra.w	SpeedUpMusic		/* $E2 */
ptr_flgE3:	bra.w	SlowDownMusic		/* $E3 */
ptr_flgE4:	bra.w	StopAllSound		/* $E4 */
ptr_flgend:
# ===========================================================================
# ---------------------------------------------------------------------------
# Play "Say-gaa" PCM sound
# ---------------------------------------------------------------------------
# Sound_E1: PlaySega:
PlaySegaSound:
		move.b	#0x88,(z80_dac_sample).l	/* Queue Sega PCM */
		startZ80
		move.w	#0x11,d1
# loc_71FC0:
1:
		move.w	#-1,d0
# loc_71FC4:
2:
		nop	
		dbf	d0,2b

		dbf	d1,1b

		addq.w	#4,sp	/* Tamper return value so we don't return to caller */
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Play music track $81-$9F
# ---------------------------------------------------------------------------
# Sound_81to9F:
Sound_PlayBGM:
		cmpi.b	#bgm_ExtraLife,d7	/* is the "extra life" music to be played? */
		bne.s	1f		/* if not, branch */
		tst.b	f_1up_playing(a6)	/* Is a 1-up music playing? */
		bne.w	2f		/* if yes, branch */
		lea	v_music_track_ram(a6),a5
		moveq	#((v_music_track_ram_end-v_music_track_ram)/zTrackSz)-1,d0	/* 1 DAC + 6 FM + 3 PSG tracks */
# loc_71FE6:
3:
		bclr	#2,(a5)			/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		adda.w	#zTrackSz,a5
		dbf	d0,3b

		lea	v_sfx_track_ram(a6),a5
		moveq	#((v_sfx_track_ram_end-v_sfx_track_ram)/zTrackSz)-1,d0	/* 3 FM + 3 PSG tracks (SFX) */
# loc_71FF8:
4:
		bclr	#7,(a5)			/* Clear 'track is playing' bit (zTrackPlaybackControl) */
		adda.w	#zTrackSz,a5
		dbf	d0,4b

		nop /* doing this again for bindiff */
		clr.b	v_sndprio(a6)		/* Clear priority */
		movea.l	a6,a0
		lea	v_1up_ram_copy(a6),a1
		move.w	#((v_music_track_ram_end-v_startofvariables)/4)-1,d0	/* Backup $220 bytes: all variables and music track data */
# loc_72012:
5:
		move.l	(a0)+,(a1)+
		dbf	d0,5b

		move.b	#0x80,f_1up_playing(a6)
		nop /* doing this again for bindiff */
		clr.b	v_sndprio(a6)		/* Clear priority again (?) */
		bra.s	6f
# ===========================================================================
# loc_72024:
1:
		clr.b	f_1up_playing(a6)
		clr.b	v_fadein_counter(a6)
# loc_7202C:
6:
		jsr	InitMusicPlayback(pc)
		movea.l	(Go_SpeedUpIndex).l,a4
		subi.b	#bgm__First,d7
		move.b	(a4,d7.w),v_speeduptempo(a6)
		movea.l	(Go_MusicIndex).l,a4
		lsl.w	#2,d7
		movea.l	(a4,d7.w),a4		/* a4 now points to (uncompressed) song data */
		moveq	#0,d0
		move.w	(a4),d0			/* load voice pointer */
		add.l	a4,d0			/* It is a relative pointer */
		move.l	d0,v_voice_ptr(a6)
		move.b	5(a4),d0		/* load tempo */
		move.b	d0,v_tempo_mod(a6)
		tst.b	f_speedup(a6)
		beq.s	7f
		move.b	v_speeduptempo(a6),d0
# loc_72068:
7:
		move.b	d0,v_main_tempo(a6)
		move.b	d0,v_main_tempo_timeout(a6)
		moveq	#0,d1
		movea.l	a4,a3
		addq.w	#6,a4			/* Point past header */
		moveq	#0,d7
		move.b	2(a3),d7		/* load number of FM+DAC tracks */
		beq.w	8f		/* branch if zero */
		subq.b	#1,d7
		move.b	#0xC0,d1			/* Default AMS+FMS+Panning */
		move.b	4(a3),d4		/* load tempo dividing timing */
		moveq	#zTrackSz,d6
		move.b	#1,d5			/* Note duration for first "note" */
		lea	v_music_fmdac_tracks(a6),a1
		lea	FMDACInitBytes(pc),a2
# loc_72098:
9:
		bset	#7,(a1)				/* Initial playback control: set 'track playing' bit (zTrackPlaybackControl) */
		move.b	(a2)+,zTrackVoiceControl(a1)	/* Voice control bits */
		move.b	d4,zTrackTempoDivider(a1)
		move.b	d6,zTrackStackPointer(a1)	/* set "gosub" (coord flag F8h) stack init value */
		move.b	d1,zTrackAMSFMSPan(a1)		/* Set AMS/FMS/Panning */
		move.b	d5,zTrackDurationTimeout(a1)	/* Set duration of first "note" */
		moveq	#0,d0
		move.w	(a4)+,d0			/* load DAC/FM pointer */
		add.l	a3,d0				/* Relative pointer */
		move.l	d0,zTrackDataPointer(a1)	/* Store track pointer */
		move.w	(a4)+,zTrackTranspose(a1)	/* load FM channel modifier */
		adda.w	d6,a1
		dbf	d7,9b
		
		cmpi.b	#7,2(a3)	/* Are 7 FM tracks defined? */
		bne.s	10f
		moveq	#0x2B,d0		/* DAC enable/disable register */
		moveq	#0,d1		/* Disable DAC */
		jsr	WriteFMI(pc)
		bra.w	8f
# ===========================================================================
# loc_720D8:
10:
		moveq	#0x28,d0		/* Key on/off register */
		moveq	#6,d1		/* Note off on all operators of channel 6 */
		jsr	WriteFMI(pc)
		move.b	#0x42,d0		/* TL for operator 1 of FM6 */
		moveq	#0x7F,d1		/* Total silence */
		jsr	WriteFMII(pc)
		move.b	#0x4A,d0		/* TL for operator 3 of FM6 */
		moveq	#0x7F,d1		/* Total silence */
		jsr	WriteFMII(pc)
		move.b	#0x46,d0		/* TL for operator 2 of FM6 */
		moveq	#0x7F,d1		/* Total silence */
		jsr	WriteFMII(pc)
		move.b	#0x4E,d0		/* TL for operator 4 of FM6 */
		moveq	#0x7F,d1		/* Total silence */
		jsr	WriteFMII(pc)
		move.b	#0xB6,d0		/* AMS/FMS/panning of FM6 */
		move.b	#0xC0,d1		/* Stereo */
		jsr	WriteFMII(pc)
# loc_72114:
8:
		moveq	#0,d7
		move.b	3(a3),d7	/* Load number of PSG tracks */
		beq.s	11f	/* branch if zero */
		subq.b	#1,d7
		lea	v_music_psg_tracks(a6),a1
		lea	PSGInitBytes(pc),a2
# loc_72126:
12:
		bset	#7,(a1)				/* Initial playback control: set 'track playing' bit (zTrackPlaybackControl) */
		move.b	(a2)+,zTrackVoiceControl(a1)	/* Voice control bits */
		move.b	d4,zTrackTempoDivider(a1)
		move.b	d6,zTrackStackPointer(a1)	/* set "gosub" (coord flag F8h) stack init value */
		move.b	d5,zTrackDurationTimeout(a1)	/* Set duration of first "note" */
		moveq	#0,d0
		move.w	(a4)+,d0			/* load PSG channel pointer */
		add.l	a3,d0				/* Relative pointer */
		move.l	d0,zTrackDataPointer(a1)	/* Store track pointer */
		move.w	(a4)+,zTrackTranspose(a1)	/* load PSG modifier */
		move.b	(a4)+,d0			/* load redundant byte */
		move.b	(a4)+,zTrackVoiceIndex(a1)	/* Initial PSG tone */
		adda.w	d6,a1
		dbf	d7,12b
# loc_72154:
11:
		lea	v_sfx_track_ram(a6),a1
		moveq	#((v_sfx_track_ram_end-v_sfx_track_ram)/zTrackSz)-1,d7	/* 6 SFX tracks */
# loc_7215A:
13:
		tst.b	(a1)		/* Is SFX playing? (zTrackPlaybackControl) */
		bpl.w	14f	/* Branch if not */
		moveq	#0,d0
		move.b	zTrackVoiceControl(a1),d0 /* Get voice control bits */
		bmi.s	15f		/* Branch if this is a PSG channel */
		subq.b	#2,d0			/* SFX can't have FM1 or FM2 */
		lsl.b	#2,d0			/* Convert to index */
		bra.s	16f
# ===========================================================================
# loc_7216E:
15:
		lsr.b	#3,d0		/* Convert to index */
# loc_72170:
16:
		lea	SFX_BGMChannelRAM(pc),a0
		movea.l	(a0,d0.w),a0
		bset	#2,(a0)		/* Set 'SFX is overriding' bit */
# loc_7217C:
14:
		adda.w	d6,a1
		dbf	d7,13b

		tst.w	v_spcsfx_fm4_track+zTrackPlaybackControl(a6)	/* Is special SFX being played? */
		bpl.s	17f				/* Branch if not */
		bset	#2,v_music_fm4_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
# loc_7218E:
17:
		tst.w	v_spcsfx_psg3_track+zTrackPlaybackControl(a6)	/* Is special SFX being played? */
		bpl.s	18f					/* Branch if not */
		bset	#2,v_music_psg3_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
# loc_7219A:
18:
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/zTrackSz)-1,d4	/* 6 FM tracks */
# loc_721A0:
19:
		jsr	FMNoteOff(pc)
		adda.w	d6,a5
		dbf	d4,19b		/* run all FM tracks */
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d4 /* 3 PSG tracks */
# loc_721AC:
20:
		jsr	PSGNoteOff(pc)
		adda.w	d6,a5
		dbf	d4,20b		/* run all PSG tracks */
# loc_721B6:
2:
		addq.w	#4,sp	/* Tamper with return value to not return to caller */
		rts	
# ===========================================================================
# byte_721BA:
FMDACInitBytes:	dc.b 6,	0, 1, 2, 4, 5, 6	/* first byte is for DAC; then notice the 0, 1, 2 then 4, 5, 6; this is the gap between parts I and II for YM2612 port writes */
		.align 2
# byte_721C2:
PSGInitBytes:	dc.b 0x80, 0xA0, 0xC0	/* Specifically, these configure writes to the PSG port for each channel */
		.align 2
# ===========================================================================
# ---------------------------------------------------------------------------
# Play normal sound effect
# ---------------------------------------------------------------------------
# Sound_A0toCF:
Sound_PlaySFX:
		tst.b	f_1up_playing(a6)	/* Is 1-up playing? */
		bne.w	1f		/* Exit is it is */
		tst.b	v_fadeout_counter(a6)	/* Is music being faded out? */
		bne.w	1f		/* Exit if it is */
		tst.b	f_fadein_flag(a6)	/* Is music being faded in? */
		bne.w	1f		/* Exit if it is */
		cmpi.b	#sfx_Ring,d7		/* is ring sound	effect played? */
		bne.s	2f		/* if not, branch */
		tst.b	v_ring_speaker(a6)	/* Is the ring sound playing on right speaker? */
		bne.s	3f		/* Branch if not */
		move.b	#sfx_RingLeft,d7	/* play ring sound in left speaker */
# loc_721EE:
3:
		bchg	#0,v_ring_speaker(a6)	/* change speaker */
# Sound_notB5:
2:
		cmpi.b	#sfx_Push,d7		/* is "pushing" sound played? */
		bne.s	4f		/* if not, branch */
		tst.b	f_push_playing(a6)	/* Is pushing sound already playing? */
		bne.w	5f			/* Return if not */
		move.b	#0x80,f_push_playing(a6)	/* Mark it as playing */
# Sound_notA7:
4:
		movea.l	(Go_SoundIndex).l,a0
		subi.b	#sfx__First,d7		/* Make it 0-based */
		lsl.w	#2,d7			/* Convert sfx ID into index */
		movea.l	(a0,d7.w),a3		/* SFX data pointer */
		movea.l	a3,a1
		moveq	#0,d1
		move.w	(a1)+,d1		/* Voice pointer */
		add.l	a3,d1			/* Relative pointer */
		move.b	(a1)+,d5		/* Dividing timing */
#		 DANGER! there is a missing 'moveq	#0,d7' here, without which SFXes whose
#		 index entry is above $3F will cause a crash. This is actually the same way that
#		 this bug is fixed in Ristar's driver.
		move.b	(a1)+,d7	/* Number of tracks (FM + PSG) */
		subq.b	#1,d7
		moveq	#zTrackSz,d6
# loc_72228:
6:
		moveq	#0,d3
		move.b	1(a1),d3	/* Channel assignment bits */
		move.b	d3,d4
		bmi.s	7f	/* Branch if PSG */
		subq.w	#2,d3		/* SFX can only have FM3, FM4 or FM5 */
		lsl.w	#2,d3
		lea	SFX_BGMChannelRAM(pc),a5
		movea.l	(a5,d3.w),a5
		bset	#2,(a5)		/* Mark music track as being overridden (zTrackPlaybackControl) */
		bra.s	8f
# ===========================================================================
# loc_72244:
7:
		lsr.w	#3,d3
		lea	SFX_BGMChannelRAM(pc),a5
		movea.l	(a5,d3.w),a5
		bset	#2,(a5)			/* Mark music track as being overridden (zTrackPlaybackControl) */
		cmpi.b	#0xC0,d4			/* Is this PSG 3? */
		bne.s	8f	/* Branch if not */
		move.b	d4,d0
		ori.b	#0x1F,d0			/* Command to silence PSG 3 */
		move.b	d0,(psg_input).l
		bchg	#5,d0			/* Command to silence noise channel */
		move.b	d0,(psg_input).l
# loc_7226E:
8:
		movea.l	SFX_SFXChannelRAM(pc,d3.w),a5
		movea.l	a5,a2
		moveq	#(zTrackSz/4)-1,d0	/* $30 bytes */
# loc_72276:
9:
		clr.l	(a2)+
		dbf	d0,9b

		move.w	(a1)+,(a5)			/* Initial playback control bits (zTrackPlaybackControl) */
		move.b	d5,zTrackTempoDivider(a5)	/* Initial voice control bits */
		moveq	#0,d0
		move.w	(a1)+,d0			/* Track data pointer */
		add.l	a3,d0				/* Relative pointer */
		move.l	d0,zTrackDataPointer(a5)	/* Store track pointer */
		move.w	(a1)+,zTrackTranspose(a5)	/* load FM/PSG channel modifier */
		move.b	#1,zTrackDurationTimeout(a5)	/* Set duration of first "note" */
		move.b	d6,zTrackStackPointer(a5)	/* set "gosub" (coord flag F8h) stack init value */
		tst.b	d4				/* Is this a PSG channel? */
		bmi.s	10f			/* Branch if yes */
		move.b	#0xC0,zTrackAMSFMSPan(a5)	/* AMS/FMS/Panning */
		move.l	d1,zTrackVoicePtr(a5)		/* Voice pointer */
# loc_722A8:
10:
		dbf	d7,6b

		tst.b	v_sfx_fm4_track+zTrackPlaybackControl(a6)	/* Is special SFX being played? */
		bpl.s	11f					/* Branch if not */
		bset	#2,v_spcsfx_fm4_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
# loc_722B8:
11:
		tst.b	v_sfx_psg3_track+zTrackPlaybackControl(a6)	/* Is SFX being played? */
		bpl.s	5f						/* Branch if not */
		bset	#2,v_spcsfx_psg3_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
# locret_722C4:
5:
		rts	
# ===========================================================================
# loc_722C6:
1:
		nop /* doing this again for bindiff */
		clr.b	v_sndprio(a6)	/* Clear priority */
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# RAM addresses for FM and PSG channel variables used by the SFX
# ---------------------------------------------------------------------------
# dword_722CC: BGMChannelRAM:
SFX_BGMChannelRAM:
		dc.l (v_snddriver_ram+v_music_fm3_track)&0xFFFFFF
		dc.l 0
		dc.l (v_snddriver_ram+v_music_fm4_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_music_fm5_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_music_psg1_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_music_psg2_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_music_psg3_track)&0xFFFFFF	/* Plain PSG3 */
		dc.l (v_snddriver_ram+v_music_psg3_track)&0xFFFFFF	/* Noise */
# dword_722EC: SFXChannelRAM:
SFX_SFXChannelRAM:
		dc.l (v_snddriver_ram+v_sfx_fm3_track)&0xFFFFFF
		dc.l 0
		dc.l (v_snddriver_ram+v_sfx_fm4_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_sfx_fm5_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_sfx_psg1_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_sfx_psg2_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_sfx_psg3_track)&0xFFFFFF	/* Plain PSG3 */
		dc.l (v_snddriver_ram+v_sfx_psg3_track)&0xFFFFFF	/* Noise */
# ===========================================================================
# ---------------------------------------------------------------------------
# Play GHZ waterfall sound
# ---------------------------------------------------------------------------
# Sound_D0toDF:
Sound_PlaySpecial:
		tst.b	f_1up_playing(a6)	/* Is 1-up playing? */
		bne.w	1f			/* Return if so */
		tst.b	v_fadeout_counter(a6)	/* Is music being faded out? */
		bne.w	1f			/* Exit if it is */
		tst.b	f_fadein_flag(a6)	/* Is music being faded in? */
		bne.w	1f			/* Exit if it is */
		movea.l	(Go_SpecSoundIndex).l,a0
		subi.b	#spec__First,d7		/* Make it 0-based */
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d0
		move.w	(a1)+,d0			/* Voice pointer */
		add.l	a3,d0				/* Relative pointer */
		move.l	d0,v_special_voice_ptr(a6)	/* Store voice pointer */
		move.b	(a1)+,d5			/* Dividing timing */
#		 DANGER! there is a missing 'moveq	#0,d7' here, without which special SFXes whose
#		 index entry is above $3F will cause a crash. This instance was not fixed in Ristar's driver.
		move.b	(a1)+,d7			/* Number of tracks (FM + PSG) */
		subq.b	#1,d7
		moveq	#zTrackSz,d6
# loc_72348:
2:
		move.b	1(a1),d4					/* Voice control bits */
		bmi.s	3f					/* Branch if PSG */
		bset	#2,v_music_fm4_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
		lea	v_spcsfx_fm4_track(a6),a5
		bra.s	4f
# ===========================================================================
# loc_7235A:
3:
		bset	#2,v_music_psg3_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
		lea	v_spcsfx_psg3_track(a6),a5
# loc_72364:
4:
		movea.l	a5,a2
		moveq	#(zTrackSz/4)-1,d0	/* $30 bytes */
# loc_72368:
5:
		clr.l	(a2)+
		dbf	d0,5b

		move.w	(a1)+,(a5)			/* Initial playback control bits & voice control bits (zTrackPlaybackControl) */
		move.b	d5,zTrackTempoDivider(a5)
		moveq	#0,d0
		move.w	(a1)+,d0			/* Track data pointer */
		add.l	a3,d0				/* Relative pointer */
		move.l	d0,zTrackDataPointer(a5)	/* Store track pointer */
		move.w	(a1)+,zTrackTranspose(a5)	/* load FM/PSG channel modifier */
		move.b	#1,zTrackDurationTimeout(a5)	/* Set duration of first "note" */
		move.b	d6,zTrackStackPointer(a5)	/* set "gosub" (coord flag F8h) stack init value */
		tst.b	d4				/* Is this a PSG channel? */
		bmi.s	6f			/* Branch if yes */
		move.b	#0xC0,zTrackAMSFMSPan(a5)	/* AMS/FMS/Panning */
# loc_72396:
6:
		dbf	d7,2b

		tst.b	v_sfx_fm4_track+zTrackPlaybackControl(a6)	/* Is track playing? */
		bpl.s	7f					/* Branch if not */
		bset	#2,v_spcsfx_fm4_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
# loc_723A6:
7:
		tst.b	v_sfx_psg3_track+zTrackPlaybackControl(a6)	/* Is track playing? */
		bpl.s	1f						/* Branch if not */
		bset	#2,v_spcsfx_psg3_track+zTrackPlaybackControl(a6)	/* Set 'SFX is overriding' bit */
		ori.b	#0x1F,d4						/* Command to silence channel */
		move.b	d4,(psg_input).l
		bchg	#5,d4			/* Command to silence noise channel */
		move.b	d4,(psg_input).l
# locret_723C6:
1:
		rts	
# End of function PlaySoundID

# ===========================================================================
# ---------------------------------------------------------------------------
# Unused RAM addresses for FM and PSG channel variables used by the Special SFX
# ---------------------------------------------------------------------------
# The first block would have been used for overriding the music tracks
# as they have a lower priority, just as they are in Sound_PlaySFX
# The third block would be used to set up the Special SFX
# The second block, however, is for the SFX tracks, which have a higher priority
# and would be checked for if they're currently playing
# If they are, then the third block would be used again, this time to mark
# the new tracks as 'currently playing'

# These were actually used in Moonwalker's driver (and other SMPS 68k Type 1a drivers)

# BGMFM4PSG3RAM:
#SpecSFX_BGMChannelRAM:
		dc.l (v_snddriver_ram+v_music_fm4_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_music_psg3_track)&0xFFFFFF
# SFXFM4PSG3RAM:
#SpecSFX_SFXChannelRAM:
		dc.l (v_snddriver_ram+v_sfx_fm4_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_sfx_psg3_track)&0xFFFFFF
# SpecialSFXFM4PSG3RAM:
#SpecSFX_SpecSFXChannelRAM:
		dc.l (v_snddriver_ram+v_spcsfx_fm4_track)&0xFFFFFF
		dc.l (v_snddriver_ram+v_spcsfx_psg3_track)&0xFFFFFF

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Snd_FadeOut1: Snd_FadeOutSFX: FadeOutSFX:
StopSFX:
		nop /* doing this again for bindiff */
		clr.b	v_sndprio(a6)		/* Clear priority */
		lea	v_sfx_track_ram(a6),a5
		moveq	#((v_sfx_track_ram_end-v_sfx_track_ram)/zTrackSz)-1,d7	/* 3 FM + 3 PSG tracks (SFX) */
# loc_723EA:
1:
		tst.b	(a5)		/* Is track playing? (zTrackPlaybackControl) */
		bpl.w	2f	/* Branch if not */
		bclr	#7,(a5)		/* Stop track (zTrackPlaybackControl) */
		moveq	#0,d3
		move.b	zTrackVoiceControl(a5),d3	/* Get voice control bits */
		bmi.s	3f			/* Branch if PSG */
		jsr	FMNoteOff(pc)
		cmpi.b	#4,d3						/* Is this FM4? */
		bne.s	4f					/* Branch if not */
		tst.b	v_spcsfx_fm4_track+zTrackPlaybackControl(a6)	/* Is special SFX playing? */
		bpl.s	4f					/* Branch if not */
#		 DANGER! there is a missing 'movea.l	a5,a3' here, without which the
#		 code is broken. It is dangerous to do a fade out when a GHZ waterfall
#		 is playing its sound!
		lea	v_spcsfx_fm4_track(a6),a5
		movea.l	v_special_voice_ptr(a6),a1	/* Get special voice pointer */
		bra.s	5f
# ===========================================================================
# loc_72416:
4:
		subq.b	#2,d3		/* SFX only has FM3 and up */
		lsl.b	#2,d3
		lea	SFX_BGMChannelRAM(pc),a0
		movea.l	a5,a3
		movea.l	(a0,d3.w),a5
		movea.l	v_voice_ptr(a6),a1	/* Get music voice pointer */
# loc_72428:
5:
		bclr	#2,(a5)			/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		move.b	zTrackVoiceIndex(a5),d0	/* Current voice */
		jsr	SetVoice(pc)
		movea.l	a3,a5
		bra.s	2f
# ===========================================================================
# loc_7243C:
3:
		jsr	PSGNoteOff(pc)
		lea	v_spcsfx_psg3_track(a6),a0
		cmpi.b	#0xE0,d3			/* Is this a noise channel: */
		beq.s	6f		/* Branch if yes */
		cmpi.b	#0xC0,d3			/* Is this PSG 3? */
		beq.s	6f		/* Branch if yes */
		lsr.b	#3,d3
		lea	SFX_BGMChannelRAM(pc),a0
		movea.l	(a0,d3.w),a0
# loc_7245A:
6:
		bclr	#2,(a0)				/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a0)				/* Set 'track at rest' bit (zTrackPlaybackControl) */
		cmpi.b	#0xE0,zTrackVoiceControl(a0)	/* Is this a noise channel? */
		bne.s	2f			/* Branch if not */
		move.b	zTrackPSGNoise(a0),(psg_input).l /* Set noise type */
# loc_72472:
2:
		adda.w	#zTrackSz,a5
		dbf	d7,1b

		rts	
# End of function StopSFX


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# Snd_FadeOut2: FadeOutSFX2: FadeOutSpecialSFX:
StopSpecialSFX:
		lea	v_spcsfx_fm4_track(a6),a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	1f		/* Branch if not */
		bclr	#7,(a5)			/* Stop track (zTrackPlaybackControl) */
		btst	#2,(a5)			/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	1f		/* Branch if not */
		jsr	SendFMNoteOff(pc)
		lea	v_music_fm4_track(a6),a5
		bclr	#2,(a5)			/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	1f		/* Branch if not */
		movea.l	v_voice_ptr(a6),a1	/* Voice pointer */
		move.b	zTrackVoiceIndex(a5),d0	/* Current voice */
		jsr	SetVoice(pc)
# loc_724AE:
1:
		lea	v_spcsfx_psg3_track(a6),a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	2f		/* Branch if not */
		bclr	#7,(a5)			/* Stop track (zTrackPlaybackControl) */
		btst	#2,(a5)			/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	2f		/* Return if not */
		jsr	SendPSGNoteOff(pc)
		lea	v_music_psg3_track(a6),a5
		bclr	#2,(a5)			/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	2f		/* Return if not */
		cmpi.b	#0xE0,zTrackVoiceControl(a5)	/* Is this a noise channel? */
		bne.s	2f			/* Return if not */
		move.b	zTrackPSGNoise(a5),(psg_input).l /* Set noise type */
# locret_724E4:
2:
		rts	
# End of function StopSpecialSFX

# ===========================================================================
# ---------------------------------------------------------------------------
# Fade out music
# ---------------------------------------------------------------------------
# Sound_E0:
FadeOutMusic:
		jsr	StopSFX(pc)
		jsr	StopSpecialSFX(pc)
		move.b	#3,v_fadeout_delay(a6)			/* Set fadeout delay to 3 */
		move.b	#0x28,v_fadeout_counter(a6)		/* Set fadeout counter */
		clr.b	v_music_dac_track+zTrackPlaybackControl(a6)	/* Stop DAC track */
		clr.b	f_speedup(a6)				/* Disable speed shoes tempo */
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72504:
DoFadeOut:
		move.b	v_fadeout_delay(a6),d0	/* Has fadeout delay expired? */
		beq.s	1f		/* Branch if yes */
		subq.b	#1,v_fadeout_delay(a6)
		rts	
# ===========================================================================
# loc_72510:
1:
		subq.b	#1,v_fadeout_counter(a6)	/* Update fade counter */
		beq.w	StopAllSound			/* Branch if fade is done */
		move.b	#3,v_fadeout_delay(a6)		/* Reset fade delay */
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/zTrackSz)-1,d7	/* 6 FM tracks */
# loc_72524:
2:
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	3f			/* Branch if not */
		addq.b	#1,zTrackVolume(a5)	/* Increase volume attenuation */
		bpl.s	4f		/* Branch if still positive */
		bclr	#7,(a5)			/* Stop track (zTrackPlaybackControl) */
		bra.s	3f
# ===========================================================================
# loc_72534:
4:
		jsr	SendVoiceTL(pc)
# loc_72538:
3:
		adda.w	#zTrackSz,a5
		dbf	d7,2b

		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d7	/* 3 PSG tracks */
# loc_72542:
5:
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	6f		/* branch if not */
		addq.b	#1,zTrackVolume(a5)	/* Increase volume attenuation */
		cmpi.b	#0x10,zTrackVolume(a5)	/* Is it greater than $F? */
		blo.s	7f		/* Branch if not */
		bclr	#7,(a5)			/* Stop track (zTrackPlaybackControl) */
		bra.s	6f
# ===========================================================================
# loc_72558:
7:
		move.b	zTrackVolume(a5),d6	/* Store new volume attenuation */
		jsr	SetPSGVolume(pc)
# loc_72560:
6:
		adda.w	#zTrackSz,a5
		dbf	d7,5b

		rts	
# End of function DoFadeOut


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_7256A:
FMSilenceAll:
		moveq	#2,d3		/* 3 FM channels for each YM2612 parts */
		moveq	#0x28,d0		/* FM key on/off register */
# loc_7256E:
1:
		move.b	d3,d1
		jsr	WriteFMI(pc)
		addq.b	#4,d1		/* Move to YM2612 part 1 */
		jsr	WriteFMI(pc)
		dbf	d3,1b

		moveq	#0x40,d0		/* Set TL on FM channels... */
		moveq	#0x7F,d1		/* ... to total attenuation... */
		moveq	#2,d4		/* ... for all 3 channels... */
# loc_72584:
2:
		moveq	#3,d3		/* ... for all operators on each channel... */
# loc_72586:
3:
		jsr	WriteFMI(pc)	/* ... for part 0... */
		jsr	WriteFMII(pc)	/* ... and part 1. */
		addq.w	#4,d0		/* Next TL operator */
		dbf	d3,3b

		subi.b	#0xF,d0		/* Move to TL operator 1 of next channel */
		dbf	d4,2b

		rts	
# End of function FMSilenceAll

# ===========================================================================
# ---------------------------------------------------------------------------
# Stop music
# ---------------------------------------------------------------------------
# Sound_E4: StopSoundAndMusic:
StopAllSound:
		moveq	#0x2B,d0		/* Enable/disable DAC */
		move.b	#0x80,d1		/* Enable DAC */
		jsr	WriteFMI(pc)
		moveq	#0x27,d0		/* Timers, FM3/FM6 mode */
		moveq	#0,d1		/* FM3/FM6 normal mode, disable timers */
		jsr	WriteFMI(pc)
		movea.l	a6,a0
#		 DANGER! This should be clearing all variables and track data, but misses the last $10 bytes of v_spcsfx_psg3_track.
#		 Remove the '-$10' to fix this.
		move.w	#((v_spcsfx_track_ram_end-v_startofvariables-0x10)/4)-1,d0	/* Clear $390 bytes: all variables and most track data */
# loc_725B6:
1:
		clr.l	(a0)+
		dbf	d0,1b

		move.b	#0x80,v_playsnd0(a6)	/* set music to $80 (silence) */
		jsr	FMSilenceAll(pc)
		bra.w	PSGSilenceAll

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_725CA:
InitMusicPlayback:
		movea.l	a6,a0
#		 Save several values
		nop /* doing this again for bindiff */
		move.b	v_sndprio(a6),d1
		move.b	f_1up_playing(a6),d2
		move.b	f_speedup(a6),d3
		move.b	v_fadein_counter(a6),d4
		move.w	v_playsnd1(a6),d5
		move.w	#((v_music_track_ram_end-v_startofvariables)/4)-1,d0	/* Clear $220 bytes: all variables and music track data */
# loc_725E4:
1:
		clr.l	(a0)+
		dbf	d0,1b

#		 Restore the values saved above
		nop /* doing this again for bindiff */
		move.b	d1,v_sndprio(a6)
		move.b	d2,f_1up_playing(a6)
		move.b	d3,f_speedup(a6)
		move.b	d4,v_fadein_counter(a6)
		move.w	d5,v_playsnd1(a6)
		move.b	#0x80,v_playsnd0(a6)	/* set music to $80 (silence) */
#		 DANGER! This silences ALL channels, even the ones being used
#		 by SFX, and not music! @sendfmnoteoff does this already, and
#		 doesn't affect SFX channels, either.
#		 This should be replaced with an 'rts'.
		jsr	FMSilenceAll(pc)
		bra.w	PSGSilenceAll
#		 DANGER! InitMusicPlayback, and Sound_PlayBGM for that matter,
#		 don't do a very good job of setting up the music tracks.
#		 Tracks that aren't defined in a music file's header don't have
#		 their channels defined, meaning @sendfmnoteoff won't silence
#		 hardware properly. In combination with removing the above
#		 calls to FMSilenceAll/PSGSilenceAll, this will cause hanging
#		 notes.
#		 To fix this, I suggest using this code, instead of an 'rts':
#		lea	v_music_track_ram+zTrackVoiceControl(a6),a1
#		lea	FMDACInitBytes(pc),a2
#		moveq	#((v_music_fmdac_tracks_end-v_music_fmdac_tracks)/zTrackSz)-1,d1		; 7 DAC/FM tracks
#		bsr.s	@writeloop
#		lea	PSGInitBytes(pc),a2
#		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d1	; 3 PSG tracks

#@writeloop:
#		move.b	(a2)+,(a1)		; Write track's channel byte
#		lea	zTrackSz(a1),a1		; Next track
#		dbf	d1,@writeloop		; Loop for all DAC/FM/PSG tracks

#		rts
	
# End of function InitMusicPlayback


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_7260C:
TempoWait:
		move.b	v_main_tempo(a6),v_main_tempo_timeout(a6)	/* Reset main tempo timeout */
		lea	v_music_track_ram+zTrackDurationTimeout(a6),a0	/* note timeout */
		moveq	#zTrackSz,d0
		moveq	#((v_music_track_ram_end-v_music_track_ram)/zTrackSz)-1,d1		/* 1 DAC + 6 FM + 3 PSG tracks */
# loc_7261A:
1:
		addq.b	#1,(a0)	/* Delay note by 1 frame */
		adda.w	d0,a0	/* Advance to next track */
		dbf	d1,1b

		rts	
# End of function TempoWait

# ===========================================================================
# ---------------------------------------------------------------------------
# Speed	up music
# ---------------------------------------------------------------------------
# Sound_E2:
SpeedUpMusic:
		tst.b	f_1up_playing(a6)
		bne.s	1f
		move.b	v_speeduptempo(a6),v_main_tempo(a6)
		move.b	v_speeduptempo(a6),v_main_tempo_timeout(a6)
		move.b	#0x80,f_speedup(a6)
		rts	
# ===========================================================================
# loc_7263E:
1:
		move.b	v_1up_ram_copy+v_speeduptempo(a6),v_1up_ram_copy+v_main_tempo(a6)
		move.b	v_1up_ram_copy+v_speeduptempo(a6),v_1up_ram_copy+v_main_tempo_timeout(a6)
		move.b	#0x80,v_1up_ram_copy+f_speedup(a6)
		rts	
# ===========================================================================
# ---------------------------------------------------------------------------
# Change music back to normal speed
# ---------------------------------------------------------------------------
# Sound_E3:
SlowDownMusic:
		tst.b	f_1up_playing(a6)
		bne.s	1f
		move.b	v_tempo_mod(a6),v_main_tempo(a6)
		move.b	v_tempo_mod(a6),v_main_tempo_timeout(a6)
		clr.b	f_speedup(a6)
		rts	
# ===========================================================================
# loc_7266A:
1:
		move.b	v_1up_ram_copy+v_tempo_mod(a6),v_1up_ram_copy+v_main_tempo(a6)
		move.b	v_1up_ram_copy+v_tempo_mod(a6),v_1up_ram_copy+v_main_tempo_timeout(a6)
		clr.b	v_1up_ram_copy+f_speedup(a6)
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_7267C:
DoFadeIn:
		tst.b	v_fadein_delay(a6)	/* Has fadein delay expired? */
		beq.s	1f		/* Branch if yes */
		subq.b	#1,v_fadein_delay(a6)
		rts	
# ===========================================================================
# loc_72688:
1:
		tst.b	v_fadein_counter(a6)	/* Is fade done? */
		beq.s	2f		/* Branch if yes */
		subq.b	#1,v_fadein_counter(a6)	/* Update fade counter */
		move.b	#2,v_fadein_delay(a6)	/* Reset fade delay */
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/zTrackSz)-1,d7	/* 6 FM tracks */
# loc_7269E:
3:
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	4f			/* Branch if not */
		subq.b	#1,zTrackVolume(a5)	/* Reduce volume attenuation */
		jsr	SendVoiceTL(pc)
# loc_726AA:
4:
		adda.w	#zTrackSz,a5
		dbf	d7,3b
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d7		/* 3 PSG tracks */
# loc_726B4:
5:
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	6f		/* Branch if not */
		subq.b	#1,zTrackVolume(a5)	/* Reduce volume attenuation */
		move.b	zTrackVolume(a5),d6	/* Get value */
		cmpi.b	#0x10,d6			/* Is it is < $10? */
		blo.s	7f		/* Branch if yes */
		moveq	#0xF,d6			/* Limit to $F (maximum attenuation) */
# loc_726C8:
7:
		jsr	SetPSGVolume(pc)
# loc_726CC:
6:
		adda.w	#zTrackSz,a5
		dbf	d7,5b
		rts	
# ===========================================================================
# loc_726D6:
2:
		bclr	#2,v_music_dac_track+zTrackPlaybackControl(a6)	/* Clear 'SFX overriding' bit */
		clr.b	f_fadein_flag(a6)				/* Stop fadein */
		rts	
# End of function DoFadeIn

# ===========================================================================
# loc_726E2:
FMNoteOn:
		btst	#1,(a5)		/* Is track resting? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if so */
		btst	#2,(a5)		/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if so */
		moveq	#0x28,d0		/* Note on/off register */
		move.b	zTrackVoiceControl(a5),d1 /* Get channel bits */
		ori.b	#0xF0,d1		/* Note on on all operators */
		bra.w	WriteFMI
# ===========================================================================
# locret_726FC:
1:
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_726FE:
FMNoteOff:
		btst	#4,(a5)		/* Is 'do not attack next note' set? (zTrackPlaybackControl) */
		bne.s	locret_72714	/* Return if yes */
		btst	#2,(a5)		/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	locret_72714	/* Return if yes */
# loc_7270A:
SendFMNoteOff:
		moveq	#0x28,d0		/* Note on/off register */
		move.b	zTrackVoiceControl(a5),d1 /* Note off to this channel */
		bra.w	WriteFMI
# ===========================================================================

locret_72714:
		rts	
# End of function FMNoteOff

# ===========================================================================
# loc_72716:
WriteFMIorIIMain:
		btst	#2,(a5)		/* Is track being overriden by sfx? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if yes */
		bra.w	WriteFMIorII
# ===========================================================================
# locret_72720:
1:
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72722:
WriteFMIorII:
		btst	#2,zTrackVoiceControl(a5)	/* Is this bound for part I or II? */
		bne.s	WriteFMIIPart			/* Branch if for part II */
		add.b	zTrackVoiceControl(a5),d0	/* Add in voice control bits */
# End of function WriteFMIorII


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# The reason I think this is an *early* SMPS 68k Type 1b
# is because this subroutine is the one from Type 1a:
# other Type 1b drivers have a newer, optimised version.
# The driver itself is Type 1b, with this odd exception.

# sub_7272E:
WriteFMI:
		move.b	(ym2612_a0).l,d2
		btst	#7,d2		/* Is FM busy? */
		bne.s	WriteFMI	/* Loop if so */
		move.b	d0,(ym2612_a0).l
		nop	
		nop	
		nop	
# loc_72746:
1:
		move.b	(ym2612_a0).l,d2
		btst	#7,d2		/* Is FM busy? */
		bne.s	1b	/* Loop if so */

		move.b	d1,(ym2612_d0).l
		rts	
# End of function WriteFMI

# ===========================================================================
# loc_7275A:
WriteFMIIPart:
		move.b	zTrackVoiceControl(a5),d2 /* Get voice control bits */
		bclr	#2,d2			/* Clear chip toggle */
		add.b	d2,d0			/* Add in to destination register */

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72764:
WriteFMII:
		move.b	(ym2612_a0).l,d2
		btst	#7,d2		/* Is FM busy? */
		bne.s	WriteFMII	/* Loop if so */
		move.b	d0,(ym2612_a1).l
		nop	
		nop	
		nop	
# loc_7277C:
1:
		move.b	(ym2612_a0).l,d2
		btst	#7,d2		/* Is FM busy? */
		bne.s	1b	/* Loop if so */

		move.b	d1,(ym2612_d1).l
		rts	
# End of function WriteFMII

# ===========================================================================
# ---------------------------------------------------------------------------
# FM Note Values: b-0 to a#8
# ---------------------------------------------------------------------------
# word_72790: FM_Notes:
FMFrequencies:
	dc.w 0x025E,0x0284,0x02AB,0x02D3,0x02FE,0x032D,0x035C,0x038F,0x03C5,0x03FF,0x043C,0x047C
	dc.w 0x0A5E,0x0A84,0x0AAB,0x0AD3,0x0AFE,0x0B2D,0x0B5C,0x0B8F,0x0BC5,0x0BFF,0x0C3C,0x0C7C
	dc.w 0x125E,0x1284,0x12AB,0x12D3,0x12FE,0x132D,0x135C,0x138F,0x13C5,0x13FF,0x143C,0x147C
	dc.w 0x1A5E,0x1A84,0x1AAB,0x1AD3,0x1AFE,0x1B2D,0x1B5C,0x1B8F,0x1BC5,0x1BFF,0x1C3C,0x1C7C
	dc.w 0x225E,0x2284,0x22AB,0x22D3,0x22FE,0x232D,0x235C,0x238F,0x23C5,0x23FF,0x243C,0x247C
	dc.w 0x2A5E,0x2A84,0x2AAB,0x2AD3,0x2AFE,0x2B2D,0x2B5C,0x2B8F,0x2BC5,0x2BFF,0x2C3C,0x2C7C
	dc.w 0x325E,0x3284,0x32AB,0x32D3,0x32FE,0x332D,0x335C,0x338F,0x33C5,0x33FF,0x343C,0x347C
	dc.w 0x3A5E,0x3A84,0x3AAB,0x3AD3,0x3AFE,0x3B2D,0x3B5C,0x3B8F,0x3BC5,0x3BFF,0x3C3C,0x3C7C

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72850:
PSGUpdateTrack:
		subq.b	#1,zTrackDurationTimeout(a5)	/* Update note timeout */
		bne.s	1f
		bclr	#4,(a5)				/* Clear 'do not attack note' bit (zTrackPlaybackControl) */
		jsr	PSGDoNext(pc)
		jsr	PSGDoNoteOn(pc)
		bra.w	PSGDoVolFX
# ===========================================================================
# loc_72866:
1:
		jsr	NoteFillUpdate(pc)
		jsr	PSGUpdateVolFX(pc)
		jsr	DoModulation(pc)
		jsr	PSGUpdateFreq(pc)	/* It would be better if this were a jmp and the rts was removed */
		rts
# End of function PSGUpdateTrack


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72878:
PSGDoNext:
		bclr	#1,(a5)				/* Clear 'track at rest' bit (zTrackPlaybackControl) */
		movea.l	zTrackDataPointer(a5),a4	/* Get track data pointer */
# loc_72880:
1:
		moveq	#0,d5
		move.b	(a4)+,d5	/* Get byte from track */
		cmpi.b	#0xE0,d5		/* Is it a coord. flag? */
		blo.s	2f	/* Branch if not */
		jsr	CoordFlag(pc)
		bra.s	1b
# ===========================================================================
# loc_72890:
2:
		tst.b	d5		/* Is it a note? */
		bpl.s	3f	/* Branch if not */
		jsr	PSGSetFreq(pc)
		move.b	(a4)+,d5	/* Get another byte */
		tst.b	d5		/* Is it a duration? */
		bpl.s	3f	/* Branch if yes */
		subq.w	#1,a4		/* Put byte back */
		bra.w	FinishTrackUpdate
# ===========================================================================
# loc_728A4:
3:
		jsr	SetDuration(pc)
		bra.w	FinishTrackUpdate
# End of function PSGDoNext


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_728AC:
PSGSetFreq:
		subi.b	#0x81,d5		/* Convert to 0-based index */
		blo.s	1f	/* If $80, put track at rest */
		add.b	zTrackTranspose(a5),d5 /* Add in channel transposition */
		andi.w	#0x7F,d5		/* Clear high byte and sign bit */
		lsl.w	#1,d5
		lea	PSGFrequencies(pc),a0
		move.w	(a0,d5.w),zTrackFreq(a5)	/* Set new frequency */
		bra.w	FinishTrackUpdate
# ===========================================================================
# loc_728CA:
1:
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		move.w	#-1,zTrackFreq(a5)	/* Invalidate note frequency */
		jsr	FinishTrackUpdate(pc)
		bra.w	PSGNoteOff
# End of function PSGSetFreq


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_728DC:
PSGDoNoteOn:
		move.w	zTrackFreq(a5),d6	/* Get note frequency */
		bmi.s	PSGSetRest		/* If invalid, branch */
# End of function PSGDoNoteOn


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_728E2:
PSGUpdateFreq:
		move.b	zTrackDetune(a5),d0	/* Get detune value */
		ext.w	d0
		add.w	d0,d6		/* Add to frequency */
		btst	#2,(a5)		/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if yes */
		btst	#1,(a5)		/* Is track at rest? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if yes */
		move.b	zTrackVoiceControl(a5),d0 /* Get channel bits */
		cmpi.b	#0xE0,d0		/* Is it a noise channel? */
		bne.s	2f	/* Branch if not */
		move.b	#0xC0,d0		/* Use PSG 3 channel bits */
# loc_72904:
2:
		move.w	d6,d1
		andi.b	#0xF,d1		/* Low nibble of frequency */
		or.b	d1,d0		/* Latch tone data to channel */
		lsr.w	#4,d6		/* Get upper 6 bits of frequency */
		andi.b	#0x3F,d6		/* Send to latched channel */
		move.b	d0,(psg_input).l
		move.b	d6,(psg_input).l
# locret_7291E:
1:
		rts	
# End of function PSGUpdateFreq

# ===========================================================================
# loc_72920:
PSGSetRest:
		bset	#1,(a5)	/* Set 'track at rest' bit (zTrackPlaybackControl) */
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72926:
PSGUpdateVolFX:
		tst.b	zTrackVoiceIndex(a5)	/* Test PSG tone */
		beq.w	locret_7298A		/* Return if it is zero */
# loc_7292E:
PSGDoVolFX:	/* This can actually be made a bit more efficient, see the comments for more */
		move.b	zTrackVolume(a5),d6	/* Get volume */
		moveq	#0,d0
		move.b	zTrackVoiceIndex(a5),d0	/* Get PSG tone */
		beq.s	SetPSGVolume
		movea.l	(Go_PSGIndex).l,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0
		move.b	zTrackVolEnvIndex(a5),d0	/* Get volume envelope index		; move.b	zTrackVolEnvIndex(a5),d0 */
		move.b	(a0,d0.w),d0			/* Volume envelope value			; addq.b	#1,zTrackVolEnvIndex(a5) */
		addq.b	#1,zTrackVolEnvIndex(a5)	/* Increment volume envelope index	; move.b	(a0,d0.w),d0 */
		btst	#7,d0				/* Is volume envelope value negative?	; <-- makes this line redundant */
		beq.s	1f			/* Branch if not				; but you gotta make this one a bpl */
		cmpi.b	#0x80,d0				/* Is it the terminator?			; Since this is the only check, you can take the optimisation a step further: */
		beq.s	VolEnvHold			/* If so, branch				; Change the previous beq (bpl) to a bmi and make it branch to VolEnvHold to make these last two lines redundant */
# loc_72960:
1:
		add.w	d0,d6		/* Add volume envelope value to volume */
		cmpi.b	#0x10,d6		/* Is volume $10 or higher? */
		blo.s	SetPSGVolume	/* Branch if not */
		moveq	#0xF,d6		/* Limit to silence and fall through */
# End of function PSGUpdateVolFX


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_7296A:
SetPSGVolume:
		btst	#1,(a5)		/* Is track at rest? (zTrackPlaybackControl) */
		bne.s	locret_7298A	/* Return if so */
		btst	#2,(a5)		/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	locret_7298A	/* Return if so */
		btst	#4,(a5)		/* Is track set to not attack next note? (zTrackPlaybackControl) */
		bne.s	PSGCheckNoteFill /* Branch if yes */
# loc_7297C:
PSGSendVolume:
		or.b	zTrackVoiceControl(a5),d6 /* Add in track selector bits */
		addi.b	#0x10,d6			/* Mark it as a volume command */
		move.b	d6,(psg_input).l

locret_7298A:
		rts	
# ===========================================================================
# loc_7298C:
PSGCheckNoteFill:
		tst.b	zTrackNoteFillMaster(a5)	/* Is note fill on? */
		beq.s	PSGSendVolume			/* Branch if not */
		tst.b	zTrackNoteFillTimeout(a5)	/* Has note fill timeout expired? */
		bne.s	PSGSendVolume			/* Branch if not */
		rts	
# End of function SetPSGVolume

# ===========================================================================
# loc_7299A: VolEnvHold:
VolEnvHold:
		subq.b	#1,zTrackVolEnvIndex(a5)	/* Decrement volume envelope index */
		rts	

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_729A0:
PSGNoteOff:
		btst	#2,(a5)		/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	locret_729B4	/* Return if so */
# loc_729A6:
SendPSGNoteOff:
		move.b	zTrackVoiceControl(a5),d0	/* PSG channel to change */
		ori.b	#0x1F,d0				/* Maximum volume attenuation */
		move.b	d0,(psg_input).l
#		 DANGER! If InitMusicPlayback doesn't silence all channels, there's the
#		 risk of music accidentally playing noise because it can't detect if
#		 the PSG4/noise channel needs muting on track initialisation.
#		 S&K's driver fixes it by doing this:
#		cmpi.b	#$DF,d0				; Are stopping PSG3?
#		bne.s	locret_729B4
#		move.b	#$FF,(psg_input).l		; If so, stop noise channel while we're at it

locret_729B4:
		rts	
# End of function PSGNoteOff


# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_729B6:
PSGSilenceAll:
		lea	(psg_input).l,a0
		move.b	#0x9F,(a0)	/* Silence PSG 1 */
		move.b	#0xBF,(a0)	/* Silence PSG 2 */
		move.b	#0xDF,(a0)	/* Silence PSG 3 */
		move.b	#0xFF,(a0)	/* Silence noise channel */
		rts	
# End of function PSGSilenceAll

# ===========================================================================
# word_729CE:
PSGFrequencies:
		dc.w 0x356, 0x326, 0x2F9, 0x2CE, 0x2A5, 0x280, 0x25C, 0x23A
		dc.w 0x21A, 0x1FB, 0x1DF, 0x1C4, 0x1AB, 0x193, 0x17D, 0x167
		dc.w 0x153, 0x140, 0x12E, 0x11D, 0x10D,  0xFE,  0xEF,  0xE2
		dc.w  0xD6,  0xC9,  0xBE,  0xB4,  0xA9,  0xA0,  0x97,  0x8F
		dc.w  0x87,  0x7F,  0x78,  0x71,  0x6B,  0x65,  0x5F,  0x5A
		dc.w  0x55,  0x50,  0x4B,  0x47,  0x43,  0x40,  0x3C,  0x39
		dc.w  0x36,  0x33,  0x30,  0x2D,  0x2B,  0x28,  0x26,  0x24
		dc.w  0x22,  0x20,  0x1F,  0x1D,  0x1B,  0x1A,  0x18,  0x17
		dc.w  0x16,  0x15,  0x13,  0x12,  0x11,    0

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72A5A:
CoordFlag:
		subi.w	#0xE0,d5
		lsl.w	#2,d5
		jmp	coordflagLookup(pc,d5.w)
# End of function CoordFlag

# ===========================================================================
# loc_72A64:
coordflagLookup:
		bra.w	cfPanningAMSFMS		/* $E0 */
# ===========================================================================
		bra.w	cfDetune		/* $E1 */
# ===========================================================================
		bra.w	cfSetCommunication	/* $E2 */
# ===========================================================================
		bra.w	cfJumpReturn		/* $E3 */
# ===========================================================================
		bra.w	cfFadeInToPrevious	/* $E4 */
# ===========================================================================
		bra.w	cfSetTempoDivider	/* $E5 */
# ===========================================================================
		bra.w	cfChangeFMVolume	/* $E6 */
# ===========================================================================
		bra.w	cfHoldNote		/* $E7 */
# ===========================================================================
		bra.w	cfNoteFill		/* $E8 */
# ===========================================================================
		bra.w	cfChangeTransposition	/* $E9 */
# ===========================================================================
		bra.w	cfSetTempo		/* $EA */
# ===========================================================================
		bra.w	cfSetTempoMod		/* $EB */
# ===========================================================================
		bra.w	cfChangePSGVolume	/* $EC */
# ===========================================================================
		bra.w	cfClearPush		/* $ED */
# ===========================================================================
		bra.w	cfStopSpecialFM4	/* $EE */
# ===========================================================================
		bra.w	cfSetVoice		/* $EF */
# ===========================================================================
		bra.w	cfModulation		/* $F0 */
# ===========================================================================
		bra.w	cfEnableModulation	/* $F1 */
# ===========================================================================
		bra.w	cfStopTrack		/* $F2 */
# ===========================================================================
		bra.w	cfSetPSGNoise		/* $F3 */
# ===========================================================================
		bra.w	cfDisableModulation	/* $F4 */
# ===========================================================================
		bra.w	cfSetPSGTone		/* $F5 */
# ===========================================================================
		bra.w	cfJumpTo		/* $F6 */
# ===========================================================================
		bra.w	cfRepeatAtPos		/* $F7 */
# ===========================================================================
		bra.w	cfJumpToGosub		/* $F8 */
# ===========================================================================
		bra.w	cfOpF9			/* $F9 */
# ===========================================================================
# loc_72ACC:
cfPanningAMSFMS:
		move.b	(a4)+,d1		/* New AMS/FMS/panning value */
		tst.b	zTrackVoiceControl(a5)	/* Is this a PSG track? */
		bmi.s	locret_72AEA		/* Return if yes */
		move.b	zTrackAMSFMSPan(a5),d0	/* Get current AMS/FMS/panning */
		andi.b	#0x37,d0			/* Retain bits 0-2, 3-4 if set */
		or.b	d0,d1			/* Mask in new value */
		move.b	d1,zTrackAMSFMSPan(a5)	/* Store value */
		move.b	#0xB4,d0			/* Command to set AMS/FMS/panning */
		bra.w	WriteFMIorIIMain
# ===========================================================================

locret_72AEA:
		rts	
# ===========================================================================
# loc_72AEC: cfAlterNotes:
cfDetune:
		move.b	(a4)+,zTrackDetune(a5)	/* Set detune value */
		rts	
# ===========================================================================
# loc_72AF2: cfUnknown1:
cfSetCommunication:
		move.b	(a4)+,v_communication_byte(a6)	/* Set otherwise unused communication byte to parameter */
		rts	
# ===========================================================================
# loc_72AF8:
cfJumpReturn:
		moveq	#0,d0
		move.b	zTrackStackPointer(a5),d0 /* Track stack pointer */
		movea.l	(a5,d0.w),a4		/* Set track return address */
		move.l	#0,(a5,d0.w)		/* Set 'popped' value to zero */
		addq.w	#2,a4			/* Skip jump target address from gosub flag */
		addq.b	#4,d0			/* Actually 'pop' value */
		move.b	d0,zTrackStackPointer(a5) /* Set new stack pointer */
		rts	
# ===========================================================================
# loc_72B14:
cfFadeInToPrevious:
		movea.l	a6,a0
		lea	v_1up_ram_copy(a6),a1
		move.w	#((v_music_track_ram_end-v_startofvariables)/4)-1,d0	/* $220 bytes to restore: all variables and music track data */
# loc_72B1E:
1:
		move.l	(a1)+,(a0)+
		dbf	d0,1b

		bset	#2,v_music_dac_track+zTrackPlaybackControl(a6)	/* Set 'SFX overriding' bit */
		movea.l	a5,a3
		move.b	#0x28,d6
		sub.b	v_fadein_counter(a6),d6			/* If fade already in progress, this adjusts track volume accordingly */
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/zTrackSz)-1,d7	/* 6 FM tracks */
		lea	v_music_fm_tracks(a6),a5
# loc_72B3A:
2:
		btst	#7,(a5)		/* Is track playing? (zTrackPlaybackControl) */
		beq.s	3f		/* Branch if not */
		bset	#1,(a5)		/* Set 'track at rest' bit (zTrackPlaybackControl) */
		add.b	d6,zTrackVolume(a5) /* Apply current volume fade-in */
		btst	#2,(a5)		/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	3f		/* Branch if yes */
		moveq	#0,d0
		move.b	zTrackVoiceIndex(a5),d0	/* Get voice */
		movea.l	v_voice_ptr(a6),a1	/* Voice pointer */
		jsr	SetVoice(pc)
# loc_72B5C:
3:
		adda.w	#zTrackSz,a5
		dbf	d7,2b

		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/zTrackSz)-1,d7	/* 3 PSG tracks */
# loc_72B66:
4:
		btst	#7,(a5)		/* Is track playing? (zTrackPlaybackControl) */
		beq.s	5f	/* Branch if not */
		bset	#1,(a5)		/* Set 'track at rest' bit (zTrackPlaybackControl) */
		jsr	PSGNoteOff(pc)
		add.b	d6,zTrackVolume(a5)	/* Apply current volume fade-in */
# loc_72B78:
5:
		adda.w	#zTrackSz,a5
		dbf	d7,4b
		
		movea.l	a3,a5
		move.b	#0x80,f_fadein_flag(a6)		/* Trigger fade-in */
		move.b	#0x28,v_fadein_counter(a6)	/* Fade-in delay */
		clr.b	f_1up_playing(a6)
		startZ80
		addq.w	#8,sp		/* Tamper return value so we don't return to caller */
		rts	
# ===========================================================================
# loc_72B9E:
cfSetTempoDivider:
		move.b	(a4)+,zTrackTempoDivider(a5)	/* Set tempo divider on current track */
		rts	
# ===========================================================================
# loc_72BA4: cfSetVolume:
cfChangeFMVolume:
		move.b	(a4)+,d0		/* Get parameter */
		add.b	d0,zTrackVolume(a5)	/* Add to current volume */
		bra.w	SendVoiceTL
# ===========================================================================
# loc_72BAE: cfPreventAttack:
cfHoldNote:
		bset	#4,(a5)		/* Set 'do not attack next note' bit (zTrackPlaybackControl) */
		rts	
# ===========================================================================
# loc_72BB4:
cfNoteFill:
		move.b	(a4),zTrackNoteFillTimeout(a5)	/* Note fill timeout */
		move.b	(a4)+,zTrackNoteFillMaster(a5)	/* Note fill master */
		rts	
# ===========================================================================
# loc_72BBE: cfAddKey:
cfChangeTransposition:
		move.b	(a4)+,d0		/* Get parameter */
		add.b	d0,zTrackTranspose(a5)	/* Add to transpose value */
		rts	
# ===========================================================================
# loc_72BC6:
cfSetTempo:
		move.b	(a4),v_main_tempo(a6)		/* Set main tempo */
		move.b	(a4)+,v_main_tempo_timeout(a6)	/* And reset timeout (!) */
		rts	
# ===========================================================================
# loc_72BD0:
cfSetTempoMod:
		lea	v_music_track_ram(a6),a0
		move.b	(a4)+,d0			/* Get new tempo divider */
		moveq	#zTrackSz,d1
		moveq	#((v_music_track_ram_end-v_music_track_ram)/zTrackSz)-1,d2	/* 1 DAC + 6 FM + 3 PSG tracks */
# loc_72BDA:
1:
		move.b	d0,zTrackTempoDivider(a0)	/* Set track's tempo divider */
		adda.w	d1,a0
		dbf	d2,1b

		rts	
# ===========================================================================
# loc_72BE6: cfChangeVolume:
cfChangePSGVolume:
		move.b	(a4)+,d0		/* Get volume change */
		add.b	d0,zTrackVolume(a5)	/* Apply it */
		rts	
# ===========================================================================
# loc_72BEE:
cfClearPush:
		clr.b	f_push_playing(a6)	/* Allow push sound to be played once more */
		rts	
# ===========================================================================
# loc_72BF4:
cfStopSpecialFM4:
		bclr	#7,(a5)		/* Stop track (zTrackPlaybackControl) */
		bclr	#4,(a5)		/* Clear 'do not attack next note' bit (zTrackPlaybackControl) */
		jsr	FMNoteOff(pc)
		tst.b	v_sfx_fm4_track+zTrackPlaybackControl(a6)	/* Is SFX using FM4? */
		bmi.s	1f					/* Branch if yes */
		movea.l	a5,a3
		lea	v_music_fm4_track(a6),a5
		movea.l	v_voice_ptr(a6),a1	/* Voice pointer */
		bclr	#2,(a5)			/* Clear 'SFX is overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		move.b	zTrackVoiceIndex(a5),d0	/* Current voice */
		jsr	SetVoice(pc)
		movea.l	a3,a5
# loc_72C22:
1:
		addq.w	#8,sp		/* Tamper with return value so we don't return to caller */
		rts	
# ===========================================================================
# loc_72C26:
cfSetVoice:
		moveq	#0,d0
		move.b	(a4)+,d0		/* Get new voice */
		move.b	d0,zTrackVoiceIndex(a5)	/* Store it */
		btst	#2,(a5)			/* Is SFX overriding this track? (zTrackPlaybackControl) */
		bne.w	locret_72CAA		/* Return if yes */
		movea.l	v_voice_ptr(a6),a1	/* Music voice pointer */
		tst.b	f_voice_selector(a6)	/* Are we updating a music track? */
		beq.s	SetVoice		/* If yes, branch */
		movea.l	zTrackVoicePtr(a5),a1	/* SFX track voice pointer */
		tst.b	f_voice_selector(a6)	/* Are we updating a SFX track? */
		bmi.s	SetVoice		/* If yes, branch */
		movea.l	v_special_voice_ptr(a6),a1 /* Special SFX voice pointer */

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72C4E:
SetVoice:
		subq.w	#1,d0
		bmi.s	1f
		move.w	#25,d1
# loc_72C56:
2:
		adda.w	d1,a1
		dbf	d0,2b
# loc_72C5C:
1:
		move.b	(a1)+,d1		/* feedback/algorithm */
		move.b	d1,zTrackFeedbackAlgo(a5) /* Save it to track RAM */
		move.b	d1,d4
		move.b	#0xB0,d0			/* Command to write feedback/algorithm */
		jsr	WriteFMIorII(pc)
		lea	FMInstrumentOperatorTable(pc),a2
		moveq	#(FMInstrumentOperatorTable_End-FMInstrumentOperatorTable)-1,d3		/* Don't want to send TL yet */
# loc_72C72:
3:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		jsr	WriteFMIorII(pc)
		dbf	d3,3b

		moveq	#3,d5
		andi.w	#7,d4			/* Get algorithm */
		move.b	FMSlotMask(pc,d4.w),d4	/* Get slot mask for algorithm */
		move.b	zTrackVolume(a5),d3	/* Track volume attenuation */
# loc_72C8C:
4:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4		/* Is bit set for this operator in the mask? */
		bcc.s	5f		/* Branch if not */
		add.b	d3,d1		/* Include additional attenuation */
# loc_72C96:
5:
		jsr	WriteFMIorII(pc)
		dbf	d5,4b
		
		move.b	#0xB4,d0			/* Register for AMS/FMS/Panning */
		move.b	zTrackAMSFMSPan(a5),d1	/* Value to send */
		jsr	WriteFMIorII(pc) 	/* (It would be better if this were a jmp) */

locret_72CAA:
		rts	
# End of function SetVoice

# ===========================================================================
# byte_72CAC:
FMSlotMask:	dc.b 8,	8, 8, 8, 0xA, 0xE, 0xE, 0xF

# ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

# sub_72CB4:
SendVoiceTL:
		btst	#2,(a5)		/* Is SFX overriding? (zTrackPlaybackControl) */
		bne.s	1f		/* Return if so */
		moveq	#0,d0
		move.b	zTrackVoiceIndex(a5),d0	/* Current voice */
		movea.l	v_voice_ptr(a6),a1	/* Voice pointer */
		tst.b	f_voice_selector(a6)
		beq.s	2f
#		 DANGER! This uploads the wrong voice! It should have been a5 instead
#		 of a6!
		movea.l	zTrackVoicePtr(a6),a1
		tst.b	f_voice_selector(a6)
		bmi.s	2f
		movea.l	v_special_voice_ptr(a6),a1
# loc_72CD8:
2:
		subq.w	#1,d0
		bmi.s	3f
		move.w	#25,d1
# loc_72CE0:
4:
		adda.w	d1,a1
		dbf	d0,4b
# loc_72CE6:
3:
		adda.w	#21,a1				/* Want TL */
		lea	FMInstrumentTLTable(pc),a2
		move.b	zTrackFeedbackAlgo(a5),d0	/* Get feedback/algorithm */
		andi.w	#7,d0				/* Want only algorithm */
		move.b	FMSlotMask(pc,d0.w),d4		/* Get slot mask */
		move.b	zTrackVolume(a5),d3		/* Get track volume attenuation */
		bmi.s	1f				/* If negative, stop */
		moveq	#(FMInstrumentTLTable_End-FMInstrumentTLTable)-1,d5
# loc_72D02:
5:
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4		/* Is bit set for this operator in the mask? */
		bcc.s	6f		/* Branch if not */
		add.b	d3,d1		/* Include additional attenuation */
		blo.s	6f		/* Branch on overflow */
		jsr	WriteFMIorII(pc)
# loc_72D12:
6:
		dbf	d5,5b
# locret_72D16:
1:
		rts	
# End of function SendVoiceTL

# ===========================================================================
# byte_72D18:
FMInstrumentOperatorTable:
		dc.b  0x30		/* Detune/multiple operator 1 */
		dc.b  0x38		/* Detune/multiple operator 3 */
		dc.b  0x34		/* Detune/multiple operator 2 */
		dc.b  0x3C		/* Detune/multiple operator 4 */
		dc.b  0x50		/* Rate scalling/attack rate operator 1 */
		dc.b  0x58		/* Rate scalling/attack rate operator 3 */
		dc.b  0x54		/* Rate scalling/attack rate operator 2 */
		dc.b  0x5C		/* Rate scalling/attack rate operator 4 */
		dc.b  0x60		/* Amplitude modulation/first decay rate operator 1 */
		dc.b  0x68		/* Amplitude modulation/first decay rate operator 3 */
		dc.b  0x64		/* Amplitude modulation/first decay rate operator 2 */
		dc.b  0x6C		/* Amplitude modulation/first decay rate operator 4 */
		dc.b  0x70		/* Secondary decay rate operator 1 */
		dc.b  0x78		/* Secondary decay rate operator 3 */
		dc.b  0x74		/* Secondary decay rate operator 2 */
		dc.b  0x7C		/* Secondary decay rate operator 4 */
		dc.b  0x80		/* Secondary amplitude/release rate operator 1 */
		dc.b  0x88		/* Secondary amplitude/release rate operator 3 */
		dc.b  0x84		/* Secondary amplitude/release rate operator 2 */
		dc.b  0x8C		/* Secondary amplitude/release rate operator 4 */
FMInstrumentOperatorTable_End:
# byte_72D2C:
FMInstrumentTLTable:
		dc.b  0x40		/* Total level operator 1 */
		dc.b  0x48		/* Total level operator 3 */
		dc.b  0x44		/* Total level operator 2 */
		dc.b  0x4C		/* Total level operator 4 */
FMInstrumentTLTable_End:
# ===========================================================================
# loc_72D30:
cfModulation:
		bset	#3,(a5)				/* Turn on modulation (zTrackPlaybackControl) */
		move.l	a4,zTrackModulationPtr(a5)	/* Save pointer to modulation data */
		move.b	(a4)+,zTrackModulationWait(a5)	/* Modulation delay */
		move.b	(a4)+,zTrackModulationSpeed(a5)	/* Modulation speed */
		move.b	(a4)+,zTrackModulationDelta(a5)	/* Modulation delta */
		move.b	(a4)+,d0			/* Modulation steps... */
		lsr.b	#1,d0				/* ... divided by 2... */
		move.b	d0,zTrackModulationSteps(a5)	/* ... before being stored */
		clr.w	zTrackModulationVal(a5)		/* Total accumulated modulation frequency change */
		rts	
# ===========================================================================
# loc_72D52:
cfEnableModulation:
		bset	#3,(a5)		/* Turn on modulation (zTrackPlaybackControl) */
		rts	
# ===========================================================================
# loc_72D58:
cfStopTrack:
		bclr	#7,(a5)			/* Stop track (zTrackPlaybackControl) */
		bclr	#4,(a5)			/* Clear 'do not attack next note' bit (zTrackPlaybackControl) */
		tst.b	zTrackVoiceControl(a5)	/* Is this a PSG track? */
		bmi.s	1f		/* Branch if yes */
		tst.b	f_updating_dac(a6)	/* Is this the DAC we are updating? */
		bmi.w	2f		/* Exit if yes */
		jsr	FMNoteOff(pc)
		bra.s	3f
# ===========================================================================
# loc_72D74:
1:
		jsr	PSGNoteOff(pc)
# loc_72D78:
3:
		tst.b	f_voice_selector(a6)	/* Are we updating SFX? */
		bpl.w	2f		/* Exit if not */
		nop /* doing this again for bindiff */
		clr.b	v_sndprio(a6)		/* Clear priority */
		moveq	#0,d0
		move.b	zTrackVoiceControl(a5),d0 /* Get voice control bits */
		bmi.s	4f		/* Branch if PSG */
		lea	SFX_BGMChannelRAM(pc),a0
		movea.l	a5,a3
		cmpi.b	#4,d0			/* Is this FM4? */
		bne.s	5f		/* Branch if not */
		tst.b	v_spcsfx_fm4_track+zTrackPlaybackControl(a6)	/* Is special SFX playing? */
		bpl.s	5f		/* Branch if not */
		lea	v_spcsfx_fm4_track(a6),a5
		movea.l	v_special_voice_ptr(a6),a1	/* Get voice pointer */
		bra.s	6f
# ===========================================================================
# loc_72DA8:
5:
		subq.b	#2,d0		/* SFX can only use FM3 and up */
		lsl.b	#2,d0
		movea.l	(a0,d0.w),a5
		tst.b	(a5)			/* Is track playing? (zTrackPlaybackControl) */
		bpl.s	7f		/* Branch if not */
		movea.l	v_voice_ptr(a6),a1	/* Get voice pointer */
# loc_72DB8:
6:
		bclr	#2,(a5)			/* Clear 'SFX overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a5)			/* Set 'track at rest' bit (zTrackPlaybackControl) */
		move.b	zTrackVoiceIndex(a5),d0	/* Current voice */
		jsr	SetVoice(pc)
# loc_72DC8:
7:
		movea.l	a3,a5
		bra.s	2f
# ===========================================================================
# loc_72DCC:
4:
		lea	v_spcsfx_psg3_track(a6),a0
		tst.b	(a0)		/* Is track playing? */
		bpl.s	8f	/* Branch if not */
		cmpi.b	#0xE0,d0		/* Is it the noise channel? */
		beq.s	9f	/* Branch if yes */
		cmpi.b	#0xC0,d0		/* Is it PSG 3? */
		beq.s	9f	/* Branch if yes */
# loc_72DE0:
8:
		lea	SFX_BGMChannelRAM(pc),a0
		lsr.b	#3,d0
		movea.l	(a0,d0.w),a0
# loc_72DEA:
9:
		bclr	#2,(a0)				/* Clear 'SFX overriding' bit (zTrackPlaybackControl) */
		bset	#1,(a0)				/* Set 'track at rest' bit (zTrackPlaybackControl) */
		cmpi.b	#0xE0,zTrackVoiceControl(a0)	/* Is this a noise pointer? */
		bne.s	2f			/* Branch if not */
		move.b	zTrackPSGNoise(a0),(psg_input).l /* Set noise tone */
# loc_72E02:
2:
		addq.w	#8,sp		/* Tamper with return value so we don't go back to caller */
		rts	
# ===========================================================================
# loc_72E06:
cfSetPSGNoise:
		move.b	#0xE0,zTrackVoiceControl(a5)	/* Turn channel into noise channel */
		move.b	(a4)+,zTrackPSGNoise(a5)	/* Save noise tone */
		btst	#2,(a5)				/* Is track being overridden? (zTrackPlaybackControl) */
		bne.s	1f				/* Return if yes */
		move.b	-1(a4),(psg_input).l		/* Set tone */
# locret_72E1E:
1:
		rts	
# ===========================================================================
# loc_72E20:
cfDisableModulation:
		bclr	#3,(a5)		/* Disable modulation (zTrackPlaybackControl) */
		rts	
# ===========================================================================
# loc_72E26:
cfSetPSGTone:
		move.b	(a4)+,zTrackVoiceIndex(a5)	/* Set current PSG tone */
		rts	
# ===========================================================================
# loc_72E2C:
cfJumpTo:
		move.b	(a4)+,d0	/* High byte of offset */
		lsl.w	#8,d0		/* Shift it into place */
		move.b	(a4)+,d0	/* Low byte of offset */
		adda.w	d0,a4		/* Add to current position */
		subq.w	#1,a4		/* Put back one byte */
		rts	
# ===========================================================================
# loc_72E38:
cfRepeatAtPos:
		moveq	#0,d0
		move.b	(a4)+,d0			/* Loop index */
		move.b	(a4)+,d1			/* Repeat count */
		tst.b	zTrackLoopCounters(a5,d0.w)	/* Has this loop already started? */
		bne.s	1f			/* Branch if yes */
		move.b	d1,zTrackLoopCounters(a5,d0.w)	/* Initialize repeat count */
# loc_72E48:
1:
		subq.b	#1,zTrackLoopCounters(a5,d0.w)	/* Decrease loop's repeat count */
		bne.s	cfJumpTo			/* If nonzero, branch to target */
		addq.w	#2,a4				/* Skip target address */
		rts	
# ===========================================================================
# loc_72E52:
cfJumpToGosub:
		moveq	#0,d0
		move.b	zTrackStackPointer(a5),d0	/* Current stack pointer */
		subq.b	#4,d0				/* Add space for another target */
		move.l	a4,(a5,d0.w)			/* Put in current address (*before* target for jump!) */
		move.b	d0,zTrackStackPointer(a5)	/* Store new stack pointer */
		bra.s	cfJumpTo
# ===========================================================================
# loc_72E64:
cfOpF9:
		move.b	#0x88,d0		/* D1L/RR of Operator 3 */
		move.b	#0xF,d1		/* Loaded with fixed value (max RR, 1TL) */
		jsr	WriteFMI(pc)
		move.b	#0x8C,d0		/* D1L/RR of Operator 4 */
		move.b	#0xF,d1		/* Loaded with fixed value (max RR, 1TL) */
		bra.w	WriteFMI
# ===========================================================================

# GAS hates me. Below the 4 commented lines in my "replacement"

Kos_Z80:
		.incbin	"sound/z80_1.bin"		/* z80 Start-up code */
#		.if (((SegaPCM&0xFF8000)/0x8000)&1)==1						/* Least bit of bank ID (bit 15 of address), being loaded into register a */
#		dc.b 1
#		.else
		dc.b 0
#		.endc
		dc.b 0x32,0x00,0x60			/* ld	(zBankRegister),a		; Latch it to bank register, initializing bank switch */
		dc.b 0x06,0x08				/* ld	b,8				; Number of bits remaining to complete bank switch */
		dc.b 0x3E				/* ld	a,X				; Load into register a... */
#		dc.b ((SegaPCM&0xFF8000)/0x8000)>>1						/* ... the remaining bits of bank ID (bits 16-23) */
		dc.b 0x00
		.incbin	"sound/z80_2.bin"							/* Finishes bank switch, Jman2050 table, DAC sample loop */
#		dc.w ((SegaPCM&0xFF)<<8)+((SegaPCM&0x7F00)>>8)|0x80				/* Pointer to Sega PCM, relative to start of ROM bank (i.e., little_endian($8000 + SegaPCM&$7FFF), loaded into de */
		dc.w 0x1000
		dc.b 0x21				/* ld	hl,XX				; Load into register hl... */
#		dc.w (((SegaPCM_End-SegaPCM)&0xFF)<<8)+(((SegaPCM_End-SegaPCM)&0xFF00)>>8)	/* ... the size of the Sega PCM (little endian) */
		dc.w 0x7869
		.incbin	"sound/z80_3.bin"
		.align 2

Music81:	.incbin	"sound/music/Mus81 - GHZ.bin"
		.align 2
Music82:	.incbin	"sound/music/Mus82 - LZ.bin"
		.align 2
Music83:	.incbin	"sound/music/Mus83 - MZ.bin"
		.align 2
Music84:	.incbin	"sound/music/Mus84 - SLZ.bin"
		.align 2
Music85:	.incbin	"sound/music/Mus85 - SYZ.bin"
		.align 2
Music86:	.incbin	"sound/music/Mus86 - SBZ.bin"
		.align 2
Music87:	.incbin	"sound/music/Mus87 - Invincibility.bin"
		.align 2
Music88:	.incbin	"sound/music/Mus88 - Extra Life.bin"
		.align 2
Music89:	.incbin	"sound/music/Mus89 - Special Stage.bin"
		.align 2
Music8A:	.incbin	"sound/music/Mus8A - Title Screen.bin"
		.align 2
Music8B:	.incbin	"sound/music/Mus8B - Ending.bin"
		.align 2
Music8C:	.incbin	"sound/music/Mus8C - Boss.bin"
		.align 2
Music8D:	.incbin	"sound/music/Mus8D - FZ.bin"
		.align 2
Music8E:	.incbin	"sound/music/Mus8E - Sonic Got Through.bin"
		.align 2
Music8F:	.incbin	"sound/music/Mus8F - Game Over.bin"
		.align 2
Music90:	.incbin	"sound/music/Mus90 - Continue Screen.bin"
		.align 2
Music91:	.incbin	"sound/music/Mus91 - Credits.bin"
		.align 2
Music92:	.incbin	"sound/music/Mus92 - Drowning.bin"
		.align 2
Music93:	.incbin	"sound/music/Mus93 - Get Emerald.bin"
		.align 2
# ---------------------------------------------------------------------------
# Sound	effect pointers
# ---------------------------------------------------------------------------
SoundIndex:
ptr_sndA0:	dc.l SoundA0
ptr_sndA1:	dc.l SoundA1
ptr_sndA2:	dc.l SoundA2
ptr_sndA3:	dc.l SoundA3
ptr_sndA4:	dc.l SoundA4
ptr_sndA5:	dc.l SoundA5
ptr_sndA6:	dc.l SoundA6
ptr_sndA7:	dc.l SoundA7
ptr_sndA8:	dc.l SoundA8
ptr_sndA9:	dc.l SoundA9
ptr_sndAA:	dc.l SoundAA
ptr_sndAB:	dc.l SoundAB
ptr_sndAC:	dc.l SoundAC
ptr_sndAD:	dc.l SoundAD
ptr_sndAE:	dc.l SoundAE
ptr_sndAF:	dc.l SoundAF
ptr_sndB0:	dc.l SoundB0
ptr_sndB1:	dc.l SoundB1
ptr_sndB2:	dc.l SoundB2
ptr_sndB3:	dc.l SoundB3
ptr_sndB4:	dc.l SoundB4
ptr_sndB5:	dc.l SoundB5
ptr_sndB6:	dc.l SoundB6
ptr_sndB7:	dc.l SoundB7
ptr_sndB8:	dc.l SoundB8
ptr_sndB9:	dc.l SoundB9
ptr_sndBA:	dc.l SoundBA
ptr_sndBB:	dc.l SoundBB
ptr_sndBC:	dc.l SoundBC
ptr_sndBD:	dc.l SoundBD
ptr_sndBE:	dc.l SoundBE
ptr_sndBF:	dc.l SoundBF
ptr_sndC0:	dc.l SoundC0
ptr_sndC1:	dc.l SoundC1
ptr_sndC2:	dc.l SoundC2
ptr_sndC3:	dc.l SoundC3
ptr_sndC4:	dc.l SoundC4
ptr_sndC5:	dc.l SoundC5
ptr_sndC6:	dc.l SoundC6
ptr_sndC7:	dc.l SoundC7
ptr_sndC8:	dc.l SoundC8
ptr_sndC9:	dc.l SoundC9
ptr_sndCA:	dc.l SoundCA
ptr_sndCB:	dc.l SoundCB
ptr_sndCC:	dc.l SoundCC
ptr_sndCD:	dc.l SoundCD
ptr_sndCE:	dc.l SoundCE
ptr_sndCF:	dc.l SoundCF
ptr_sndend:
# ---------------------------------------------------------------------------
# Special sound effect pointers
# ---------------------------------------------------------------------------
SpecSoundIndex:
ptr_sndD0:	dc.l SoundD0
ptr_specend:
SoundA0:	.incbin	"sound/sfx/SndA0 - Jump.bin"
		.align 2
SoundA1:	.incbin	"sound/sfx/SndA1 - Lamppost.bin"
		.align 2
SoundA2:	.incbin	"sound/sfx/SndA2.bin"
		.align 2
SoundA3:	.incbin	"sound/sfx/SndA3 - Death.bin"
		.align 2
SoundA4:	.incbin	"sound/sfx/SndA4 - Skid.bin"
		.align 2
SoundA5:	.incbin	"sound/sfx/SndA5.bin"
		.align 2
SoundA6:	.incbin	"sound/sfx/SndA6 - Hit Spikes.bin"
		.align 2
SoundA7:	.incbin	"sound/sfx/SndA7 - Push Block.bin"
		.align 2
SoundA8:	.incbin	"sound/sfx/SndA8 - SS Goal.bin"
		.align 2
SoundA9:	.incbin	"sound/sfx/SndA9 - SS Item.bin"
		.align 2
SoundAA:	.incbin	"sound/sfx/SndAA - Splash.bin"
		.align 2
SoundAB:	.incbin	"sound/sfx/SndAB.bin"
		.align 2
SoundAC:	.incbin	"sound/sfx/SndAC - Hit Boss.bin"
		.align 2
SoundAD:	.incbin	"sound/sfx/SndAD - Get Bubble.bin"
		.align 2
SoundAE:	.incbin	"sound/sfx/SndAE - Fireball.bin"
		.align 2
SoundAF:	.incbin	"sound/sfx/SndAF - Shield.bin"
		.align 2
SoundB0:	.incbin	"sound/sfx/SndB0 - Saw.bin"
		.align 2
SoundB1:	.incbin	"sound/sfx/SndB1 - Electric.bin"
		.align 2
SoundB2:	.incbin	"sound/sfx/SndB2 - Drown Death.bin"
		.align 2
SoundB3:	.incbin	"sound/sfx/SndB3 - Flamethrower.bin"
		.align 2
SoundB4:	.incbin	"sound/sfx/SndB4 - Bumper.bin"
		.align 2
SoundB5:	.incbin	"sound/sfx/SndB5 - Ring.bin"
		.align 2
SoundB6:	.incbin	"sound/sfx/SndB6 - Spikes Move.bin"
		.align 2
SoundB7:	.incbin	"sound/sfx/SndB7 - Rumbling.bin"
		.align 2
SoundB8:	.incbin	"sound/sfx/SndB8.bin"
		.align 2
SoundB9:	.incbin	"sound/sfx/SndB9 - Collapse.bin"
		.align 2
SoundBA:	.incbin	"sound/sfx/SndBA - SS Glass.bin"
		.align 2
SoundBB:	.incbin	"sound/sfx/SndBB - Door.bin"
		.align 2
SoundBC:	.incbin	"sound/sfx/SndBC - Teleport.bin"
		.align 2
SoundBD:	.incbin	"sound/sfx/SndBD - ChainStomp.bin"
		.align 2
SoundBE:	.incbin	"sound/sfx/SndBE - Roll.bin"
		.align 2
SoundBF:	.incbin	"sound/sfx/SndBF - Get Continue.bin"
		.align 2
SoundC0:	.incbin	"sound/sfx/SndC0 - Basaran Flap.bin"
		.align 2
SoundC1:	.incbin	"sound/sfx/SndC1 - Break Item.bin"
		.align 2
SoundC2:	.incbin	"sound/sfx/SndC2 - Drown Warning.bin"
		.align 2
SoundC3:	.incbin	"sound/sfx/SndC3 - Giant Ring.bin"
		.align 2
SoundC4:	.incbin	"sound/sfx/SndC4 - Bomb.bin"
		.align 2
SoundC5:	.incbin	"sound/sfx/SndC5 - Cash Register.bin"
		.align 2
SoundC6:	.incbin	"sound/sfx/SndC6 - Ring Loss.bin"
		.align 2
SoundC7:	.incbin	"sound/sfx/SndC7 - Chain Rising.bin"
		.align 2
SoundC8:	.incbin	"sound/sfx/SndC8 - Burning.bin"
		.align 2
SoundC9:	.incbin	"sound/sfx/SndC9 - Hidden Bonus.bin"
		.align 2
SoundCA:	.incbin	"sound/sfx/SndCA - Enter SS.bin"
		.align 2
SoundCB:	.incbin	"sound/sfx/SndCB - Wall Smash.bin"
		.align 2
SoundCC:	.incbin	"sound/sfx/SndCC - Spring.bin"
		.align 2
SoundCD:	.incbin	"sound/sfx/SndCD - Switch.bin"
		.align 2
SoundCE:	.incbin	"sound/sfx/SndCE - Ring Left Speaker.bin"
		.align 2
SoundCF:	.incbin	"sound/sfx/SndCF - Signpost.bin"
		.align 2
SoundD0:	.incbin	"sound/sfx/SndD0 - Waterfall.bin"
		.align 2

SegaPCM:	
		.incbin	"sound/dac/segapcm.bin"
SegaPCM_End:
		.align 0x8000
