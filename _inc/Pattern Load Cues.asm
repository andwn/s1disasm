# ---------------------------------------------------------------------------
# Pattern load cues
# ---------------------------------------------------------------------------
ArtLoadCues:

ptr_PLC_Main:		dc.w PLC_Main-ArtLoadCues
ptr_PLC_Main2:		dc.w PLC_Main2-ArtLoadCues
ptr_PLC_Explode:	dc.w PLC_Explode-ArtLoadCues
ptr_PLC_GameOver:	dc.w PLC_GameOver-ArtLoadCues
PLC_Levels:
ptr_PLC_GHZ:		dc.w PLC_GHZ-ArtLoadCues
ptr_PLC_GHZ2:		dc.w PLC_GHZ2-ArtLoadCues
ptr_PLC_LZ:		dc.w PLC_LZ-ArtLoadCues
ptr_PLC_LZ2:		dc.w PLC_LZ2-ArtLoadCues
ptr_PLC_MZ:		dc.w PLC_MZ-ArtLoadCues
ptr_PLC_MZ2:		dc.w PLC_MZ2-ArtLoadCues
ptr_PLC_SLZ:		dc.w PLC_SLZ-ArtLoadCues
ptr_PLC_SLZ2:		dc.w PLC_SLZ2-ArtLoadCues
ptr_PLC_SYZ:		dc.w PLC_SYZ-ArtLoadCues
ptr_PLC_SYZ2:		dc.w PLC_SYZ2-ArtLoadCues
ptr_PLC_SBZ:		dc.w PLC_SBZ-ArtLoadCues
ptr_PLC_SBZ2:		dc.w PLC_SBZ2-ArtLoadCues
#			zonewarningnoending PLC_Levels,4
ptr_PLC_TitleCard:	dc.w PLC_TitleCard-ArtLoadCues
ptr_PLC_Boss:		dc.w PLC_Boss-ArtLoadCues
ptr_PLC_Signpost:	dc.w PLC_Signpost-ArtLoadCues
ptr_PLC_Warp:		dc.w PLC_Warp-ArtLoadCues
ptr_PLC_SpecialStage:	dc.w PLC_SpecialStage-ArtLoadCues
PLC_Animals:
ptr_PLC_GHZAnimals:	dc.w PLC_GHZAnimals-ArtLoadCues
ptr_PLC_LZAnimals:	dc.w PLC_LZAnimals-ArtLoadCues
ptr_PLC_MZAnimals:	dc.w PLC_MZAnimals-ArtLoadCues
ptr_PLC_SLZAnimals:	dc.w PLC_SLZAnimals-ArtLoadCues
ptr_PLC_SYZAnimals:	dc.w PLC_SYZAnimals-ArtLoadCues
ptr_PLC_SBZAnimals:	dc.w PLC_SBZAnimals-ArtLoadCues
#			zonewarningnoending PLC_Animals,2
ptr_PLC_SSResult:	dc.w PLC_SSResult-ArtLoadCues
ptr_PLC_Ending:		dc.w PLC_Ending-ArtLoadCues
ptr_PLC_TryAgain:	dc.w PLC_TryAgain-ArtLoadCues
ptr_PLC_EggmanSBZ2:	dc.w PLC_EggmanSBZ2-ArtLoadCues
ptr_PLC_FZBoss:		dc.w PLC_FZBoss-ArtLoadCues

.macro plcm gfx,vram
	dc.l \gfx
	dc.w \vram
.endm

# ---------------------------------------------------------------------------
# Pattern load cues - standard block 1
# ---------------------------------------------------------------------------
PLC_Main:	dc.w ((PLC_Mainend-PLC_Main-2)/6)-1
		plcm	Nem_Lamp, 0xF400		/* lamppost */
		plcm	Nem_Hud, 0xD940		/* HUD */
		plcm	Nem_Lives, 0xFA80	/* lives	counter */
		plcm	Nem_Ring, 0xF640 	/* rings */
		plcm	Nem_Points, 0xF2E0	/* points from enemy */
	PLC_Mainend:
# ---------------------------------------------------------------------------
# Pattern load cues - standard block 2
# ---------------------------------------------------------------------------
PLC_Main2:	dc.w ((PLC_Main2end-PLC_Main2-2)/6)-1
		plcm	Nem_Monitors, 0xD000	/* monitors */
		plcm	Nem_Shield, 0xA820	/* shield */
		plcm	Nem_Stars, 0xAB80	/* invincibility	stars */
	PLC_Main2end:
# ---------------------------------------------------------------------------
# Pattern load cues - explosion
# ---------------------------------------------------------------------------
PLC_Explode:	dc.w ((PLC_Explodeend-PLC_Explode-2)/6)-1
		plcm	Nem_Explode, 0xB400	/* explosion */
	PLC_Explodeend:
# ---------------------------------------------------------------------------
# Pattern load cues - game/time	over
# ---------------------------------------------------------------------------
PLC_GameOver:	dc.w ((PLC_GameOverend-PLC_GameOver-2)/6)-1
		plcm	Nem_GameOver, 0xABC0	/* game/time over */
	PLC_GameOverend:
# ---------------------------------------------------------------------------
# Pattern load cues - Green Hill
# ---------------------------------------------------------------------------
PLC_GHZ:	dc.w ((PLC_GHZ2-PLC_GHZ-2)/6)-1
		plcm	Nem_GHZ_1st, 0		/* GHZ main patterns */
		plcm	Nem_GHZ_2nd, 0x39A0	/* GHZ secondary	patterns */
		plcm	Nem_Stalk, 0x6B00	/* flower stalk */
		plcm	Nem_PplRock, 0x7A00	/* purple rock */
		plcm	Nem_Crabmeat, 0x8000	/* crabmeat enemy */
		plcm	Nem_Buzz, 0x8880		/* buzz bomber enemy */
		plcm	Nem_Chopper, 0x8F60	/* chopper enemy */
		plcm	Nem_Newtron, 0x9360	/* newtron enemy */
		plcm	Nem_Motobug, 0x9E00	/* motobug enemy */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */

PLC_GHZ2:	dc.w ((PLC_GHZ2end-PLC_GHZ2-2)/6)-1
		plcm	Nem_Swing, 0x7000	/* swinging platform */
		plcm	Nem_Bridge, 0x71C0	/* bridge */
		plcm	Nem_SpikePole, 0x7300	/* spiked pole */
		plcm	Nem_Ball, 0x7540		/* giant	ball */
		plcm	Nem_GhzWall1, 0xA1E0	/* breakable wall */
		plcm	Nem_GhzWall2, 0x6980	/* normal wall */
	PLC_GHZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - Labyrinth
# ---------------------------------------------------------------------------
PLC_LZ:		dc.w ((PLC_LZ2-PLC_LZ-2)/6)-1
		plcm	Nem_LZ,0		/* LZ main patterns */
		plcm	Nem_LzBlock1, 0x3C00	/* block */
		plcm	Nem_LzBlock2, 0x3E00	/* blocks */
		plcm	Nem_Splash, 0x4B20	/* waterfalls and splash */
		plcm	Nem_Water, 0x6000	/* water	surface */
		plcm	Nem_LzSpikeBall, 0x6200	/* spiked ball */
		plcm	Nem_FlapDoor, 0x6500	/* flapping door */
		plcm	Nem_Bubbles, 0x6900	/* bubbles and numbers */
		plcm	Nem_LzBlock3, 0x7780	/* block */
		plcm	Nem_LzDoor1, 0x7880	/* vertical door */
		plcm	Nem_Harpoon, 0x7980	/* harpoon */
		plcm	Nem_Burrobot, 0x94C0	/* burrobot enemy */

PLC_LZ2:	dc.w ((PLC_LZ2end-PLC_LZ2-2)/6)-1
		plcm	Nem_LzPole, 0x7BC0	/* pole that breaks */
		plcm	Nem_LzDoor2, 0x7CC0	/* large	horizontal door */
		plcm	Nem_LzWheel, 0x7EC0	/* wheel */
		plcm	Nem_Gargoyle, 0x5D20	/* gargoyle head */
		.if Revision==0
		plcm	Nem_LzSonic, 0x8800	/* Sonic	holding	his breath */
		.else
		.endc
		plcm	Nem_LzPlatfm, 0x89E0	/* rising platform */
		plcm	Nem_Orbinaut, 0x8CE0	/* orbinaut enemy */
		plcm	Nem_Jaws, 0x90C0		/* jaws enemy */
		plcm	Nem_LzSwitch, 0xA1E0	/* switch */
		plcm	Nem_Cork, 0xA000		/* cork block */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */
	PLC_LZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - Marble
# ---------------------------------------------------------------------------
PLC_MZ:		dc.w ((PLC_MZ2-PLC_MZ-2)/6)-1
		plcm	Nem_MZ,0		/* MZ main patterns */
		plcm	Nem_MzMetal, 0x6000	/* metal	blocks */
		plcm	Nem_MzFire, 0x68A0	/* fireballs */
		plcm	Nem_Swing, 0x7000	/* swinging platform */
		plcm	Nem_MzGlass, 0x71C0	/* green	glassy block */
		plcm	Nem_Lava, 0x7500		/* lava */
		plcm	Nem_Buzz, 0x8880		/* buzz bomber enemy */
		plcm	Nem_Yadrin, 0x8F60	/* yadrin enemy */
		plcm	Nem_Basaran, 0x9700	/* basaran enemy */
		plcm	Nem_Cater, 0x9FE0	/* caterkiller enemy */

PLC_MZ2:	dc.w ((PLC_MZ2end-PLC_MZ2-2)/6)-1
		plcm	Nem_MzSwitch, 0xA260	/* switch */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */
		plcm	Nem_MzBlock, 0x5700	/* green	stone block */
	PLC_MZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - Star Light
# ---------------------------------------------------------------------------
PLC_SLZ:	dc.w ((PLC_SLZ2-PLC_SLZ-2)/6)-1
		plcm	Nem_SLZ,0		/* SLZ main patterns */
		plcm	Nem_Bomb, 0x8000		/* bomb enemy */
		plcm	Nem_Orbinaut, 0x8520	/* orbinaut enemy */
		plcm	Nem_MzFire, 0x9000	/* fireballs */
		plcm	Nem_SlzBlock, 0x9C00	/* block */
		plcm	Nem_SlzWall, 0xA260	/* breakable wall */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */

PLC_SLZ2:	dc.w ((PLC_SLZ2end-PLC_SLZ2-2)/6)-1
		plcm	Nem_Seesaw, 0x6E80	/* seesaw */
		plcm	Nem_Fan, 0x7400		/* fan */
		plcm	Nem_Pylon, 0x7980	/* foreground pylon */
		plcm	Nem_SlzSwing, 0x7B80	/* swinging platform */
		plcm	Nem_SlzCannon, 0x9B00	/* fireball launcher */
		plcm	Nem_SlzSpike, 0x9E00	/* spikeball */
	PLC_SLZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - Spring Yard
# ---------------------------------------------------------------------------
PLC_SYZ:	dc.w ((PLC_SYZ2-PLC_SYZ-2)/6)-1
		plcm	Nem_SYZ,0		/* SYZ main patterns */
		plcm	Nem_Crabmeat, 0x8000	/* crabmeat enemy */
		plcm	Nem_Buzz, 0x8880		/* buzz bomber enemy */
		plcm	Nem_Yadrin, 0x8F60	/* yadrin enemy */
		plcm	Nem_Roller, 0x9700	/* roller enemy */

PLC_SYZ2:	dc.w ((PLC_SYZ2end-PLC_SYZ2-2)/6)-1
		plcm	Nem_Bumper, 0x7000	/* bumper */
		plcm	Nem_SyzSpike1, 0x72C0	/* large	spikeball */
		plcm	Nem_SyzSpike2, 0x7740	/* small	spikeball */
		plcm	Nem_Cater, 0x9FE0	/* caterkiller enemy */
		plcm	Nem_LzSwitch, 0xA1E0	/* switch */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */
	PLC_SYZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - Scrap Brain
# ---------------------------------------------------------------------------
PLC_SBZ:	dc.w ((PLC_SBZ2-PLC_SBZ-2)/6)-1
		plcm	Nem_SBZ,0		/* SBZ main patterns */
		plcm	Nem_Stomper, 0x5800	/* moving platform and stomper */
		plcm	Nem_SbzDoor1, 0x5D00	/* door */
		plcm	Nem_Girder, 0x5E00	/* girder */
		plcm	Nem_BallHog, 0x6040	/* ball hog enemy */
		plcm	Nem_SbzWheel1, 0x6880	/* spot on large	wheel */
		plcm	Nem_SbzWheel2, 0x6900	/* wheel	that grabs Sonic */
		plcm	Nem_SyzSpike1, 0x7220	/* large	spikeball */
		plcm	Nem_Cutter, 0x76A0	/* pizza	cutter */
		plcm	Nem_FlamePipe, 0x7B20	/* flaming pipe */
		plcm	Nem_SbzFloor, 0x7EA0	/* collapsing floor */
		plcm	Nem_SbzBlock, 0x9860	/* vanishing block */

PLC_SBZ2:	dc.w ((PLC_SBZ2end-PLC_SBZ2-2)/6)-1
		plcm	Nem_Cater, 0x5600	/* caterkiller enemy */
		plcm	Nem_Bomb, 0x8000		/* bomb enemy */
		plcm	Nem_Orbinaut, 0x8520	/* orbinaut enemy */
		plcm	Nem_SlideFloor, 0x8C00	/* floor	that slides away */
		plcm	Nem_SbzDoor2, 0x8DE0	/* horizontal door */
		plcm	Nem_Electric, 0x8FC0	/* electric orb */
		plcm	Nem_TrapDoor, 0x9240	/* trapdoor */
		plcm	Nem_SbzFloor, 0x7F20	/* collapsing floor */
		plcm	Nem_SpinPform, 0x9BE0	/* small	spinning platform */
		plcm	Nem_LzSwitch, 0xA1E0	/* switch */
		plcm	Nem_Spikes, 0xA360	/* spikes */
		plcm	Nem_HSpring, 0xA460	/* horizontal spring */
		plcm	Nem_VSpring, 0xA660	/* vertical spring */
	PLC_SBZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - title card
# ---------------------------------------------------------------------------
PLC_TitleCard:	dc.w ((PLC_TitleCardend-PLC_TitleCard-2)/6)-1
		plcm	Nem_TitleCard, 0xB000
	PLC_TitleCardend:
# ---------------------------------------------------------------------------
# Pattern load cues - act 3 boss
# ---------------------------------------------------------------------------
PLC_Boss:	dc.w ((PLC_Bossend-PLC_Boss-2)/6)-1
		plcm	Nem_Eggman, 0x8000	/* Eggman main patterns */
		plcm	Nem_Weapons, 0x8D80	/* Eggman's weapons */
		plcm	Nem_Prison, 0x93A0	/* prison capsule */
		plcm	Nem_Bomb, 0xA300		/* bomb enemy ((gets overwritten) */
		plcm	Nem_SlzSpike, 0xA300	/* spikeball ((SLZ boss) */
		plcm	Nem_Exhaust, 0xA540	/* exhaust flame */
	PLC_Bossend:
# ---------------------------------------------------------------------------
# Pattern load cues - act 1/2 signpost
# ---------------------------------------------------------------------------
PLC_Signpost:	dc.w ((PLC_Signpostend-PLC_Signpost-2)/6)-1
		plcm	Nem_SignPost, 0xD000	/* signpost */
		plcm	Nem_Bonus, 0x96C0	/* hidden bonus points */
		plcm	Nem_BigFlash, 0x8C40	/* giant	ring flash effect */
	PLC_Signpostend:
# ---------------------------------------------------------------------------
# Pattern load cues - beta special stage warp effect
# ---------------------------------------------------------------------------
PLC_Warp:
		.if Revision==0
		dc.w ((PLC_Warpend-PLC_Warp-2)/6)-1
		plcm	Nem_Warp, 0xA820
		.else
		.endc
	PLC_Warpend:
# ---------------------------------------------------------------------------
# Pattern load cues - special stage
# ---------------------------------------------------------------------------
PLC_SpecialStage:	dc.w ((PLC_SpeStageend-PLC_SpecialStage-2)/6)-1
		plcm	Nem_SSBgCloud, 0	/* bubble and cloud background */
		plcm	Nem_SSBgFish, 0xA20	/* bird and fish	background */
		plcm	Nem_SSWalls, 0x2840	/* walls */
		plcm	Nem_Bumper, 0x4760	/* bumper */
		plcm	Nem_SSGOAL, 0x4A20	/* GOAL block */
		plcm	Nem_SSUpDown, 0x4C60	/* UP and DOWN blocks */
		plcm	Nem_SSRBlock, 0x5E00	/* R block */
		plcm	Nem_SS1UpBlock, 0x6E00	/* 1UP block */
		plcm	Nem_SSEmStars, 0x7E00	/* emerald collection stars */
		plcm	Nem_SSRedWhite, 0x8E00	/* red and white	block */
		plcm	Nem_SSGhost, 0x9E00	/* ghost	block */
		plcm	Nem_SSWBlock, 0xAE00	/* W block */
		plcm	Nem_SSGlass, 0xBE00	/* glass	block */
		plcm	Nem_SSEmerald, 0xEE00	/* emeralds */
		plcm	Nem_SSZone1, 0xF2E0	/* ZONE 1 block */
		plcm	Nem_SSZone2, 0xF400	/* ZONE 2 block */
		plcm	Nem_SSZone3, 0xF520	/* ZONE 3 block */
	PLC_SpeStageend:
		plcm	Nem_SSZone4, 0xF2E0	/* ZONE 4 block */
		plcm	Nem_SSZone5, 0xF400	/* ZONE 5 block */
		plcm	Nem_SSZone6, 0xF520	/* ZONE 6 block */
# ---------------------------------------------------------------------------
# Pattern load cues - GHZ animals
# ---------------------------------------------------------------------------
PLC_GHZAnimals:	dc.w ((PLC_GHZAnimalsend-PLC_GHZAnimals-2)/6)-1
		plcm	Nem_Rabbit, 0xB000	/* rabbit */
		plcm	Nem_Flicky, 0xB240	/* flicky */
	PLC_GHZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - LZ animals
# ---------------------------------------------------------------------------
PLC_LZAnimals:	dc.w ((PLC_LZAnimalsend-PLC_LZAnimals-2)/6)-1
		plcm	Nem_BlackBird, 0xB000	/* blackbird */
		plcm	Nem_Seal, 0xB240		/* seal */
	PLC_LZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - MZ animals
# ---------------------------------------------------------------------------
PLC_MZAnimals:	dc.w ((PLC_MZAnimalsend-PLC_MZAnimals-2)/6)-1
		plcm	Nem_Squirrel, 0xB000	/* squirrel */
		plcm	Nem_Seal, 0xB240		/* seal */
	PLC_MZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - SLZ animals
# ---------------------------------------------------------------------------
PLC_SLZAnimals:	dc.w ((PLC_SLZAnimalsend-PLC_SLZAnimals-2)/6)-1
		plcm	Nem_Pig, 0xB000		/* pig */
		plcm	Nem_Flicky, 0xB240	/* flicky */
	PLC_SLZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - SYZ animals
# ---------------------------------------------------------------------------
PLC_SYZAnimals:	dc.w ((PLC_SYZAnimalsend-PLC_SYZAnimals-2)/6)-1
		plcm	Nem_Pig, 0xB000		/* pig */
		plcm	Nem_Chicken, 0xB240	/* chicken */
	PLC_SYZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - SBZ animals
# ---------------------------------------------------------------------------
PLC_SBZAnimals:	dc.w ((PLC_SBZAnimalsend-PLC_SBZAnimals-2)/6)-1
		plcm	Nem_Rabbit, 0xB000		/* rabbit */
		plcm	Nem_Chicken, 0xB240	/* chicken */
	PLC_SBZAnimalsend:
# ---------------------------------------------------------------------------
# Pattern load cues - special stage results screen
# ---------------------------------------------------------------------------
PLC_SSResult:dc.w ((PLC_SpeStResultend-PLC_SSResult-2)/6)-1
		plcm	Nem_ResultEm, 0xA820	/* emeralds */
		plcm	Nem_MiniSonic, 0xAA20	/* mini Sonic */
	PLC_SpeStResultend:
# ---------------------------------------------------------------------------
# Pattern load cues - ending sequence
# ---------------------------------------------------------------------------
PLC_Ending:	dc.w ((PLC_Endingend-PLC_Ending-2)/6)-1
		plcm	Nem_GHZ_1st,0		/* GHZ main patterns */
		plcm	Nem_GHZ_2nd, 0x39A0	/* GHZ secondary	patterns */
		plcm	Nem_Stalk, 0x6B00	/* flower stalk */
		plcm	Nem_EndFlower, 0x7400	/* flowers */
		plcm	Nem_EndEm, 0x78A0	/* emeralds */
		plcm	Nem_EndSonic, 0x7C20	/* Sonic */
		.if Revision==0
		plcm	Nem_EndEggman, 0xA480	/* Eggman's death ((unused) */
		.else
		.endc
		plcm	Nem_Rabbit, 0xAA60	/* rabbit */
		plcm	Nem_Chicken, 0xACA0	/* chicken */
		plcm	Nem_BlackBird, 0xAE60	/* blackbird */
		plcm	Nem_Seal, 0xB0A0		/* seal */
		plcm	Nem_Pig, 0xB260		/* pig */
		plcm	Nem_Flicky, 0xB4A0	/* flicky */
		plcm	Nem_Squirrel, 0xB660	/* squirrel */
		plcm	Nem_EndStH, 0xB8A0	/* "SONIC THE HEDGEHOG" */
	PLC_Endingend:
# ---------------------------------------------------------------------------
# Pattern load cues - "TRY AGAIN" and "END" screens
# ---------------------------------------------------------------------------
PLC_TryAgain:	dc.w ((PLC_TryAgainend-PLC_TryAgain-2)/6)-1
		plcm	Nem_EndEm, 0x78A0	/* emeralds */
		plcm	Nem_TryAgain, 0x7C20	/* Eggman */
		plcm	Nem_CreditText, 0xB400	/* credits alphabet */
	PLC_TryAgainend:
# ---------------------------------------------------------------------------
# Pattern load cues - Eggman on SBZ 2
# ---------------------------------------------------------------------------
PLC_EggmanSBZ2:	dc.w ((PLC_EggmanSBZ2end-PLC_EggmanSBZ2-2)/6)-1
		plcm	Nem_SbzBlock, 0xA300	/* block */
		plcm	Nem_Sbz2Eggman, 0x8000	/* Eggman */
		plcm	Nem_LzSwitch, 0x9400	/* switch */
	PLC_EggmanSBZ2end:
# ---------------------------------------------------------------------------
# Pattern load cues - final boss
# ---------------------------------------------------------------------------
PLC_FZBoss:	dc.w ((PLC_FZBossend-PLC_FZBoss-2)/6)-1
		plcm	Nem_FzEggman, 0x7400	/* Eggman after boss */
		plcm	Nem_FzBoss, 0x6000	/* FZ boss */
		plcm	Nem_Eggman, 0x8000	/* Eggman main patterns */
		plcm	Nem_Sbz2Eggman, 0x8E00	/* Eggman without ship */
		plcm	Nem_Exhaust, 0xA540	/* exhaust flame */
	PLC_FZBossend:
		.align 2

# ---------------------------------------------------------------------------
# Pattern load cue IDs
# ---------------------------------------------------------------------------
.equ plcid_Main, (ptr_PLC_Main-ArtLoadCues)/2	/* 0 */
.equ plcid_Main2, (ptr_PLC_Main2-ArtLoadCues)/2	/* 1 */
.equ plcid_Explode, (ptr_PLC_Explode-ArtLoadCues)/2	/* 2 */
.equ plcid_GameOver, (ptr_PLC_GameOver-ArtLoadCues)/2	/* 3 */
.equ plcid_GHZ, (ptr_PLC_GHZ-ArtLoadCues)/2		/* 4 */
.equ plcid_GHZ2, (ptr_PLC_GHZ2-ArtLoadCues)/2	/* 5 */
.equ plcid_LZ, (ptr_PLC_LZ-ArtLoadCues)/2		/* 6 */
.equ plcid_LZ2, (ptr_PLC_LZ2-ArtLoadCues)/2		/* 7 */
.equ plcid_MZ, (ptr_PLC_MZ-ArtLoadCues)/2		/* 8 */
.equ plcid_MZ2, (ptr_PLC_MZ2-ArtLoadCues)/2		/* 9 */
.equ plcid_SLZ, (ptr_PLC_SLZ-ArtLoadCues)/2		/* $A */
.equ plcid_SLZ2, (ptr_PLC_SLZ2-ArtLoadCues)/2	/* $B */
.equ plcid_SYZ, (ptr_PLC_SYZ-ArtLoadCues)/2		/* $C */
.equ plcid_SYZ2, (ptr_PLC_SYZ2-ArtLoadCues)/2	/* $D */
.equ plcid_SBZ, (ptr_PLC_SBZ-ArtLoadCues)/2		/* $E */
.equ plcid_SBZ2, (ptr_PLC_SBZ2-ArtLoadCues)/2	/* $F */
.equ plcid_TitleCard, (ptr_PLC_TitleCard-ArtLoadCues)/2	/* $10 */
.equ plcid_Boss, (ptr_PLC_Boss-ArtLoadCues)/2	/* $11 */
.equ plcid_Signpost, (ptr_PLC_Signpost-ArtLoadCues)/2	/* $12 */
.equ plcid_Warp, (ptr_PLC_Warp-ArtLoadCues)/2	/* $13 */
.equ plcid_SpecialStage, (ptr_PLC_SpecialStage-ArtLoadCues)/2 /* $14 */
.equ plcid_GHZAnimals, (ptr_PLC_GHZAnimals-ArtLoadCues)/2	/* $15 */
.equ plcid_LZAnimals, (ptr_PLC_LZAnimals-ArtLoadCues)/2	/* $16 */
.equ plcid_MZAnimals, (ptr_PLC_MZAnimals-ArtLoadCues)/2	/* $17 */
.equ plcid_SLZAnimals, (ptr_PLC_SLZAnimals-ArtLoadCues)/2	/* $18 */
.equ plcid_SYZAnimals, (ptr_PLC_SYZAnimals-ArtLoadCues)/2	/* $19 */
.equ plcid_SBZAnimals, (ptr_PLC_SBZAnimals-ArtLoadCues)/2	/* $1A */
.equ plcid_SSResult, (ptr_PLC_SSResult-ArtLoadCues)/2	/* $1B */
.equ plcid_Ending, (ptr_PLC_Ending-ArtLoadCues)/2	/* $1C */
.equ plcid_TryAgain, (ptr_PLC_TryAgain-ArtLoadCues)/2	/* $1D */
.equ plcid_EggmanSBZ2, (ptr_PLC_EggmanSBZ2-ArtLoadCues)/2	/* $1E */
.equ plcid_FZBoss, (ptr_PLC_FZBoss-ArtLoadCues)/2	/* $1F */
