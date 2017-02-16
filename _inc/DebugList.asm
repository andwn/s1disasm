# ---------------------------------------------------------------------------
# Debug	mode item lists
# ---------------------------------------------------------------------------
DebugList:
	dc.w 1-DebugList
	dc.w 2-DebugList
	dc.w 3-DebugList
	dc.w 4-DebugList
	dc.w 5-DebugList
	dc.w 6-DebugList
	dc.w 7-DebugList
#	zonewarning DebugList,2

.macro dbug map,object,subtype,frame,vram
	dc.l \map+(\object<<24)
	dc.b \subtype,\frame
	dc.w \vram
.endm

1:
	dc.w (2-2-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Crab,	id_Crabmeat,	0,	0,	0x400
	dbug	Map_Buzz,	id_BuzzBomber,	0,	0,	0x444
	dbug	Map_Chop,	id_Chopper,	0,	0,	0x47B
	dbug	Map_Spike,	id_Spikes,	0,	0,	0x51B
	dbug	Map_Plat_GHZ,	id_BasicPlatform, 0,	0,	0x4000
	dbug	Map_PRock,	id_PurpleRock,	0,	0,	0x63D0
	dbug	Map_Moto,	id_MotoBug,	0,	0,	0x4F0
	dbug	Map_Spring,	id_Springs,	0,	0,	0x523
	dbug	Map_Newt,	id_Newtron,	0,	0,	0x249B
	dbug	Map_Edge,	id_EdgeWalls,	0,	0,	0x434C
	dbug	Map_GBall,	id_Obj19,	0,	0,	0x43AA
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	dbug	Map_GRing,	id_GiantRing,	0,	0,	0x2400
	dbug	Map_Bonus,	id_HiddenBonus,	1,	1,	0x84B6
	2:

3:
	dc.w (4-4-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Spring,	id_Springs,	0,	0,	0x523
	dbug	Map_Jaws,	id_Jaws,	8,	0,	0x2486
	dbug	Map_Burro,	id_Burrobot,	0,	2,	0x84A6
	dbug	Map_Harp,	id_Harpoon,	0,	0,	0x3CC
	dbug	Map_Harp,	id_Harpoon,	2,	3,	0x3CC
	dbug	Map_Push,	id_PushBlock,	0,	0,	0x43DE
	dbug	Map_But,	id_Button,	0,	0,	0x513
	dbug	Map_Spike,	id_Spikes,	0,	0,	0x51B
	dbug	Map_MBlockLZ,	id_MovingBlock,	4,	0,	0x43BC
	dbug	Map_LBlock,	id_LabyrinthBlock, 1,	0,	0x43E6
	dbug	Map_LBlock,	id_LabyrinthBlock, 0x13,	1,	0x43E6
	dbug	Map_LBlock,	id_LabyrinthBlock, 5,	0,	0x43E6
	dbug	Map_Gar,	id_Gargoyle,	0,	0,	0x443E
	dbug	Map_LBlock,	id_LabyrinthBlock, 0x27,	2,	0x43E6
	dbug	Map_LBlock,	id_LabyrinthBlock, 0x30,	3,	0x43E6
	dbug	Map_LConv,	id_LabyrinthConvey, 0x7F, 0,	0x3F6
	dbug	Map_Orb,	id_Orbinaut,	0,	0,	0x467
	dbug	Map_Bub,	id_Bubble,	0x84,	0x13,	0x8348
	dbug	Map_WFall,	id_Waterfall,	2,	2,	0xC259
	dbug	Map_WFall,	id_Waterfall,	9,	9,	0xC259
	dbug	Map_Pole,	id_Pole,	0,	0,	0x43DE
	dbug	Map_Flap,	id_FlapDoor,	2,	0,	0x4328
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	4:

5:
	dc.w (6-6-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Buzz,	id_BuzzBomber,	0,	0,	0x444
	dbug	Map_Spike,	id_Spikes,	0,	0,	0x51B
	dbug	Map_Spring,	id_Springs,	0,	0,	0x523
	dbug	Map_Fire,	id_LavaMaker,	0,	0,	0x345
	dbug	Map_Brick,	id_MarbleBrick,	0,	0,	0x4000
	dbug	Map_Geyser,	id_GeyserMaker,	0,	0,	0x63A8
	dbug	Map_LWall,	id_LavaWall,	0,	0,	0x63A8
	dbug	Map_Push,	id_PushBlock,	0,	0,	0x42B8
	dbug	Map_Yad,	id_Yadrin,	0,	0,	0x247B
	dbug	Map_Smab,	id_SmashBlock,	0,	0,	0x42B8
	dbug	Map_MBlock,	id_MovingBlock,	0,	0,	0x2B8
	dbug	Map_CFlo,	id_CollapseFloor, 0,	0,	0x62B8
	dbug	Map_LTag,	id_LavaTag,	0,	0,	0x8680
	dbug	Map_Bas,	id_Basaran,	0,	0,	0x4B8
	dbug	Map_Cat,	id_Caterkiller,	0,	0,	0x24FF
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	6:

7:
	dc.w (8-8-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Elev,	id_Elevator,	0,	0,	0x4000
	dbug	Map_CFlo,	id_CollapseFloor, 0,	2,	0x44E0
	dbug	Map_Plat_SLZ,	id_BasicPlatform, 0,	0,	0x4000
	dbug	Map_Circ,	id_CirclingPlatform, 0,	0,	0x4000
	dbug	Map_Stair,	id_Staircase,	0,	0,	0x4000
	dbug	Map_Fan,	id_Fan,		0,	0,	0x43A0
	dbug	Map_Seesaw,	id_Seesaw,	0,	0,	0x374
	dbug	Map_Spring,	id_Springs,	0,	0,	0x523
	dbug	Map_Fire,	id_LavaMaker,	0,	0,	0x480
	dbug	Map_Scen,	id_Scenery,	0,	0,	0x44D8
	dbug	Map_Bomb,	id_Bomb,	0,	0,	0x400
	dbug	Map_Orb,	id_Orbinaut,	0,	0,	0x2429
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	8:

9:
	dc.w (10-10-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Spike,	id_Spikes,	0,	0,	0x51B
	dbug	Map_Spring,	id_Springs,	0,	0,	0x523
	dbug	Map_Roll,	id_Roller,	0,	0,	0x4B8
	dbug	Map_Light,	id_SpinningLight, 0,	0,	0
	dbug	Map_Bump,	id_Bumper,	0,	0,	0x380
	dbug	Map_Crab,	id_Crabmeat,	0,	0,	0x400
	dbug	Map_Buzz,	id_BuzzBomber,	0,	0,	0x444
	dbug	Map_Yad,	id_Yadrin,	0,	0,	0x247B
	dbug	Map_Plat_SYZ,	id_BasicPlatform, 0,	0,	0x4000
	dbug	Map_FBlock,	id_FloatingBlock, 0,	0,	0x4000
	dbug	Map_But,	id_Button,	0,	0,	0x513
	dbug	Map_Cat,	id_Caterkiller,	0,	0,	0x24FF
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	10:

11:
	dc.w (12-12-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	dbug	Map_Monitor,	id_Monitor,	0,	0,	0x680
	dbug	Map_Bomb,	id_Bomb,	0,	0,	0x400
	dbug	Map_Orb,	id_Orbinaut,	0,	0,	0x429
	dbug	Map_Cat,	id_Caterkiller,	0,	0,	0x22B0
	dbug	Map_BBall,	id_SwingingPlatform, 7,	2,	0x4391
	dbug	Map_Disc,	id_RunningDisc,	0xE0,	0,	0xC344
	dbug	Map_MBlock,	id_MovingBlock,	0x28,	2,	0x22C0
	dbug	Map_But,	id_Button,	0,	0,	0x513
	dbug	Map_Trap,	id_SpinPlatform, 3,	0,	0x4492
	dbug	Map_Spin,	id_SpinPlatform, 0x83,	0,	0x4DF
	dbug	Map_Saw,	id_Saws,	2,	0,	0x43B5
	dbug	Map_CFlo,	id_CollapseFloor, 0,	0,	0x43F5
	dbug	Map_MBlock,	id_MovingBlock,	0x39,	3,	0x4460
	dbug	Map_Stomp,	id_ScrapStomp,	0,	0,	0x22C0
	dbug	Map_ADoor,	id_AutoDoor,	0,	0,	0x42E8
	dbug	Map_Stomp,	id_ScrapStomp,	0x13,	1,	0x22C0
	dbug	Map_Saw,	id_Saws,	1,	0,	0x43B5
	dbug	Map_Stomp,	id_ScrapStomp,	0x24,	1,	0x22C0
	dbug	Map_Saw,	id_Saws,	4,	2,	0x43B5
	dbug	Map_Stomp,	id_ScrapStomp,	0x34,	1,	0x22C0
	dbug	Map_VanP,	id_VanishPlatform, 0,	0,	0x44C3
	dbug	Map_Flame,	id_Flamethrower, 0x64,	0,	0x83D9
	dbug	Map_Flame,	id_Flamethrower, 0x64,	0xB,	0x83D9
	dbug	Map_Elec,	id_Electro,	4,	0,	0x47E
	dbug	Map_Gird,	id_Girder,	0,	0,	0x42F0
	dbug	Map_Invis,	id_Invisibarrier, 0x11,	0,	0x8680
	dbug	Map_Hog,	id_BallHog,	4,	0,	0x2302
	dbug	Map_Lamp,	id_Lamppost,	1,	0,	0x7A0
	12:

13:
	dc.w (14-14-2)/8

#		mappings	object		subtype	frame	VRAM setting
	dbug	Map_Ring,	id_Rings,	0,	0,	0x27B2
	.if Revision==0
	dbug	Map_Bump,	id_Bumper,	0,	0,	0x380
	dbug	Map_Animal2,	id_Animals,	0xA,	0,	0x5A0
	dbug	Map_Animal2,	id_Animals,	0xB,	0,	0x5A0
	dbug	Map_Animal2,	id_Animals,	0xC,	0,	0x5A0
	dbug	Map_Animal1,	id_Animals,	0xD,	0,	0x553
	dbug	Map_Animal1,	id_Animals,	0xE,	0,	0x553
	dbug	Map_Animal1,	id_Animals,	0xF,	0,	0x573
	dbug	Map_Animal1,	id_Animals,	0x10,	0,	0x573
	dbug	Map_Animal2,	id_Animals,	0x11,	0,	0x585
	dbug	Map_Animal3,	id_Animals,	0x12,	0,	0x593
	dbug	Map_Animal2,	id_Animals,	0x13,	0,	0x565
	dbug	Map_Animal3,	id_Animals,	0x14,	0,	0x5B3
	.else
	dbug	Map_Ring,	id_Rings,	0,	8,	0x27B2
	.endc
	14:

	.align 2

