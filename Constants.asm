# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

.equ Size_of_SegaPCM, 0x6978

# VDP addressses
.equ vdp_data_port, 0xC00000
.equ vdp_control_port, 0xC00004
.equ vdp_counter, 0xC00008

.equ psg_input, 0xC00011

# Z80 addresses
.equ z80_ram, 0xA00000	/* start of Z80 RAM */
.equ z80_dac3_pitch, 0xA000EA
.equ z80_dac_status, 0xA01FFD
.equ z80_dac_sample, 0xA01FFF
.equ z80_ram_end, 0xA02000	/* end of non-reserved Z80 RAM */
.equ z80_version, 0xA10001
.equ z80_port_1_data, 0xA10002
.equ z80_port_1_control, 0xA10008
.equ z80_port_2_control, 0xA1000A
.equ z80_expansion_control, 0xA1000C
.equ z80_bus_request, 0xA11100
.equ z80_reset, 0xA11200
.equ ym2612_a0, 0xA04000
.equ ym2612_d0, 0xA04001
.equ ym2612_a1, 0xA04002
.equ ym2612_d1, 0xA04003

.equ security_addr, 0xA14000

# Sound driver constants
.equ zTrackPlaybackControl, 0		/* All tracks */
.equ zTrackVoiceControl, 1		/* All tracks */
.equ zTrackTempoDivider, 2		/* All tracks */
.equ zTrackDataPointer, 4		/* All tracks (4 bytes) */
.equ zTrackTranspose, 8		/* FM/PSG only (sometimes written to as a word, to include zTrackVolume) */
.equ zTrackVolume, 9		/* FM/PSG only */
.equ zTrackAMSFMSPan, 0xA		/* FM/DAC only */
.equ zTrackVoiceIndex, 0xB		/* FM/PSG only */
.equ zTrackVolEnvIndex, 0xC		/* PSG only */
.equ zTrackStackPointer, 0xD		/* All tracks */
.equ zTrackDurationTimeout, 0xE		/* All tracks */
.equ zTrackSavedDuration, 0xF		/* All tracks */
.equ zTrackSavedDAC, 0x10		/* DAC only */
.equ zTrackFreq, 0x10		/* FM/PSG only (2 bytes) */
.equ zTrackNoteFillTimeout, 0x12		/* FM/PSG only */
.equ zTrackNoteFillMaster, 0x13		/* FM/PSG only */
.equ zTrackModulationPtr, 0x14		/* FM/PSG only (4 bytes) */
.equ zTrackModulationWait, 0x18		/* FM/PSG only */
.equ zTrackModulationSpeed, 0x19		/* FM/PSG only */
.equ zTrackModulationDelta, 0x1A		/* FM/PSG only */
.equ zTrackModulationSteps, 0x1B		/* FM/PSG only */
.equ zTrackModulationVal, 0x1C		/* FM/PSG only (2 bytes) */
.equ zTrackDetune, 0x1E		/* FM/PSG only */
.equ zTrackPSGNoise, 0x1F		/* PSG only */
.equ zTrackFeedbackAlgo, 0x1F		/* FM only */
.equ zTrackVoicePtr, 0x20		/* FM SFX only (4 bytes) */
.equ zTrackLoopCounters, 0x24		/* All tracks (multiple bytes) */
.equ zTrackGoSubStack, zTrackSz	/* All tracks (multiple bytes. This constant won't get to be used because of an optimisation that just uses zTrackSz) */

.equ zTrackSz, 0x30

# VRAM data
.equ vram_fg, 0xC000	/* foreground namespace */
.equ vram_bg, 0xE000	/* background namespace */
.equ vram_sonic, 0xF000	/* Sonic graphics */
.equ vram_sprites, 0xF800	/* sprite table */
.equ vram_hscroll, 0xFC00	/* horizontal scroll table */

# Game modes
.equ id_Sega, ptr_GM_Sega-GameModeArray	/* $00 */
.equ id_Title, ptr_GM_Title-GameModeArray	/* $04 */
.equ id_Demo, ptr_GM_Demo-GameModeArray	/* $08 */
.equ id_Level, ptr_GM_Level-GameModeArray	/* $0C */
.equ id_Special, ptr_GM_Special-GameModeArray/* $10 */
.equ id_Continue, ptr_GM_Cont-GameModeArray	/* $14 */
.equ id_Ending, ptr_GM_Ending-GameModeArray	/* $18 */
.equ id_Credits, ptr_GM_Credits-GameModeArray/* $1C */

# Levels
.equ id_GHZ, 0
.equ id_LZ, 1
.equ id_MZ, 2
.equ id_SLZ, 3
.equ id_SYZ, 4
.equ id_SBZ, 5
.equ id_EndZ, 6
.equ id_SS, ZoneCount	/* 7 by default */

# Colours
.equ cBlack, 0x000		/* colour black */
.equ cWhite, 0xEEE		/* colour white */
.equ cBlue, 0xE00		/* colour blue */
.equ cGreen, 0x0E0		/* colour green */
.equ cRed, 0x00E		/* colour red */
.equ cYellow, cGreen+cRed		/* colour yellow */
.equ cAqua, cGreen+cBlue	/* colour aqua */
.equ cMagenta, cBlue+cRed		/* colour magenta */

# Joypad input
.equ btnStart, 0b10000000 /* Start button	($80) */
.equ btnA, 0b01000000 /* A		($40) */
.equ btnC, 0b00100000 /* C		($20) */
.equ btnB, 0b00010000 /* B		($10) */
.equ btnR, 0b00001000 /* Right		($08) */
.equ btnL, 0b00000100 /* Left		($04) */
.equ btnDn, 0b00000010 /* Down		($02) */
.equ btnUp, 0b00000001 /* Up		($01) */
.equ btnDir, 0b00001111 /* Any direction	($0F) */
.equ btnABC, 0b01110000 /* A, B or C	($70) */
.equ bitStart, 7
.equ bitA, 6
.equ bitC, 5
.equ bitB, 4
.equ bitR, 3
.equ bitL, 2
.equ bitDn, 1
.equ bitUp, 0

# Object variables
.equ obRender, 1	/* bitfield for x/y flip, display mode */
.equ obGfx, 2	/* palette line & VRAM setting (2 bytes) */
.equ obMap, 4	/* mappings address (4 bytes) */
.equ obX, 8	/* x-axis position (2-4 bytes) */
.equ obScreenY, 0xA	/* y-axis position for screen-fixed items (2 bytes) */
.equ obY, 0xC	/* y-axis position (2-4 bytes) */
.equ obVelX, 0x10	/* x-axis velocity (2 bytes) */
.equ obVelY, 0x12	/* y-axis velocity (2 bytes) */
.equ obInertia, 0x14	/* potential speed (2 bytes) */
.equ obHeight, 0x16	/* height/2 */
.equ obWidth, 0x17	/* width/2 */
.equ obPriority, 0x18	/* sprite stack priority -- 0 is front */
.equ obActWid, 0x19	/* action width */
.equ obFrame, 0x1A	/* current frame displayed */
.equ obAniFrame, 0x1B	/* current frame in animation script */
.equ obAnim, 0x1C	/* current animation */
.equ obNextAni, 0x1D	/* next animation */
.equ obTimeFrame, 0x1E	/* time to next frame */
.equ obDelayAni, 0x1F	/* time to delay animation */
.equ obColType, 0x20	/* collision response type */
.equ obColProp, 0x21	/* collision extra property */
.equ obStatus, 0x22	/* orientation or mode */
.equ obRespawnNo, 0x23	/* respawn list index number */
.equ obRoutine, 0x24	/* routine number */
.equ ob2ndRout, 0x25	/* secondary routine number */
.equ obAngle, 0x26	/* angle */
.equ obSubtype, 0x28	/* object subtype */
.equ obSolid, ob2ndRout /* solid status flag */

# Object variables (Sonic 2 disassembly nomenclature)
.equ render_flags, 1	/* bitfield for x/y flip, display mode */
.equ art_tile, 2	/* palette line & VRAM setting (2 bytes) */
.equ mappings, 4	/* mappings address (4 bytes) */
.equ x_pos, 8	/* x-axis position (2-4 bytes) */
.equ y_pos, 0xC	/* y-axis position (2-4 bytes) */
.equ x_vel, 0x10	/* x-axis velocity (2 bytes) */
.equ y_vel, 0x12	/* y-axis velocity (2 bytes) */
.equ y_radius, 0x16	/* height/2 */
.equ x_radius, 0x17	/* width/2 */
.equ priority, 0x18	/* sprite stack priority -- 0 is front */
.equ width_pixels, 0x19	/* action width */
.equ mapping_frame, 0x1A	/* current frame displayed */
.equ anim_frame, 0x1B	/* current frame in animation script */
.equ anim, 0x1C	/* current animation */
.equ next_anim, 0x1D	/* next animation */
.equ anim_frame_duration, 0x1E /* time to next frame */
.equ collision_flags, 0x20 /* collision response type */
.equ collision_property, 0x21 /* collision extra property */
.equ status, 0x22	/* orientation or mode */
.equ respawn_index, 0x23	/* respawn list index number */
.equ routine, 0x24	/* routine number */
.equ routine_secondary, 0x25 /* secondary routine number */
.equ angle, 0x26	/* angle */
.equ subtype, 0x28	/* object subtype */

# Animation flags
.equ afEnd, 0xFF	/* return to beginning of animation */
.equ afBack, 0xFE	/* go back (specified number) bytes */
.equ afChange, 0xFD	/* run specified animation */
.equ afRoutine, 0xFC	/* increment routine counter */
.equ afReset, 0xFB	/* reset animation and 2nd object routine counter */
.equ af2ndRoutine, 0xFA	/* increment 2nd routine counter */

# Background music
.equ bgm__First, 0x81
.equ bgm_GHZ, ((ptr_mus81-MusicIndex)/4)+bgm__First
.equ bgm_LZ, ((ptr_mus82-MusicIndex)/4)+bgm__First
.equ bgm_MZ, ((ptr_mus83-MusicIndex)/4)+bgm__First
.equ bgm_SLZ, ((ptr_mus84-MusicIndex)/4)+bgm__First
.equ bgm_SYZ, ((ptr_mus85-MusicIndex)/4)+bgm__First
.equ bgm_SBZ, ((ptr_mus86-MusicIndex)/4)+bgm__First
.equ bgm_Invincible, ((ptr_mus87-MusicIndex)/4)+bgm__First
.equ bgm_ExtraLife, ((ptr_mus88-MusicIndex)/4)+bgm__First
.equ bgm_SS, ((ptr_mus89-MusicIndex)/4)+bgm__First
.equ bgm_Title, ((ptr_mus8A-MusicIndex)/4)+bgm__First
.equ bgm_Ending, ((ptr_mus8B-MusicIndex)/4)+bgm__First
.equ bgm_Boss, ((ptr_mus8C-MusicIndex)/4)+bgm__First
.equ bgm_FZ, ((ptr_mus8D-MusicIndex)/4)+bgm__First
.equ bgm_GotThrough, ((ptr_mus8E-MusicIndex)/4)+bgm__First
.equ bgm_GameOver, ((ptr_mus8F-MusicIndex)/4)+bgm__First
.equ bgm_Continue, ((ptr_mus90-MusicIndex)/4)+bgm__First
.equ bgm_Credits, ((ptr_mus91-MusicIndex)/4)+bgm__First
.equ bgm_Drowning, ((ptr_mus92-MusicIndex)/4)+bgm__First
.equ bgm_Emerald, ((ptr_mus93-MusicIndex)/4)+bgm__First
.equ bgm__Last, ((ptr_musend-MusicIndex-4)/4)+bgm__First

# Sound effects
.equ sfx__First, 0xA0
.equ sfx_Jump, ((ptr_sndA0-SoundIndex)/4)+sfx__First
.equ sfx_Lamppost, ((ptr_sndA1-SoundIndex)/4)+sfx__First
.equ sfx_A2, ((ptr_sndA2-SoundIndex)/4)+sfx__First
.equ sfx_Death, ((ptr_sndA3-SoundIndex)/4)+sfx__First
.equ sfx_Skid, ((ptr_sndA4-SoundIndex)/4)+sfx__First
.equ sfx_A5, ((ptr_sndA5-SoundIndex)/4)+sfx__First
.equ sfx_HitSpikes, ((ptr_sndA6-SoundIndex)/4)+sfx__First
.equ sfx_Push, ((ptr_sndA7-SoundIndex)/4)+sfx__First
.equ sfx_SSGoal, ((ptr_sndA8-SoundIndex)/4)+sfx__First
.equ sfx_SSItem, ((ptr_sndA9-SoundIndex)/4)+sfx__First
.equ sfx_Splash, ((ptr_sndAA-SoundIndex)/4)+sfx__First
.equ sfx_AB, ((ptr_sndAB-SoundIndex)/4)+sfx__First
.equ sfx_HitBoss, ((ptr_sndAC-SoundIndex)/4)+sfx__First
.equ sfx_Bubble, ((ptr_sndAD-SoundIndex)/4)+sfx__First
.equ sfx_Fireball, ((ptr_sndAE-SoundIndex)/4)+sfx__First
.equ sfx_Shield, ((ptr_sndAF-SoundIndex)/4)+sfx__First
.equ sfx_Saw, ((ptr_sndB0-SoundIndex)/4)+sfx__First
.equ sfx_Electric, ((ptr_sndB1-SoundIndex)/4)+sfx__First
.equ sfx_Drown, ((ptr_sndB2-SoundIndex)/4)+sfx__First
.equ sfx_Flamethrower, ((ptr_sndB3-SoundIndex)/4)+sfx__First
.equ sfx_Bumper, ((ptr_sndB4-SoundIndex)/4)+sfx__First
.equ sfx_Ring, ((ptr_sndB5-SoundIndex)/4)+sfx__First
.equ sfx_SpikesMove, ((ptr_sndB6-SoundIndex)/4)+sfx__First
.equ sfx_Rumbling, ((ptr_sndB7-SoundIndex)/4)+sfx__First
.equ sfx_B8, ((ptr_sndB8-SoundIndex)/4)+sfx__First
.equ sfx_Collapse, ((ptr_sndB9-SoundIndex)/4)+sfx__First
.equ sfx_SSGlass, ((ptr_sndBA-SoundIndex)/4)+sfx__First
.equ sfx_Door, ((ptr_sndBB-SoundIndex)/4)+sfx__First
.equ sfx_Teleport, ((ptr_sndBC-SoundIndex)/4)+sfx__First
.equ sfx_ChainStomp, ((ptr_sndBD-SoundIndex)/4)+sfx__First
.equ sfx_Roll, ((ptr_sndBE-SoundIndex)/4)+sfx__First
.equ sfx_Continue, ((ptr_sndBF-SoundIndex)/4)+sfx__First
.equ sfx_Basaran, ((ptr_sndC0-SoundIndex)/4)+sfx__First
.equ sfx_BreakItem, ((ptr_sndC1-SoundIndex)/4)+sfx__First
.equ sfx_Warning, ((ptr_sndC2-SoundIndex)/4)+sfx__First
.equ sfx_GiantRing, ((ptr_sndC3-SoundIndex)/4)+sfx__First
.equ sfx_Bomb, ((ptr_sndC4-SoundIndex)/4)+sfx__First
.equ sfx_Cash, ((ptr_sndC5-SoundIndex)/4)+sfx__First
.equ sfx_RingLoss, ((ptr_sndC6-SoundIndex)/4)+sfx__First
.equ sfx_ChainRise, ((ptr_sndC7-SoundIndex)/4)+sfx__First
.equ sfx_Burning, ((ptr_sndC8-SoundIndex)/4)+sfx__First
.equ sfx_Bonus, ((ptr_sndC9-SoundIndex)/4)+sfx__First
.equ sfx_EnterSS, ((ptr_sndCA-SoundIndex)/4)+sfx__First
.equ sfx_WallSmash, ((ptr_sndCB-SoundIndex)/4)+sfx__First
.equ sfx_Spring, ((ptr_sndCC-SoundIndex)/4)+sfx__First
.equ sfx_Switch, ((ptr_sndCD-SoundIndex)/4)+sfx__First
.equ sfx_RingLeft, ((ptr_sndCE-SoundIndex)/4)+sfx__First
.equ sfx_Signpost, ((ptr_sndCF-SoundIndex)/4)+sfx__First
.equ sfx__Last, ((ptr_sndend-SoundIndex-4)/4)+sfx__First

# Special sound effects
.equ spec__First, 0xD0
.equ sfx_Waterfall, ((ptr_sndD0-SpecSoundIndex)/4)+spec__First
.equ spec__Last, ((ptr_specend-SpecSoundIndex-4)/4)+spec__First

.equ flg__First, 0xE0
.equ bgm_Fade, ((ptr_flgE0-Sound_ExIndex)/4)+flg__First
.equ sfx_Sega, ((ptr_flgE1-Sound_ExIndex)/4)+flg__First
.equ bgm_Speedup, ((ptr_flgE2-Sound_ExIndex)/4)+flg__First
.equ bgm_Slowdown, ((ptr_flgE3-Sound_ExIndex)/4)+flg__First
.equ bgm_Stop, ((ptr_flgE4-Sound_ExIndex)/4)+flg__First
.equ flg__Last, ((ptr_flgend-Sound_ExIndex-4)/4)+flg__First

