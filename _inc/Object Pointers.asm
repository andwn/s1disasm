# ---------------------------------------------------------------------------
# Object pointers
# ---------------------------------------------------------------------------
ptr_SonicPlayer:	dc.l SonicPlayer	/* $01 */
ptr_Obj02:		dc.l NullObject
ptr_Obj03:		dc.l NullObject
ptr_Obj04:		dc.l NullObject
ptr_Obj05:		dc.l NullObject
ptr_Obj06:		dc.l NullObject
ptr_Obj07:		dc.l NullObject
ptr_Splash:		dc.l Splash		/* $08 */
ptr_SonicSpecial:	dc.l SonicSpecial
ptr_DrownCount:		dc.l DrownCount
ptr_Pole:		dc.l Pole
ptr_FlapDoor:		dc.l FlapDoor
ptr_Signpost:		dc.l Signpost
ptr_TitleSonic:		dc.l TitleSonic
ptr_PSBTM:		dc.l PSBTM
ptr_Obj10:		dc.l Obj10		/* $10 */
ptr_Bridge:		dc.l Bridge
ptr_SpinningLight:	dc.l SpinningLight
ptr_LavaMaker:		dc.l LavaMaker
ptr_LavaBall:		dc.l LavaBall
ptr_SwingingPlatform:	dc.l SwingingPlatform
ptr_Harpoon:		dc.l Harpoon
ptr_Helix:		dc.l Helix
ptr_BasicPlatform:	dc.l BasicPlatform	/* $18 */
ptr_Obj19:		dc.l Obj19
ptr_CollapseLedge:	dc.l CollapseLedge
ptr_WaterSurface:	dc.l WaterSurface
ptr_Scenery:		dc.l Scenery
ptr_MagicSwitch:	dc.l MagicSwitch
ptr_BallHog:		dc.l BallHog
ptr_Crabmeat:		dc.l Crabmeat
ptr_Cannonball:		dc.l Cannonball		/* $20 */
ptr_HUD:		dc.l HUD
ptr_BuzzBomber:		dc.l BuzzBomber
ptr_Missile:		dc.l Missile
ptr_MissileDissolve:	dc.l MissileDissolve
ptr_Rings:		dc.l Rings
ptr_Monitor:		dc.l Monitor
ptr_ExplosionItem:	dc.l ExplosionItem
ptr_Animals:		dc.l Animals		/* $28 */
ptr_Points:		dc.l Points
ptr_AutoDoor:		dc.l AutoDoor
ptr_Chopper:		dc.l Chopper
ptr_Jaws:		dc.l Jaws
ptr_Burrobot:		dc.l Burrobot
ptr_PowerUp:		dc.l PowerUp
ptr_LargeGrass:		dc.l LargeGrass
ptr_GlassBlock:		dc.l GlassBlock		/* $30 */
ptr_ChainStomp:		dc.l ChainStomp
ptr_Button:		dc.l Button
ptr_PushBlock:		dc.l PushBlock
ptr_TitleCard:		dc.l TitleCard
ptr_GrassFire:		dc.l GrassFire
ptr_Spikes:		dc.l Spikes
ptr_RingLoss:		dc.l RingLoss
ptr_ShieldItem:		dc.l ShieldItem		/* $38 */
ptr_GameOverCard:	dc.l GameOverCard
ptr_GotThroughCard:	dc.l GotThroughCard
ptr_PurpleRock:		dc.l PurpleRock
ptr_SmashWall:		dc.l SmashWall
ptr_BossGreenHill:	dc.l BossGreenHill
ptr_Prison:		dc.l Prison
ptr_ExplosionBomb:	dc.l ExplosionBomb
ptr_MotoBug:		dc.l MotoBug		/* $40 */
ptr_Springs:		dc.l Springs
ptr_Newtron:		dc.l Newtron
ptr_Roller:		dc.l Roller
ptr_EdgeWalls:		dc.l EdgeWalls
ptr_SideStomp:		dc.l SideStomp
ptr_MarbleBrick:	dc.l MarbleBrick
ptr_Bumper:		dc.l Bumper
ptr_BossBall:		dc.l BossBall		/* $48 */
ptr_WaterSound:		dc.l WaterSound
ptr_VanishSonic:	dc.l VanishSonic
ptr_GiantRing:		dc.l GiantRing
ptr_GeyserMaker:	dc.l GeyserMaker
ptr_LavaGeyser:		dc.l LavaGeyser
ptr_LavaWall:		dc.l LavaWall
ptr_Obj4F:		dc.l Obj4F
ptr_Yadrin:		dc.l Yadrin		/* $50 */
ptr_SmashBlock:		dc.l SmashBlock
ptr_MovingBlock:	dc.l MovingBlock
ptr_CollapseFloor:	dc.l CollapseFloor
ptr_LavaTag:		dc.l LavaTag
ptr_Basaran:		dc.l Basaran
ptr_FloatingBlock:	dc.l FloatingBlock
ptr_SpikeBall:		dc.l SpikeBall
ptr_BigSpikeBall:	dc.l BigSpikeBall	/* $58 */
ptr_Elevator:		dc.l Elevator
ptr_CirclingPlatform:	dc.l CirclingPlatform
ptr_Staircase:		dc.l Staircase
ptr_Pylon:		dc.l Pylon
ptr_Fan:		dc.l Fan
ptr_Seesaw:		dc.l Seesaw
ptr_Bomb:		dc.l Bomb
ptr_Orbinaut:		dc.l Orbinaut		/* $60 */
ptr_LabyrinthBlock:	dc.l LabyrinthBlock
ptr_Gargoyle:		dc.l Gargoyle
ptr_LabyrinthConvey:	dc.l LabyrinthConvey
ptr_Bubble:		dc.l Bubble
ptr_Waterfall:		dc.l Waterfall
ptr_Junction:		dc.l Junction
ptr_RunningDisc:	dc.l RunningDisc
ptr_Conveyor:		dc.l Conveyor		/* $68 */
ptr_SpinPlatform:	dc.l SpinPlatform
ptr_Saws:		dc.l Saws
ptr_ScrapStomp:		dc.l ScrapStomp
ptr_VanishPlatform:	dc.l VanishPlatform
ptr_Flamethrower:	dc.l Flamethrower
ptr_Electro:		dc.l Electro
ptr_SpinConvey:		dc.l SpinConvey
ptr_Girder:		dc.l Girder		/* $70 */
ptr_Invisibarrier:	dc.l Invisibarrier
ptr_Teleport:		dc.l Teleport
ptr_BossMarble:		dc.l BossMarble
ptr_BossFire:		dc.l BossFire
ptr_BossSpringYard:	dc.l BossSpringYard
ptr_BossBlock:		dc.l BossBlock
ptr_BossLabyrinth:	dc.l BossLabyrinth
ptr_Caterkiller:	dc.l Caterkiller	/* $78 */
ptr_Lamppost:		dc.l Lamppost
ptr_BossStarLight:	dc.l BossStarLight
ptr_BossSpikeball:	dc.l BossSpikeball
ptr_RingFlash:		dc.l RingFlash
ptr_HiddenBonus:	dc.l HiddenBonus
ptr_SSResult:		dc.l SSResult
ptr_SSRChaos:		dc.l SSRChaos
ptr_ContScrItem:	dc.l ContScrItem	/* $80 */
ptr_ContSonic:		dc.l ContSonic
ptr_ScrapEggman:	dc.l ScrapEggman
ptr_FalseFloor:		dc.l FalseFloor
ptr_EggmanCylinder:	dc.l EggmanCylinder
ptr_BossFinal:		dc.l BossFinal
ptr_BossPlasma:		dc.l BossPlasma
ptr_EndSonic:		dc.l EndSonic
ptr_EndChaos:		dc.l EndChaos		/* $88 */
ptr_EndSTH:		dc.l EndSTH
ptr_CreditsText:	dc.l CreditsText
ptr_EndEggman:		dc.l EndEggman
ptr_TryChaos:		dc.l TryChaos

NullObject:
#		jmp	(DeleteObject).l	; It would be safer to have this instruction here, but instead it just falls through to ObjectFall

.equ id_SonicPlayer, ((ptr_SonicPlayer-Obj_Index)/4)+1		/* $01 */
.equ id_Obj02, ((ptr_Obj02-Obj_Index)/4)+1
.equ id_Obj03, ((ptr_Obj03-Obj_Index)/4)+1
.equ id_Obj04, ((ptr_Obj04-Obj_Index)/4)+1
.equ id_Obj05, ((ptr_Obj05-Obj_Index)/4)+1
.equ id_Obj06, ((ptr_Obj06-Obj_Index)/4)+1
.equ id_Obj07, ((ptr_Obj07-Obj_Index)/4)+1
.equ id_Splash, ((ptr_Splash-Obj_Index)/4)+1		/* $08 */
.equ id_SonicSpecial, ((ptr_SonicSpecial-Obj_Index)/4)+1
.equ id_DrownCount, ((ptr_DrownCount-Obj_Index)/4)+1
.equ id_Pole, ((ptr_Pole-Obj_Index)/4)+1
.equ id_FlapDoor, ((ptr_FlapDoor-Obj_Index)/4)+1
.equ id_Signpost, ((ptr_Signpost-Obj_Index)/4)+1
.equ id_TitleSonic, ((ptr_TitleSonic-Obj_Index)/4)+1
.equ id_PSBTM, ((ptr_PSBTM-Obj_Index)/4)+1
.equ id_Obj10, ((ptr_Obj10-Obj_Index)/4)+1			/* $10 */
.equ id_Bridge, ((ptr_Bridge-Obj_Index)/4)+1
.equ id_SpinningLight, ((ptr_SpinningLight-Obj_Index)/4)+1
.equ id_LavaMaker, ((ptr_LavaMaker-Obj_Index)/4)+1
.equ id_LavaBall, ((ptr_LavaBall-Obj_Index)/4)+1
.equ id_SwingingPlatform, ((ptr_SwingingPlatform-Obj_Index)/4)+1
.equ id_Harpoon, ((ptr_Harpoon-Obj_Index)/4)+1
.equ id_Helix, ((ptr_Helix-Obj_Index)/4)+1
.equ id_BasicPlatform, ((ptr_BasicPlatform-Obj_Index)/4)+1		/* $18 */
.equ id_Obj19, ((ptr_Obj19-Obj_Index)/4)+1
.equ id_CollapseLedge, ((ptr_CollapseLedge-Obj_Index)/4)+1
.equ id_WaterSurface, ((ptr_WaterSurface-Obj_Index)/4)+1
.equ id_Scenery, ((ptr_Scenery-Obj_Index)/4)+1
.equ id_MagicSwitch, ((ptr_MagicSwitch-Obj_Index)/4)+1
.equ id_BallHog, ((ptr_BallHog-Obj_Index)/4)+1
.equ id_Crabmeat, ((ptr_Crabmeat-Obj_Index)/4)+1
.equ id_Cannonball, ((ptr_Cannonball-Obj_Index)/4)+1		/* $20 */
.equ id_HUD, ((ptr_HUD-Obj_Index)/4)+1
.equ id_BuzzBomber, ((ptr_BuzzBomber-Obj_Index)/4)+1
.equ id_Missile, ((ptr_Missile-Obj_Index)/4)+1
.equ id_MissileDissolve, ((ptr_MissileDissolve-Obj_Index)/4)+1
.equ id_Rings, ((ptr_Rings-Obj_Index)/4)+1
.equ id_Monitor, ((ptr_Monitor-Obj_Index)/4)+1
.equ id_ExplosionItem, ((ptr_ExplosionItem-Obj_Index)/4)+1
.equ id_Animals, ((ptr_Animals-Obj_Index)/4)+1		/* $28 */
.equ id_Points, ((ptr_Points-Obj_Index)/4)+1
.equ id_AutoDoor, ((ptr_AutoDoor-Obj_Index)/4)+1
.equ id_Chopper, ((ptr_Chopper-Obj_Index)/4)+1
.equ id_Jaws, ((ptr_Jaws-Obj_Index)/4)+1
.equ id_Burrobot, ((ptr_Burrobot-Obj_Index)/4)+1
.equ id_PowerUp, ((ptr_PowerUp-Obj_Index)/4)+1
.equ id_LargeGrass, ((ptr_LargeGrass-Obj_Index)/4)+1
.equ id_GlassBlock, ((ptr_GlassBlock-Obj_Index)/4)+1		/* $30 */
.equ id_ChainStomp, ((ptr_ChainStomp-Obj_Index)/4)+1
.equ id_Button, ((ptr_Button-Obj_Index)/4)+1
.equ id_PushBlock, ((ptr_PushBlock-Obj_Index)/4)+1
.equ id_TitleCard, ((ptr_TitleCard-Obj_Index)/4)+1
.equ id_GrassFire, ((ptr_GrassFire-Obj_Index)/4)+1
.equ id_Spikes, ((ptr_Spikes-Obj_Index)/4)+1
.equ id_RingLoss, ((ptr_RingLoss-Obj_Index)/4)+1
.equ id_ShieldItem, ((ptr_ShieldItem-Obj_Index)/4)+1		/* $38 */
.equ id_GameOverCard, ((ptr_GameOverCard-Obj_Index)/4)+1
.equ id_GotThroughCard, ((ptr_GotThroughCard-Obj_Index)/4)+1
.equ id_PurpleRock, ((ptr_PurpleRock-Obj_Index)/4)+1
.equ id_SmashWall, ((ptr_SmashWall-Obj_Index)/4)+1
.equ id_BossGreenHill, ((ptr_BossGreenHill-Obj_Index)/4)+1
.equ id_Prison, ((ptr_Prison-Obj_Index)/4)+1
.equ id_ExplosionBomb, ((ptr_ExplosionBomb-Obj_Index)/4)+1
.equ id_MotoBug, ((ptr_MotoBug-Obj_Index)/4)+1		/* $40 */
.equ id_Springs, ((ptr_Springs-Obj_Index)/4)+1
.equ id_Newtron, ((ptr_Newtron-Obj_Index)/4)+1
.equ id_Roller, ((ptr_Roller-Obj_Index)/4)+1
.equ id_EdgeWalls, ((ptr_EdgeWalls-Obj_Index)/4)+1
.equ id_SideStomp, ((ptr_SideStomp-Obj_Index)/4)+1
.equ id_MarbleBrick, ((ptr_MarbleBrick-Obj_Index)/4)+1
.equ id_Bumper, ((ptr_Bumper-Obj_Index)/4)+1
.equ id_BossBall, ((ptr_BossBall-Obj_Index)/4)+1		/* $48 */
.equ id_WaterSound, ((ptr_WaterSound-Obj_Index)/4)+1
.equ id_VanishSonic, ((ptr_VanishSonic-Obj_Index)/4)+1
.equ id_GiantRing, ((ptr_GiantRing-Obj_Index)/4)+1
.equ id_GeyserMaker, ((ptr_GeyserMaker-Obj_Index)/4)+1
.equ id_LavaGeyser, ((ptr_LavaGeyser-Obj_Index)/4)+1
.equ id_LavaWall, ((ptr_LavaWall-Obj_Index)/4)+1
.equ id_Obj4F, ((ptr_Obj4F-Obj_Index)/4)+1
.equ id_Yadrin, ((ptr_Yadrin-Obj_Index)/4)+1		/* $50 */
.equ id_SmashBlock, ((ptr_SmashBlock-Obj_Index)/4)+1
.equ id_MovingBlock, ((ptr_MovingBlock-Obj_Index)/4)+1
.equ id_CollapseFloor, ((ptr_CollapseFloor-Obj_Index)/4)+1
.equ id_LavaTag, ((ptr_LavaTag-Obj_Index)/4)+1
.equ id_Basaran, ((ptr_Basaran-Obj_Index)/4)+1
.equ id_FloatingBlock, ((ptr_FloatingBlock-Obj_Index)/4)+1
.equ id_SpikeBall, ((ptr_SpikeBall-Obj_Index)/4)+1
.equ id_BigSpikeBall, ((ptr_BigSpikeBall-Obj_Index)/4)+1		/* $58 */
.equ id_Elevator, ((ptr_Elevator-Obj_Index)/4)+1
.equ id_CirclingPlatform, ((ptr_CirclingPlatform-Obj_Index)/4)+1
.equ id_Staircase, ((ptr_Staircase-Obj_Index)/4)+1
.equ id_Pylon, ((ptr_Pylon-Obj_Index)/4)+1
.equ id_Fan, ((ptr_Fan-Obj_Index)/4)+1
.equ id_Seesaw, ((ptr_Seesaw-Obj_Index)/4)+1
.equ id_Bomb, ((ptr_Bomb-Obj_Index)/4)+1
.equ id_Orbinaut, ((ptr_Orbinaut-Obj_Index)/4)+1		/* $60 */
.equ id_LabyrinthBlock, ((ptr_LabyrinthBlock-Obj_Index)/4)+1
.equ id_Gargoyle, ((ptr_Gargoyle-Obj_Index)/4)+1
.equ id_LabyrinthConvey, ((ptr_LabyrinthConvey-Obj_Index)/4)+1
.equ id_Bubble, ((ptr_Bubble-Obj_Index)/4)+1
.equ id_Waterfall, ((ptr_Waterfall-Obj_Index)/4)+1
.equ id_Junction, ((ptr_Junction-Obj_Index)/4)+1
.equ id_RunningDisc, ((ptr_RunningDisc-Obj_Index)/4)+1
.equ id_Conveyor, ((ptr_Conveyor-Obj_Index)/4)+1		/* $68 */
.equ id_SpinPlatform, ((ptr_SpinPlatform-Obj_Index)/4)+1
.equ id_Saws, ((ptr_Saws-Obj_Index)/4)+1
.equ id_ScrapStomp, ((ptr_ScrapStomp-Obj_Index)/4)+1
.equ id_VanishPlatform, ((ptr_VanishPlatform-Obj_Index)/4)+1
.equ id_Flamethrower, ((ptr_Flamethrower-Obj_Index)/4)+1
.equ id_Electro, ((ptr_Electro-Obj_Index)/4)+1
.equ id_SpinConvey, ((ptr_SpinConvey-Obj_Index)/4)+1
.equ id_Girder, ((ptr_Girder-Obj_Index)/4)+1		/* $70 */
.equ id_Invisibarrier, ((ptr_Invisibarrier-Obj_Index)/4)+1
.equ id_Teleport, ((ptr_Teleport-Obj_Index)/4)+1
.equ id_BossMarble, ((ptr_BossMarble-Obj_Index)/4)+1
.equ id_BossFire, ((ptr_BossFire-Obj_Index)/4)+1
.equ id_BossSpringYard, ((ptr_BossSpringYard-Obj_Index)/4)+1
.equ id_BossBlock, ((ptr_BossBlock-Obj_Index)/4)+1
.equ id_BossLabyrinth, ((ptr_BossLabyrinth-Obj_Index)/4)+1
.equ id_Caterkiller, ((ptr_Caterkiller-Obj_Index)/4)+1		/* $78 */
.equ id_Lamppost, ((ptr_Lamppost-Obj_Index)/4)+1
.equ id_BossStarLight, ((ptr_BossStarLight-Obj_Index)/4)+1
.equ id_BossSpikeball, ((ptr_BossSpikeball-Obj_Index)/4)+1
.equ id_RingFlash, ((ptr_RingFlash-Obj_Index)/4)+1
.equ id_HiddenBonus, ((ptr_HiddenBonus-Obj_Index)/4)+1
.equ id_SSResult, ((ptr_SSResult-Obj_Index)/4)+1
.equ id_SSRChaos, ((ptr_SSRChaos-Obj_Index)/4)+1
.equ id_ContScrItem, ((ptr_ContScrItem-Obj_Index)/4)+1		/* $80 */
.equ id_ContSonic, ((ptr_ContSonic-Obj_Index)/4)+1
.equ id_ScrapEggman, ((ptr_ScrapEggman-Obj_Index)/4)+1
.equ id_FalseFloor, ((ptr_FalseFloor-Obj_Index)/4)+1
.equ id_EggmanCylinder, ((ptr_EggmanCylinder-Obj_Index)/4)+1
.equ id_BossFinal, ((ptr_BossFinal-Obj_Index)/4)+1
.equ id_BossPlasma, ((ptr_BossPlasma-Obj_Index)/4)+1
.equ id_EndSonic, ((ptr_EndSonic-Obj_Index)/4)+1
.equ id_EndChaos, ((ptr_EndChaos-Obj_Index)/4)+1		/* $88 */
.equ id_EndSTH, ((ptr_EndSTH-Obj_Index)/4)+1
.equ id_CreditsText, ((ptr_CreditsText-Obj_Index)/4)+1
.equ id_EndEggman, ((ptr_EndEggman-Obj_Index)/4)+1
.equ id_TryChaos, ((ptr_TryChaos-Obj_Index)/4)+1
