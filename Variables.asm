# Variables (v) and Flags (f)

.equ v_regbuffer, 0xFFFFFC00	/* stores registers d0-a7 during an error event ($40 bytes) */
.equ v_spbuffer, 0xFFFFFC40	/* stores most recent sp address (4 bytes) */
.equ v_errortype, 0xFFFFFC44	/* error type */

.equ v_256x256,   0xFF0000	/* 256x256 tile mappings ($A400 bytes) */
.equ v_lvllayout, 0xFFFFA400	/* level and background layouts ($400 bytes) */

.equ v_ngfx_buffer, 0xFFFFAA00	/* Nemesis graphics decompression buffer ($200 bytes) */
.equ v_spritequeue, 0xFFFFAC00	/* sprite display queue, in order of priority ($400 bytes) */
.equ v_16x16, 0xFFFFB000	/* 16x16 tile mappings */

.equ v_sgfx_buffer, 0xFFFFC800	/* buffered Sonic graphics ($17 cells) ($2E0 bytes) */
.equ v_tracksonic, 0xFFFFCB00	/* position tracking data for Sonic ($100 bytes) */
.equ v_hscrolltablebuffer, 0xFFFFCC00 /* scrolling table data (actually $380 bytes, but $400 is reserved for it) */
.equ v_objspace, 0xFFFFD000	/* object variable space ($40 bytes per object) ($2000 bytes) */
.equ v_player, v_objspace	/* object variable space for Sonic ($40 bytes) */
.equ v_lvlobjspace, 0xFFFFD800	/* level object variable space ($1800 bytes) */

.equ v_snddriver_ram, 0xFFFFF000 /* start of RAM for the sound driver data ($5C0 bytes) */

# =================================================================================
# From here on, until otherwise stated, all offsets are relative to v_snddriver_ram
# =================================================================================
.equ v_startofvariables, 0x000
.equ v_sndprio, 0x000	/* sound priority (priority of new music/SFX must be higher or equal to this value or it won't play; bit 7 of priority being set prevents this value from changing) */
.equ v_main_tempo_timeout, 0x001	/* Counts down to zero; when zero, resets to next value and delays song by 1 frame */
.equ v_main_tempo, 0x002	/* Used for music only */
.equ f_stopmusic, 0x003	/* flag set to stop music when paused */
.equ v_fadeout_counter, 0x004

.equ v_fadeout_delay, 0x006
.equ v_communication_byte, 0x007	/* used in Ristar to sync with a boss' attacks; unused here */
.equ f_updating_dac, 0x008	/* $80 if updating DAC, $00 otherwise */
.equ v_playsnd0, 0x009	/* sound or music copied from below */
.equ v_playsnd1, 0x00A	/* sound or music to play */
.equ v_playsnd2, 0x00B	/* special sound to play */
.equ v_playnull, 0x00C	/* unused sound to play */

.equ f_voice_selector, 0x00E	/* $00 = use music voice pointer; $40 = use special voice pointer; $80 = use track voice pointer */

.equ v_voice_ptr, 0x018	/* voice data pointer (4 bytes) */

.equ v_special_voice_ptr, 0x020	/* voice data pointer for special SFX ($D0-$DF) (4 bytes) */

.equ f_fadein_flag, 0x024	/* Flag for fade in */
.equ v_fadein_delay, 0x025
.equ v_fadein_counter, 0x026	/* Timer for fade in/out */
.equ f_1up_playing, 0x027	/* flag indicating 1-up song is playing */
.equ v_tempo_mod, 0x028	/* music - tempo modifier */
.equ v_speeduptempo, 0x029	/* music - tempo modifier with speed shoes */
.equ f_speedup, 0x02A	/* flag indicating whether speed shoes tempo is on ($80) or off ($00) */
.equ v_ring_speaker, 0x02B	/* which speaker the "ring" sound is played in (00 = right; 01 = left) */
.equ f_push_playing, 0x02C	/* if set, prevents further push sounds from playing */

.equ v_music_track_ram, 0x040	/* Start of music RAM */

.equ v_music_fmdac_tracks, v_music_track_ram+zTrackSz*0
.equ v_music_dac_track, v_music_fmdac_tracks+zTrackSz*0
.equ v_music_fm_tracks, v_music_fmdac_tracks+zTrackSz*1
.equ v_music_fm1_track, v_music_fm_tracks+zTrackSz*0
.equ v_music_fm2_track, v_music_fm_tracks+zTrackSz*1
.equ v_music_fm3_track, v_music_fm_tracks+zTrackSz*2
.equ v_music_fm4_track, v_music_fm_tracks+zTrackSz*3
.equ v_music_fm5_track, v_music_fm_tracks+zTrackSz*4
.equ v_music_fm6_track, v_music_fm_tracks+zTrackSz*5
.equ v_music_fm_tracks_end, v_music_fm_tracks+zTrackSz*6
.equ v_music_fmdac_tracks_end, v_music_fm_tracks_end
.equ v_music_psg_tracks, v_music_fmdac_tracks_end
.equ v_music_psg1_track, v_music_psg_tracks+zTrackSz*0
.equ v_music_psg2_track, v_music_psg_tracks+zTrackSz*1
.equ v_music_psg3_track, v_music_psg_tracks+zTrackSz*2
.equ v_music_psg_tracks_end, v_music_psg_tracks+zTrackSz*3
.equ v_music_track_ram_end, v_music_psg_tracks_end

.equ v_sfx_track_ram, v_music_track_ram_end	/* Start of SFX RAM, straight after the end of music RAM */

.equ v_sfx_fm_tracks, v_sfx_track_ram+zTrackSz*0
.equ v_sfx_fm3_track, v_sfx_fm_tracks+zTrackSz*0
.equ v_sfx_fm4_track, v_sfx_fm_tracks+zTrackSz*1
.equ v_sfx_fm5_track, v_sfx_fm_tracks+zTrackSz*2
.equ v_sfx_fm_tracks_end, v_sfx_fm_tracks+zTrackSz*3
.equ v_sfx_psg_tracks, v_sfx_fm_tracks_end
.equ v_sfx_psg1_track, v_sfx_psg_tracks+zTrackSz*0
.equ v_sfx_psg2_track, v_sfx_psg_tracks+zTrackSz*1
.equ v_sfx_psg3_track, v_sfx_psg_tracks+zTrackSz*2
.equ v_sfx_psg_tracks_end, v_sfx_psg_tracks+zTrackSz*3
.equ v_sfx_track_ram_end, v_sfx_psg_tracks_end

.equ v_spcsfx_track_ram, v_sfx_track_ram_end	/* Start of special SFX RAM, straight after the end of SFX RAM */

.equ v_spcsfx_fm4_track, v_spcsfx_track_ram+zTrackSz*0
.equ v_spcsfx_psg3_track, v_spcsfx_track_ram+zTrackSz*1
.equ v_spcsfx_track_ram_end, v_spcsfx_track_ram+zTrackSz*2

.equ v_1up_ram_copy, v_spcsfx_track_ram_end

# =================================================================================
# From here on, no longer relative to sound driver RAM
# =================================================================================

.equ v_gamemode, 0xFFFFF600	/* game mode (00=Sega; 04=Title; 08=Demo; 0C=Level; 10=SS; 14=Cont; 18=End; 1C=Credit; +8C=PreLevel) */
.equ v_jpadhold2, 0xFFFFF602	/* joypad input - held, duplicate */
.equ v_jpadpress2, 0xFFFFF603	/* joypad input - pressed, duplicate */
.equ v_jpadhold1, 0xFFFFF604	/* joypad input - held */
.equ v_jpadpress1, 0xFFFFF605	/* joypad input - pressed */

.equ v_vdp_buffer1, 0xFFFFF60C	/* VDP instruction buffer (2 bytes) */

.equ v_demolength, 0xFFFFF614	/* the length of a demo in frames (2 bytes) */
.equ v_scrposy_dup, 0xFFFFF616	/* screen position y (duplicate) (2 bytes) */

.equ v_scrposx_dup, 0xFFFFF61A	/* screen position x (duplicate) (2 bytes) */

.equ v_hbla_hreg, 0xFFFFF624	/* VDP H.interrupt register buffer (8Axx) (2 bytes) */
.equ v_hbla_line, 0xFFFFF625	/* screen line where water starts and palette is changed by HBlank */
.equ v_pfade_start, 0xFFFFF626	/* palette fading - start position in bytes */
.equ v_pfade_size, 0xFFFFF627	/* palette fading - number of colours */
.equ v_vbla_routine, 0xFFFFF62A	/* VBlank - routine counter */
.equ v_spritecount, 0xFFFFF62C	/* number of sprites on-screen */
.equ v_pcyc_num, 0xFFFFF632	/* palette cycling - current reference number (2 bytes) */
.equ v_pcyc_time, 0xFFFFF634	/* palette cycling - time until the next change (2 bytes) */
.equ v_random, 0xFFFFF636	/* pseudo random number buffer (4 bytes) */
.equ f_pause, 0xFFFFF63A	/* flag set to pause the game (2 bytes) */
.equ v_vdp_buffer2, 0xFFFFF640	/* VDP instruction buffer (2 bytes) */
.equ f_hbla_pal, 0xFFFFF644	/* flag set to change palette during HBlank (0000 = no; 0001 = change) (2 bytes) */
.equ v_waterpos1, 0xFFFFF646	/* water height, actual (2 bytes) */
.equ v_waterpos2, 0xFFFFF648	/* water height, ignoring sway (2 bytes) */
.equ v_waterpos3, 0xFFFFF64A	/* water height, next target (2 bytes) */
.equ f_water, 0xFFFFF64C	/* flag set for water */
.equ v_wtr_routine, 0xFFFFF64D	/* water event - routine counter */
.equ f_wtr_state, 0xFFFFF64E	/* water palette state when water is above/below the screen (00 = partly/all dry; 01 = all underwater) */

.equ v_pal_buffer, 0xFFFFF650	/* palette data buffer (used for palette cycling) ($30 bytes) */
.equ v_plc_buffer, 0xFFFFF680	/* pattern load cues buffer (maximum $10 PLCs) ($60 bytes) */
.equ v_ptrnemcode, 0xFFFFF6E0	/* pointer for nemesis decompression code ($1502 or $150C) (4 bytes) */

.equ f_plc_execute, 0xFFFFF6F8	/* flag set for pattern load cue execution (2 bytes) */

.equ v_screenposx, 0xFFFFF700	/* screen position x (2 bytes) */
.equ v_screenposy, 0xFFFFF704	/* screen position y (2 bytes) */
.equ v_bgscreenposx, 0xFFFFF708	/* background screen position x (2 bytes) */
.equ v_bgscreenposy, 0xFFFFF70C	/* background screen position y (2 bytes) */
.equ v_bg2screenposx, 0xFFFFF710	/* 2 bytes */
.equ v_bg2screenposy, 0xFFFFF714	/* 2 bytes */
.equ v_bg3screenposx, 0xFFFFF718	/* 2 bytes */
.equ v_bg3screenposy, 0xFFFFF71C	/* 2 bytes */

.equ v_limitleft1, 0xFFFFF720	/* left level boundary (2 bytes) */
.equ v_limitright1, 0xFFFFF722	/* right level boundary (2 bytes) */
.equ v_limittop1, 0xFFFFF724	/* top level boundary (2 bytes) */
.equ v_limitbtm1, 0xFFFFF726	/* bottom level boundary (2 bytes) */
.equ v_limitleft2, 0xFFFFF728	/* left level boundary (2 bytes) */
.equ v_limitright2, 0xFFFFF72A	/* right level boundary (2 bytes) */
.equ v_limittop2, 0xFFFFF72C	/* top level boundary (2 bytes) */
.equ v_limitbtm2, 0xFFFFF72E	/* bottom level boundary (2 bytes) */

.equ v_limitleft3, 0xFFFFF732	/* left level boundary, at the end of an act (2 bytes) */

.equ v_scrshiftx, 0xFFFFF73A	/* screen shift as Sonic moves horizontally */

.equ v_lookshift, 0xFFFFF73E	/* screen shift when Sonic looks up/down (2 bytes) */
.equ v_dle_routine, 0xFFFFF742	/* dynamic level event - routine counter */
.equ f_nobgscroll, 0xFFFFF744	/* flag set to cancel background scrolling */

.equ v_bgscroll1, 0xFFFFF754	/* background scrolling variable 1 */
.equ v_bgscroll2, 0xFFFFF756	/* background scrolling variable 2 */
.equ v_bgscroll3, 0xFFFFF758	/* background scrolling variable 3 */
.equ f_bgscrollvert, 0xFFFFF75C	/* flag for vertical background scrolling */
.equ v_sonspeedmax, 0xFFFFF760	/* Sonic's maximum speed (2 bytes) */
.equ v_sonspeedacc, 0xFFFFF762	/* Sonic's acceleration (2 bytes) */
.equ v_sonspeeddec, 0xFFFFF764	/* Sonic's deceleration (2 bytes) */
.equ v_sonframenum, 0xFFFFF766	/* frame to display for Sonic */
.equ f_sonframechg, 0xFFFFF767	/* flag set to update Sonic's sprite frame */
.equ v_anglebuffer, 0xFFFFF768	/* angle of collision block that Sonic or object is standing on */

.equ v_opl_routine, 0xFFFFF76C	/* ObjPosLoad - routine counter */
.equ v_opl_screen, 0xFFFFF76E	/* ObjPosLoad - screen variable */
.equ v_opl_data, 0xFFFFF770	/* ObjPosLoad - data buffer ($10 bytes) */

.equ v_ssangle, 0xFFFFF780	/* Special Stage angle (2 bytes) */
.equ v_ssrotate, 0xFFFFF782	/* Special Stage rotation speed (2 bytes) */
.equ v_btnpushtime1, 0xFFFFF790	/* button push duration - in level (2 bytes) */
.equ v_btnpushtime2, 0xFFFFF792	/* button push duration - in demo (2 bytes) */
.equ v_palchgspeed, 0xFFFFF794	/* palette fade/transition speed (0 is fastest) (2 bytes) */
.equ v_collindex, 0xFFFFF796	/* ROM address for collision index of current level (4 bytes) */
.equ v_palss_num, 0xFFFFF79A	/* palette cycling in Special Stage - reference number (2 bytes) */
.equ v_palss_time, 0xFFFFF79C	/* palette cycling in Special Stage - time until next change (2 bytes) */

.equ v_obj31ypos, 0xFFFFF7A4	/* y-position of object 31 (MZ stomper) (2 bytes) */
.equ v_bossstatus, 0xFFFFF7A7	/* status of boss and prison capsule (01 = boss defeated; 02 = prison opened) */
.equ v_trackpos, 0xFFFFF7A8	/* position tracking reference number (2 bytes) */
.equ v_trackbyte, 0xFFFFF7A9	/* low byte for position tracking */
.equ f_lockscreen, 0xFFFFF7AA	/* flag set to lock screen during bosses */
.equ v_256loop1, 0xFFFFF7AC	/* 256x256 level tile which contains a loop (GHZ/SLZ) */
.equ v_256loop2, 0xFFFFF7AD	/* 256x256 level tile which contains a loop (GHZ/SLZ) */
.equ v_256roll1, 0xFFFFF7AE	/* 256x256 level tile which contains a roll tunnel (GHZ) */
.equ v_256roll2, 0xFFFFF7AF	/* 256x256 level tile which contains a roll tunnel (GHZ) */
.equ v_lani0_frame, 0xFFFFF7B0	/* level graphics animation 0 - current frame */
.equ v_lani0_time, 0xFFFFF7B1	/* level graphics animation 0 - time until next frame */
.equ v_lani1_frame, 0xFFFFF7B2	/* level graphics animation 1 - current frame */
.equ v_lani1_time, 0xFFFFF7B3	/* level graphics animation 1 - time until next frame */
.equ v_lani2_frame, 0xFFFFF7B4	/* level graphics animation 2 - current frame */
.equ v_lani2_time, 0xFFFFF7B5	/* level graphics animation 2 - time until next frame */
.equ v_lani3_frame, 0xFFFFF7B6	/* level graphics animation 3 - current frame */
.equ v_lani3_time, 0xFFFFF7B7	/* level graphics animation 3 - time until next frame */
.equ v_lani4_frame, 0xFFFFF7B8	/* level graphics animation 4 - current frame */
.equ v_lani4_time, 0xFFFFF7B9	/* level graphics animation 4 - time until next frame */
.equ v_lani5_frame, 0xFFFFF7BA	/* level graphics animation 5 - current frame */
.equ v_lani5_time, 0xFFFFF7BB	/* level graphics animation 5 - time until next frame */
.equ v_gfxbigring, 0xFFFFF7BE	/* settings for giant ring graphics loading (2 bytes) */
.equ f_conveyrev, 0xFFFFF7C0	/* flag set to reverse conveyor belts in LZ/SBZ */
.equ v_obj63, 0xFFFFF7C1	/* object 63 (LZ/SBZ platforms) variables (6 bytes) */
.equ f_wtunnelmode, 0xFFFFF7C7	/* LZ water tunnel mode */
.equ f_lockmulti, 0xFFFFF7C8	/* flag set to lock controls, lock Sonic's position & animation */
.equ f_wtunnelallow, 0xFFFFF7C9	/* LZ water tunnels (00 = enabled; 01 = disabled) */
.equ f_jumponly, 0xFFFFF7CA	/* flag set to lock controls apart from jumping */
.equ v_obj6B, 0xFFFFF7CB	/* object 6B (SBZ stomper) variable */
.equ f_lockctrl, 0xFFFFF7CC	/* flag set to lock controls during ending sequence */
.equ f_bigring, 0xFFFFF7CD	/* flag set when Sonic collects the giant ring */
.equ v_itembonus, 0xFFFFF7D0	/* item bonus from broken enemies, blocks etc. (2 bytes) */
.equ v_timebonus, 0xFFFFF7D2	/* time bonus at the end of an act (2 bytes) */
.equ v_ringbonus, 0xFFFFF7D4	/* ring bonus at the end of an act (2 bytes) */
.equ f_endactbonus, 0xFFFFF7D6	/* time/ring bonus update flag at the end of an act */
.equ v_sonicend, 0xFFFFF7D7	/* routine counter for Sonic in the ending sequence */
.equ f_switch, 0xFFFFF7E0	/* flags set when Sonic stands on a switch ($10 bytes) */

.equ v_spritetablebuffer, 0xFFFFF800 /* sprite table ($280 bytes, last $80 bytes are overwritten by v_pal_water_dup) */
.equ v_pal_water_dup, 0xFFFFFA00 /* duplicate underwater palette, used for transitions ($80 bytes) */
.equ v_pal_water, 0xFFFFFA80	/* main underwater palette ($80 bytes) */
.equ v_pal_dry, 0xFFFFFB00	/* main palette ($80 bytes) */
.equ v_pal_dry_dup, 0xFFFFFB80	/* duplicate palette, used for transitions ($80 bytes) */
.equ v_objstate, 0xFFFFFC00	/* object state list ($200 bytes) */
.equ f_restart, 0xFFFFFE02	/* restart level flag (2 bytes) */
.equ v_framecount, 0xFFFFFE04	/* frame counter (adds 1 every frame) (2 bytes) */
.equ v_framebyte, v_framecount+1/* low byte for frame counter */
.equ v_debugitem, 0xFFFFFE06	/* debug item currently selected (NOT the object number of the item) */
.equ v_debuguse, 0xFFFFFE08	/* debug mode use & routine counter (when Sonic is a ring/item) (2 bytes) */
.equ v_debugxspeed, 0xFFFFFE0A	/* debug mode - horizontal speed */
.equ v_debugyspeed, 0xFFFFFE0B	/* debug mode - vertical speed */
.equ v_vbla_count, 0xFFFFFE0C	/* vertical interrupt counter (adds 1 every VBlank) (4 bytes) */
.equ v_vbla_word, v_vbla_count+2 /* low word for vertical interrupt counter (2 bytes) */
.equ v_vbla_byte, v_vbla_word+1	/* low byte for vertical interrupt counter */
.equ v_zone, 0xFFFFFE10	/* current zone number */
.equ v_act, 0xFFFFFE11	/* current act number */
.equ v_lives, 0xFFFFFE12	/* number of lives */
.equ v_air, 0xFFFFFE14	/* air remaining while underwater (2 bytes) */
.equ v_airbyte, v_air+1	/* low byte for air */
.equ v_lastspecial, 0xFFFFFE16	/* last special stage number */
.equ v_continues, 0xFFFFFE18	/* number of continues */
.equ f_timeover, 0xFFFFFE1A	/* time over flag */
.equ v_lifecount, 0xFFFFFE1B	/* lives counter value (for actual number, see "v_lives") */
.equ f_lifecount, 0xFFFFFE1C	/* lives counter update flag */
.equ f_ringcount, 0xFFFFFE1D	/* ring counter update flag */
.equ f_timecount, 0xFFFFFE1E	/* time counter update flag */
.equ f_scorecount, 0xFFFFFE1F	/* score counter update flag */
.equ v_rings, 0xFFFFFE20	/* rings (2 bytes) */
.equ v_ringbyte, v_rings+1	/* low byte for rings */
.equ v_time, 0xFFFFFE22	/* time (4 bytes) */
.equ v_timemin, 0xFFFFFE23	/* time - minutes */
.equ v_timesec, 0xFFFFFE24	/* time - seconds */
.equ v_timecent, 0xFFFFFE25	/* time - centiseconds */
.equ v_score, 0xFFFFFE26	/* score (4 bytes) */
.equ v_shield, 0xFFFFFE2C	/* shield status (00 = no; 01 = yes) */
.equ v_invinc, 0xFFFFFE2D	/* invinciblity status (00 = no; 01 = yes) */
.equ v_shoes, 0xFFFFFE2E	/* speed shoes status (00 = no; 01 = yes) */
.equ v_lastlamp, 0xFFFFFE30	/* number of the last lamppost you hit */
.equ v_lamp_xpos, v_lastlamp+2	/* x-axis for Sonic to respawn at lamppost (2 bytes) */
.equ v_lamp_ypos, v_lastlamp+4	/* y-axis for Sonic to respawn at lamppost (2 bytes) */
.equ v_lamp_rings, v_lastlamp+6	/* rings stored at lamppost (2 bytes) */
.equ v_lamp_time, v_lastlamp+8	/* time stored at lamppost (2 bytes) */
.equ v_lamp_dle, v_lastlamp+0xC	/* dynamic level event routine counter at lamppost */
.equ v_lamp_limitbtm, v_lastlamp+0xE	/* level bottom boundary at lamppost (2 bytes) */
.equ v_lamp_scrx, v_lastlamp+0x10 /* x-axis screen at lamppost (2 bytes) */
.equ v_lamp_scry, v_lastlamp+0x12 /* y-axis screen at lamppost (2 bytes) */

.equ v_lamp_wtrpos, v_lastlamp+0x20 /* water position at lamppost (2 bytes) */
.equ v_lamp_wtrrout, v_lastlamp+0x22 /* water routine at lamppost */
.equ v_lamp_wtrstat, v_lastlamp+0x23 /* water state at lamppost */
.equ v_lamp_lives, v_lastlamp+0x24 /* lives counter at lamppost */
.equ v_emeralds, 0xFFFFFE57	/* number of chaos emeralds */
.equ v_emldlist, 0xFFFFFE58	/* which individual emeralds you have (00 = no; 01 = yes) (6 bytes) */
.equ v_oscillate, 0xFFFFFE5E	/* values which oscillate - for swinging platforms, et al ($42 bytes) */
.equ v_ani0_time, 0xFFFFFEC0	/* synchronised sprite animation 0 - time until next frame (used for synchronised animations) */
.equ v_ani0_frame, 0xFFFFFEC1	/* synchronised sprite animation 0 - current frame */
.equ v_ani1_time, 0xFFFFFEC2	/* synchronised sprite animation 1 - time until next frame */
.equ v_ani1_frame, 0xFFFFFEC3	/* synchronised sprite animation 1 - current frame */
.equ v_ani2_time, 0xFFFFFEC4	/* synchronised sprite animation 2 - time until next frame */
.equ v_ani2_frame, 0xFFFFFEC5	/* synchronised sprite animation 2 - current frame */
.equ v_ani3_time, 0xFFFFFEC6	/* synchronised sprite animation 3 - time until next frame */
.equ v_ani3_frame, 0xFFFFFEC7	/* synchronised sprite animation 3 - current frame */
.equ v_ani3_buf, 0xFFFFFEC8	/* synchronised sprite animation 3 - info buffer (2 bytes) */
.equ v_limittopdb, 0xFFFFFEF0	/* level upper boundary, buffered for debug mode (2 bytes) */
.equ v_limitbtmdb, 0xFFFFFEF2	/* level bottom boundary, buffered for debug mode (2 bytes) */

.equ v_levseldelay, 0xFFFFFF80	/* level select - time until change when up/down is held (2 bytes) */
.equ v_levselitem, 0xFFFFFF82	/* level select - item selected (2 bytes) */
.equ v_levselsound, 0xFFFFFF84	/* level select - sound selected (2 bytes) */
.equ v_scorecopy, 0xFFFFFFC0	/* score, duplicate (4 bytes) */
.equ v_scorelife, 0xFFFFFFC0	/* points required for an extra life (4 bytes) (JP1 only) */
.equ f_levselcheat, 0xFFFFFFE0	/* level select cheat flag */
.equ f_slomocheat, 0xFFFFFFE1	/* slow motion & frame advance cheat flag */
.equ f_debugcheat, 0xFFFFFFE2	/* debug mode cheat flag */
.equ f_creditscheat, 0xFFFFFFE3	/* hidden credits & press start cheat flag */
.equ v_title_dcount, 0xFFFFFFE4	/* number of times the d-pad is pressed on title screen (2 bytes) */
.equ v_title_ccount, 0xFFFFFFE6	/* number of times C is pressed on title screen (2 bytes) */

.equ f_demo, 0xFFFFFFF0	/* demo mode flag (0 = no; 1 = yes; $8001 = ending) (2 bytes) */
.equ v_demonum, 0xFFFFFFF2	/* demo level number (not the same as the level number) (2 bytes) */
.equ v_creditsnum, 0xFFFFFFF4	/* credits index number (2 bytes) */
.equ v_megadrive, 0xFFFFFFF8	/* Megadrive machine type */
.equ f_debugmode, 0xFFFFFFFA	/* debug mode flag (sometimes 2 bytes) */
.equ v_init, 0xFFFFFFFC	/* 'init' text string (4 bytes) */

