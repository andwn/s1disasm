# ---------------------------------------------------------------------------
# Sprite mappings - Sonic
# ---------------------------------------------------------------------------
Map_Sonic:

ptr_MS_Null:	dc.w MS_Null-Map_Sonic
ptr_MS_Stand:	dc.w MS_Stand-Map_Sonic
ptr_MS_Wait1:	dc.w MS_Wait1-Map_Sonic
ptr_MS_Wait2:	dc.w MS_Wait2-Map_Sonic
ptr_MS_Wait3:	dc.w MS_Wait3-Map_Sonic
ptr_MS_LookUp:	dc.w MS_LookUp-Map_Sonic
ptr_MS_Walk11:	dc.w MS_Walk11-Map_Sonic
ptr_MS_Walk12:	dc.w MS_Walk12-Map_Sonic
ptr_MS_Walk13:	dc.w MS_Walk13-Map_Sonic
ptr_MS_Walk14:	dc.w MS_Walk14-Map_Sonic
ptr_MS_Walk15:	dc.w MS_Walk15-Map_Sonic
ptr_MS_Walk16:	dc.w MS_Walk16-Map_Sonic
ptr_MS_Walk21:	dc.w MS_Walk21-Map_Sonic
ptr_MS_Walk22:	dc.w MS_Walk22-Map_Sonic
ptr_MS_Walk23:	dc.w MS_Walk23-Map_Sonic
ptr_MS_Walk24:	dc.w MS_Walk24-Map_Sonic
ptr_MS_Walk25:	dc.w MS_Walk25-Map_Sonic
ptr_MS_Walk26:	dc.w MS_Walk26-Map_Sonic
ptr_MS_Walk31:	dc.w MS_Walk31-Map_Sonic
ptr_MS_Walk32:	dc.w MS_Walk32-Map_Sonic
ptr_MS_Walk33:	dc.w MS_Walk33-Map_Sonic
ptr_MS_Walk34:	dc.w MS_Walk34-Map_Sonic
ptr_MS_Walk35:	dc.w MS_Walk35-Map_Sonic
ptr_MS_Walk36:	dc.w MS_Walk36-Map_Sonic
ptr_MS_Walk41:	dc.w MS_Walk41-Map_Sonic
ptr_MS_Walk42:	dc.w MS_Walk42-Map_Sonic
ptr_MS_Walk43:	dc.w MS_Walk43-Map_Sonic
ptr_MS_Walk44:	dc.w MS_Walk44-Map_Sonic
ptr_MS_Walk45:	dc.w MS_Walk45-Map_Sonic
ptr_MS_Walk46:	dc.w MS_Walk46-Map_Sonic
ptr_MS_Run11:	dc.w MS_Run11-Map_Sonic
ptr_MS_Run12:	dc.w MS_Run12-Map_Sonic
ptr_MS_Run13:	dc.w MS_Run13-Map_Sonic
ptr_MS_Run14:	dc.w MS_Run14-Map_Sonic
ptr_MS_Run21:	dc.w MS_Run21-Map_Sonic
ptr_MS_Run22:	dc.w MS_Run22-Map_Sonic
ptr_MS_Run23:	dc.w MS_Run23-Map_Sonic
ptr_MS_Run24:	dc.w MS_Run24-Map_Sonic
ptr_MS_Run31:	dc.w MS_Run31-Map_Sonic
ptr_MS_Run32:	dc.w MS_Run32-Map_Sonic
ptr_MS_Run33:	dc.w MS_Run33-Map_Sonic
ptr_MS_Run34:	dc.w MS_Run34-Map_Sonic
ptr_MS_Run41:	dc.w MS_Run41-Map_Sonic
ptr_MS_Run42:	dc.w MS_Run42-Map_Sonic
ptr_MS_Run43:	dc.w MS_Run43-Map_Sonic
ptr_MS_Run44:	dc.w MS_Run44-Map_Sonic
ptr_MS_Roll1:	dc.w MS_Roll1-Map_Sonic
ptr_MS_Roll2:	dc.w MS_Roll2-Map_Sonic
ptr_MS_Roll3:	dc.w MS_Roll3-Map_Sonic
ptr_MS_Roll4:	dc.w MS_Roll4-Map_Sonic
ptr_MS_Roll5:	dc.w MS_Roll5-Map_Sonic
ptr_MS_Warp1:	dc.w MS_Warp1-Map_Sonic
ptr_MS_Warp2:	dc.w MS_Warp2-Map_Sonic
ptr_MS_Warp3:	dc.w MS_Warp3-Map_Sonic
ptr_MS_Warp4:	dc.w MS_Warp4-Map_Sonic
ptr_MS_Stop1:	dc.w MS_Stop1-Map_Sonic
ptr_MS_Stop2:	dc.w MS_Stop2-Map_Sonic
ptr_MS_Duck:	dc.w MS_Duck-Map_Sonic
ptr_MS_Balance1:dc.w MS_Balance1-Map_Sonic
ptr_MS_Balance2:dc.w MS_Balance2-Map_Sonic
ptr_MS_Float1:	dc.w MS_Float1-Map_Sonic
ptr_MS_Float2:	dc.w MS_Float2-Map_Sonic
ptr_MS_Float3:	dc.w MS_Float3-Map_Sonic
ptr_MS_Float4:	dc.w MS_Float4-Map_Sonic
ptr_MS_Spring:	dc.w MS_Spring-Map_Sonic
ptr_MS_Hang1:	dc.w MS_Hang1-Map_Sonic
ptr_MS_Hang2:	dc.w MS_Hang2-Map_Sonic
ptr_MS_Leap1:	dc.w MS_Leap1-Map_Sonic
ptr_MS_Leap2:	dc.w MS_Leap2-Map_Sonic
ptr_MS_Push1:	dc.w MS_Push1-Map_Sonic
ptr_MS_Push2:	dc.w MS_Push2-Map_Sonic
ptr_MS_Push3:	dc.w MS_Push3-Map_Sonic
ptr_MS_Push4:	dc.w MS_Push4-Map_Sonic
ptr_MS_Surf:	dc.w MS_Surf-Map_Sonic
ptr_MS_BubStand:dc.w MS_BubStand-Map_Sonic
ptr_MS_Burnt:	dc.w MS_Burnt-Map_Sonic
ptr_MS_Drown:	dc.w MS_Drown-Map_Sonic
ptr_MS_Death:	dc.w MS_Death-Map_Sonic
ptr_MS_Shrink1:	dc.w MS_Shrink1-Map_Sonic
ptr_MS_Shrink2:	dc.w MS_Shrink2-Map_Sonic
ptr_MS_Shrink3:	dc.w MS_Shrink3-Map_Sonic
ptr_MS_Shrink4:	dc.w MS_Shrink4-Map_Sonic
ptr_MS_Shrink5:	dc.w MS_Shrink5-Map_Sonic
ptr_MS_Float5:	dc.w MS_Float5-Map_Sonic
ptr_MS_Float6:	dc.w MS_Float6-Map_Sonic
ptr_MS_Injury:	dc.w MS_Injury-Map_Sonic
ptr_MS_GetAir:	dc.w MS_GetAir-Map_Sonic
ptr_MS_WaterSlide:dc.w MS_WaterSlide-Map_Sonic

MS_Null:	dc.b 0
MS_Stand:	dc.b 4			/* standing */
		dc.b 0xEC, 8, 0,	0, 0xF0
		dc.b 0xF4, 0xD, 0, 3, 0xF0
		dc.b 4,	8, 0, 0xB, 0xF0
		dc.b 0xC, 8, 0, 0xE, 0xF8
MS_Wait1:	dc.b 3			/* waiting 1 */
		dc.b 0xEC, 9, 0,	0, 0xF0
		dc.b 0xFC, 9, 0,	6, 0xF0
		dc.b 0xC, 8, 0, 0xC, 0xF8
MS_Wait2:	dc.b 3			/* waiting 2 */
		dc.b 0xEC, 9, 0,	0, 0xF0
		dc.b 0xFC, 9, 0,	6, 0xF0
		dc.b 0xC, 8, 0, 0xC, 0xF8
MS_Wait3:	dc.b 3			/* waiting 3 */
		dc.b 0xEC, 9, 0,	0, 0xF0
		dc.b 0xFC, 9, 0,	6, 0xF0
		dc.b 0xC, 8, 0, 0xC, 0xF8
MS_LookUp:	dc.b 3			/* looking up */
		dc.b 0xEC, 0xA, 0, 0, 0xF0
		dc.b 4,	8, 0, 9, 0xF0
		dc.b 0xC, 8, 0, 0xC, 0xF8
MS_Walk11:	dc.b 4			/* walking 1-1 */
		dc.b 0xEB, 0xD, 0, 0, 0xEC
		dc.b 0xFB, 9, 0,	8, 0xEC
		dc.b 0xFB, 6, 0,	0xE, 4
		dc.b 0xB, 4, 0, 0x14, 0xEC
MS_Walk12:	dc.b 2			/* walking 1-2 */
		dc.b 0xEC, 0xD, 0, 0, 0xED
		dc.b 0xFC, 0xE, 0, 8, 0xF5
MS_Walk13:	dc.b 2			/* walking 1-3 */
		dc.b 0xED, 9, 0,	0, 0xF3
		dc.b 0xFD, 0xA, 0, 6, 0xF3
MS_Walk14:	dc.b 4			/* walking 1-4 */
		dc.b 0xEB, 9, 0,	0, 0xF4
		dc.b 0xFB, 9, 0,	6, 0xEC
		dc.b 0xFB, 6, 0,	0xC, 4
		dc.b 0xB, 4, 0, 0x12, 0xEC
MS_Walk15:	dc.b 2			/* walking 1-5 */
		dc.b 0xEC, 9, 0,	0, 0xF3
		dc.b 0xFC, 0xE, 0, 6, 0xEB
MS_Walk16:	dc.b 3			/* walking 1-6 */
		dc.b 0xED, 0xD, 0, 0, 0xEC
		dc.b 0xFD, 0xC, 0, 8, 0xF4
		dc.b 5,	9, 0, 0xC, 0xF4
MS_Walk21:	dc.b 5			/* walking 2-1 */
		dc.b 0xEB, 9, 0,	0, 0xEB
		dc.b 0xEB, 6, 0,	6, 3
		dc.b 0xFB, 8, 0,	0xC, 0xEB
		dc.b 3,	9, 0, 0xF, 0xF3
		dc.b 0x13, 0, 0,	0x15, 0xFB
MS_Walk22:	dc.b 6			/* walking 2-2 */
		dc.b 0xEC, 9, 0,	0, 0xEC
		dc.b 0xEC, 1, 0,	6, 4
		dc.b 0xFC, 0xC, 0, 8, 0xEC
		dc.b 4,	9, 0, 0xC, 0xF4
		dc.b 0xFC, 5, 0,	0x12, 0xC
		dc.b 0xF4, 0, 0,	0x16, 0x14
MS_Walk23:	dc.b 4			/* walking 2-3 */
		dc.b 0xED, 9, 0,	0, 0xED
		dc.b 0xED, 1, 0,	6, 5
		dc.b 0xFD, 0xD, 0, 8, 0xF5
		dc.b 0xD, 8, 0, 0x10, 0xFD
MS_Walk24:	dc.b 5			/* walking 2-4 */
		dc.b 0xEB, 9, 0,	0, 0xEB
		dc.b 0xEB, 5, 0,	6, 3
		dc.b 0xFB, 0xD, 0, 0xA, 0xF3
		dc.b 0xB, 8, 0, 0x12, 0xF3
		dc.b 0x13, 4, 0,	0x15, 0xFB
MS_Walk25:	dc.b 4			/* walking 2-5 */
		dc.b 0xEC, 9, 0,	0, 0xEC
		dc.b 0xEC, 1, 0,	6, 4
		dc.b 0xFC, 0xD, 0, 8, 0xF4
		dc.b 0xC, 8, 0, 0x10, 0xFC
MS_Walk26:	dc.b 5			/* walking 2-6 */
		dc.b 0xED, 9, 0,	0, 0xED
		dc.b 0xED, 1, 0,	6, 5
		dc.b 0xFD, 0, 0,	8, 0xED
		dc.b 0xFD, 0xD, 0, 9, 0xF5
		dc.b 0xD, 8, 0, 0x11, 0xFD
MS_Walk31:	dc.b 4			/* walking 3-1 */
		dc.b 0xF4, 7, 0,	0, 0xEB
		dc.b 0xEC, 9, 0,	8, 0xFB
		dc.b 0xFC, 4, 0,	0xE, 0xFB
		dc.b 4,	9, 0, 0x10, 0xFB
MS_Walk32:	dc.b 2			/* walking 3-2 */
		dc.b 0xF4, 7, 0,	0, 0xEC
		dc.b 0xEC, 0xB, 0, 8, 0xFC
MS_Walk33:	dc.b 2			/* walking 3-3 */
		dc.b 0xF4, 6, 0,	0, 0xED
		dc.b 0xF4, 0xA, 0, 6, 0xFD
MS_Walk34:	dc.b 4			/* walking 3-4 */
		dc.b 0xF4, 6, 0,	0, 0xEB
		dc.b 0xEC, 9, 0,	6, 0xFB
		dc.b 0xFC, 4, 0,	0xC, 0xFB
		dc.b 4,	9, 0, 0xE, 0xFB
MS_Walk35:	dc.b 2			/* walking 3-5 */
		dc.b 0xF4, 6, 0,	0, 0xEC
		dc.b 0xF4, 0xB, 0, 6, 0xFC
MS_Walk36:	dc.b 3			/* walking 3-6 */
		dc.b 0xF4, 7, 0,	0, 0xED
		dc.b 0xEC, 0, 0,	8, 0xFD
		dc.b 0xF4, 0xA, 0, 9, 0xFD
MS_Walk41:	dc.b 6			/* walking 4-1 */
		dc.b 0xFD, 6, 0,	0, 0xEB
		dc.b 0xED, 4, 0,	6, 0xF3
		dc.b 0xF5, 4, 0,	8, 0xEB
		dc.b 0xF5, 0xA, 0, 0xA, 0xFB
		dc.b 0xD, 0, 0, 0x13, 0xFB
		dc.b 0xFD, 0, 0,	0x14, 0x13
MS_Walk42:	dc.b 6			/* walking 4-2 */
		dc.b 0xFC, 6, 0,	0, 0xEC
		dc.b 0xE4, 8, 0,	6, 0xF4
		dc.b 0xEC, 4, 0,	9, 0xFC
		dc.b 0xF4, 4, 0,	0xB, 0xEC
		dc.b 0xF4, 0xA, 0, 0xD, 0xFC
		dc.b 0xC, 0, 0, 0x16, 0xFC
MS_Walk43:	dc.b 4			/* walking 4-3 */
		dc.b 0xFB, 6, 0,	0, 0xED
		dc.b 0xF3, 4, 0,	6, 0xED
		dc.b 0xEB, 0xA, 0, 8, 0xFD
		dc.b 3,	4, 0, 0x11, 0xFD
MS_Walk44:	dc.b 5			/* walking 4-4 */
		dc.b 0xFD, 6, 0,	0, 0xEB
		dc.b 0xED, 8, 0,	6, 0xF3
		dc.b 0xF5, 4, 0,	9, 0xEB
		dc.b 0xF5, 0xD, 0, 0xB, 0xFB
		dc.b 5,	8, 0, 0x13, 0xFB
MS_Walk45:	dc.b 4			/* walking 4-5 */
		dc.b 0xFC, 6, 0,	0, 0xEC
		dc.b 0xF4, 4, 0,	6, 0xEC
		dc.b 0xEC, 0xA, 0, 8, 0xFC
		dc.b 4,	4, 0, 0x11, 0xFC
MS_Walk46:	dc.b 5			/* walking 4-6 */
		dc.b 0xFB, 6, 0,	0, 0xED
		dc.b 0xEB, 0xA, 0, 6, 0xFD
		dc.b 0xF3, 4, 0,	0xF, 0xED
		dc.b 3,	4, 0, 0x11, 0xFD
		dc.b 0xB, 0, 0, 0x13, 0xFD
MS_Run11:	dc.b 2			/* running 1-1 */
		dc.b 0xEE, 9, 0,	0, 0xF4
		dc.b 0xFE, 0xE, 0, 6, 0xEC
MS_Run12:	dc.b 2			/* running 1-2 */
		dc.b 0xEE, 9, 0,	0, 0xF4
		dc.b 0xFE, 0xE, 0, 6, 0xEC
MS_Run13:	dc.b 2			/* running 1-3 */
		dc.b 0xEE, 9, 0,	0, 0xF4
		dc.b 0xFE, 0xE, 0, 6, 0xEC
MS_Run14:	dc.b 2			/* running 1-4 */
		dc.b 0xEE, 9, 0,	0, 0xF4
		dc.b 0xFE, 0xE, 0, 6, 0xEC
MS_Run21:	dc.b 4			/* running 2-1 */
		dc.b 0xEE, 9, 0,	0, 0xEE
		dc.b 0xEE, 1, 0,	6, 6
		dc.b 0xFE, 0xE, 0, 8, 0xF6
		dc.b 0xFE, 0, 0,	0x14, 0xEE
MS_Run22:	dc.b 3			/* running 2-2 */
		dc.b 0xEE, 9, 0,	0, 0xEE
		dc.b 0xEE, 1, 0,	6, 6
		dc.b 0xFE, 0xE, 0, 8, 0xF6
MS_Run23:	dc.b 4			/* running 2-3 */
		dc.b 0xEE, 9, 0,	0, 0xEE
		dc.b 0xEE, 1, 0,	6, 6
		dc.b 0xFE, 0xE, 0, 8, 0xF6
		dc.b 0xFE, 0, 0,	0x14, 0xEE
MS_Run24:	dc.b 3			/* running 2-4 */
		dc.b 0xEE, 9, 0,	0, 0xEE
		dc.b 0xEE, 1, 0,	6, 6
		dc.b 0xFE, 0xE, 0, 8, 0xF6
MS_Run31:	dc.b 2			/* running 3-1 */
		dc.b 0xF4, 6, 0,	0, 0xEE
		dc.b 0xF4, 0xB, 0, 6, 0xFE
MS_Run32:	dc.b 2			/* running 3-2 */
		dc.b 0xF4, 6, 0,	0, 0xEE
		dc.b 0xF4, 0xB, 0, 6, 0xFE
MS_Run33:	dc.b 2			/* running 3-3 */
		dc.b 0xF4, 6, 0,	0, 0xEE
		dc.b 0xF4, 0xB, 0, 6, 0xFE
MS_Run34:	dc.b 2			/* running 3-4 */
		dc.b 0xF4, 6, 0,	0, 0xEE
		dc.b 0xF4, 0xB, 0, 6, 0xFE
MS_Run41:	dc.b 4			/* running 4-1 */
		dc.b 0xFA, 6, 0,	0, 0xEE
		dc.b 0xF2, 4, 0,	6, 0xEE
		dc.b 0xEA, 0xB, 0, 8, 0xFE
		dc.b 0xA, 0, 0, 0x14, 0xFE
MS_Run42:	dc.b 2			/* running 4-2 */
		dc.b 0xF2, 7, 0,	0, 0xEE
		dc.b 0xEA, 0xB, 0, 8, 0xFE
MS_Run43:	dc.b 4			/* running 4-3 */
		dc.b 0xFA, 6, 0,	0, 0xEE
		dc.b 0xF2, 4, 0,	6, 0xEE
		dc.b 0xEA, 0xB, 0, 8, 0xFE
		dc.b 0xA, 0, 0, 0x14, 0xFE
MS_Run44:	dc.b 2			/* running 4-4 */
		dc.b 0xF2, 7, 0,	0, 0xEE
		dc.b 0xEA, 0xB, 0, 8, 0xFE
MS_Roll1:	dc.b 1			/* rolling 1 */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Roll2:	dc.b 1			/* rolling 2 */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Roll3:	dc.b 1			/* rolling 3 */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Roll4:	dc.b 1			/* rolling 4 */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Roll5:	dc.b 1			/* rolling 5 */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Warp1:	dc.b 2			/* warped 1 (unused) */
		dc.b 0xF4, 0xE, 0, 0, 0xEC
		dc.b 0xF4, 2, 0,	0xC, 0xC
MS_Warp2:	dc.b 1			/* warped 2 (unused) */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Warp3:	dc.b 2			/* warped 3 (unused) */
		dc.b 0xEC, 0xB, 0, 0, 0xF4
		dc.b 0xC, 8, 0, 0xC, 0xF4
MS_Warp4:	dc.b 1			/* warped 4 (unused) */
		dc.b 0xF0, 0xF, 0, 0, 0xF0
MS_Stop1:	dc.b 2			/* stopping 1 */
		dc.b 0xED, 9, 0,	0, 0xF0
		dc.b 0xFD, 0xE, 0, 6, 0xF0
MS_Stop2:	dc.b 4			/* stopping 2 */
		dc.b 0xED, 9, 0,	0, 0xF0
		dc.b 0xFD, 0xD, 0, 6, 0xF0
		dc.b 0xD, 4, 0, 0xE, 0
		dc.b 5,	0, 0, 0x10, 0xE8
MS_Duck:	dc.b 4			/* ducking */
		dc.b 0xF4, 4, 0,	0, 0xFC
		dc.b 0xFC, 0xD, 0, 2, 0xF4
		dc.b 0xC, 8, 0, 0xA, 0xF4
		dc.b 4,	0, 0, 0xD, 0xEC
MS_Balance1:	dc.b 3			/* balancing 1 */
		dc.b 0xEC, 8, 8,	0, 0xE8
		dc.b 0xF4, 2, 8,	3, 0
		dc.b 0xF4, 0xF, 8, 6, 0xE0
MS_Balance2:	dc.b 3			/* balancing 2 */
		dc.b 0xEC, 0xE, 8, 0, 0xE8
		dc.b 4,	0xD, 8, 0xC, 0xE0
		dc.b 0xC, 0, 0x18, 0x14, 0
MS_Float1:	dc.b 3			/* spinning 1 (LZ) */
		dc.b 0xF4, 0xD, 0, 0, 0xFC
		dc.b 0xFC, 5, 0,	8, 0xEC
		dc.b 4,	8, 0, 0xC, 0xFC
MS_Float2:	dc.b 2			/* spinning 2 (LZ) */
		dc.b 0xF4, 0xA, 0, 0, 0xE8
		dc.b 0xF4, 0xA, 8, 0, 0
MS_Float3:	dc.b 3			/* spinning 3 (LZ) */
		dc.b 0xF4, 0xD, 0, 0, 0xE4
		dc.b 0xFC, 0, 0,	8, 4
		dc.b 4,	0xC, 0, 9, 0xEC
MS_Float4:	dc.b 3			/* spinning 4 (LZ) */
		dc.b 0xF4, 0xD, 0, 0, 0xFC
		dc.b 0xFC, 5, 0,	8, 0xEC
		dc.b 4,	8, 0, 0xC, 0xFC
MS_Spring:	dc.b 3			/* bouncing on a spring */
		dc.b 0xE8, 0xB, 0, 0, 0xF0
		dc.b 8,	4, 0, 0xC, 0xF8
		dc.b 0x10, 0, 0,	0xE, 0xF8
MS_Hang1:	dc.b 4			/* hanging 1 (LZ) */
		dc.b 0xF8, 0xE, 0, 0, 0xE8
		dc.b 0,	5, 0, 0xC, 8
		dc.b 0xF8, 0, 0,	0x10, 8
		dc.b 0xF0, 0, 0,	0x11, 0xF8
MS_Hang2:	dc.b 4			/* hanging 2 (LZ) */
		dc.b 0xF8, 0xE, 0, 0, 0xE8
		dc.b 0,	5, 0, 0xC, 8
		dc.b 0xF8, 0, 0,	0x10, 8
		dc.b 0xF0, 0, 0,	0x11, 0xF8
MS_Leap1:	dc.b 5			/* celebration leap 1 (unused) */
		dc.b 0xE8, 0xA, 0, 0, 0xF4
		dc.b 0xF0, 1, 0,	9, 0xC
		dc.b 0,	9, 0, 0xB, 0xF4
		dc.b 0x10, 4, 0,	0x11, 0xF4
		dc.b 0,	0, 0, 0x13, 0xEC
MS_Leap2:	dc.b 5			/* celebration leap 2 (unused) */
		dc.b 0xE8, 0xA, 0, 0, 0xF4
		dc.b 0xE8, 1, 0,	9, 0xC
		dc.b 0,	9, 0, 0xB, 0xF4
		dc.b 0x10, 4, 0,	0x11, 0xF4
		dc.b 0,	0, 0, 0x13, 0xEC
MS_Push1:	dc.b 2			/* pushing 1 */
		dc.b 0xED, 0xA, 0, 0, 0xF3
		dc.b 5,	0xD, 0, 9, 0xEB
MS_Push2:	dc.b 3			/* pushing 2 */
		dc.b 0xEC, 0xA, 0, 0, 0xF3
		dc.b 4,	8, 0, 9, 0xF3
		dc.b 0xC, 4, 0, 0xC, 0xF3
MS_Push3:	dc.b 2			/* pushing 3 */
		dc.b 0xED, 0xA, 0, 0, 0xF3
		dc.b 5,	0xD, 0, 9, 0xEB
MS_Push4:	dc.b 3			/* pushing 4 */
		dc.b 0xEC, 0xA, 0, 0, 0xF3
		dc.b 4,	8, 0, 9, 0xF3
		dc.b 0xC, 4, 0, 0xC, 0xF3
MS_Surf:	dc.b 2			/* surfing or sliding (unused) */
		dc.b 0xEC, 9, 0,	0, 0xF0
		dc.b 0xFC, 0xE, 0, 6, 0xF0
MS_BubStand:	dc.b 3			/* collecting bubble (unused) */
		dc.b 0xEC, 0xA, 0, 0, 0xF0
		dc.b 4,	5, 0, 9, 0xF8
		dc.b 0xE4, 0, 0,	0xD, 0xF8
MS_Burnt:	dc.b 3			/* grey death */
		dc.b 0xE8, 0xD, 0, 0, 0xEC
		dc.b 0xE8, 1, 0,	8, 0xC
		dc.b 0xF8, 0xB, 0, 0xA, 0xF4
MS_Drown:	dc.b 5			/* drowning */
		dc.b 0xE8, 0xD, 0, 0, 0xEC
		dc.b 0xE8, 1, 0,	8, 0xC
		dc.b 0xF8, 9, 0,	0xA, 0xF4
		dc.b 8,	0xC, 0, 0x10, 0xF4
		dc.b 0x10, 0, 0,	0x14, 0xF4
MS_Death:	dc.b 5			/* death */
		dc.b 0xE8, 0xD, 0, 0, 0xEC
		dc.b 0xE8, 1, 0,	8, 0xC
		dc.b 0xF8, 9, 0,	0xA, 0xF4
		dc.b 8,	0xC, 0, 0x10, 0xF4
		dc.b 0x10, 0, 0,	0x14, 0xF4
MS_Shrink1:	dc.b 2			/* shrinking 1 (unused) */
		dc.b 0xEC, 8, 0,	0, 0xF0
		dc.b 0xF4, 0xF, 0, 3, 0xF0
MS_Shrink2:	dc.b 3			/* shrinking 2 (unused) */
		dc.b 0xEC, 8, 0,	0, 0xF0
		dc.b 0xF4, 0xE, 0, 3, 0xF0
		dc.b 0xC, 8, 0, 0xF, 0xF8
MS_Shrink3:	dc.b 1			/* shrinking 3 (unused) */
		dc.b 0xF0, 0xB, 0, 0, 0xF4
MS_Shrink4:	dc.b 1			/* shrinking 4 (unused) */
		dc.b 0xF4, 6, 0,	0, 0xF8
MS_Shrink5:	dc.b 1			/* shrinking 5 (unused) */
		dc.b 0xF8, 1, 0,	0, 0xFC
MS_Float5:	dc.b 3			/* spinning 5 (LZ) */
		dc.b 0xF4, 0xD, 8, 0, 0xE4
		dc.b 0xFC, 5, 8,	8, 4
		dc.b 4,	8, 8, 0xC, 0xEC
MS_Float6:	dc.b 3			/* spinning 6 (LZ) */
		dc.b 0xF4, 0xD, 8, 0, 0xFC
		dc.b 0xFC, 0, 8,	8, 0xF4
		dc.b 4,	0xC, 8, 9, 0xF4
MS_Injury:	dc.b 3			/* injury */
		dc.b 0xF0, 0xE, 0, 0, 0xEC
		dc.b 0xF8, 1, 0,	0xC, 0xC
		dc.b 8,	0xC, 0, 0xE, 0xF4
MS_GetAir:	dc.b 3			/* collecting bubble (LZ) */
		dc.b 0xEB, 9, 0,	0, 0xF4
		dc.b 0xFB, 0xE, 0, 6, 0xEC
		dc.b 3,	1, 0, 0x12, 0xC
MS_WaterSlide:	dc.b 2			/* water	slide (LZ) */
		dc.b 0xF0, 0xF, 0, 0, 0xEC
		dc.b 0xF8, 2, 0,	0x10, 0xC
		.align 2

.equ fr_Null, (ptr_MS_Null-Map_Sonic)/2		/* 0 */
.equ fr_Stand, (ptr_MS_Stand-Map_Sonic)/2		/* 1 */
.equ fr_Wait1, (ptr_MS_Wait1-Map_Sonic)/2		/* 2 */
.equ fr_Wait2, (ptr_MS_Wait2-Map_Sonic)/2		/* 3 */
.equ fr_Wait3, (ptr_MS_Wait3-Map_Sonic)/2		/* 4 */
.equ fr_LookUp, (ptr_MS_LookUp-Map_Sonic)/2		/* 5 */
.equ fr_Walk11, (ptr_MS_Walk11-Map_Sonic)/2		/* 6 */
.equ fr_Walk12, (ptr_MS_Walk12-Map_Sonic)/2		/* 7 */
.equ fr_Walk13, (ptr_MS_Walk13-Map_Sonic)/2		/* 8 */
.equ fr_Walk14, (ptr_MS_Walk14-Map_Sonic)/2		/* 9 */
.equ fr_Walk15, (ptr_MS_Walk15-Map_Sonic)/2		/* $A */
.equ fr_Walk16, (ptr_MS_Walk16-Map_Sonic)/2		/* $B */
.equ fr_Walk21, (ptr_MS_Walk21-Map_Sonic)/2		/* $C */
.equ fr_Walk22, (ptr_MS_Walk22-Map_Sonic)/2		/* $D */
.equ fr_Walk23, (ptr_MS_Walk23-Map_Sonic)/2		/* $E */
.equ fr_Walk24, (ptr_MS_Walk24-Map_Sonic)/2		/* $F */
.equ fr_Walk25, (ptr_MS_Walk25-Map_Sonic)/2		/* $10 */
.equ fr_Walk26, (ptr_MS_Walk26-Map_Sonic)/2		/* $11 */
.equ fr_Walk31, (ptr_MS_Walk31-Map_Sonic)/2		/* $12 */
.equ fr_Walk32, (ptr_MS_Walk32-Map_Sonic)/2		/* $13 */
.equ fr_Walk33, (ptr_MS_Walk33-Map_Sonic)/2		/* $14 */
.equ fr_Walk34, (ptr_MS_Walk34-Map_Sonic)/2		/* $15 */
.equ fr_Walk35, (ptr_MS_Walk35-Map_Sonic)/2		/* $16 */
.equ fr_Walk36, (ptr_MS_Walk36-Map_Sonic)/2		/* $17 */
.equ fr_Walk41, (ptr_MS_Walk41-Map_Sonic)/2		/* $18 */
.equ fr_Walk42, (ptr_MS_Walk42-Map_Sonic)/2		/* $19 */
.equ fr_Walk43, (ptr_MS_Walk43-Map_Sonic)/2		/* $1A */
.equ fr_Walk44, (ptr_MS_Walk44-Map_Sonic)/2		/* $1B */
.equ fr_Walk45, (ptr_MS_Walk45-Map_Sonic)/2		/* $1C */
.equ fr_Walk46, (ptr_MS_Walk46-Map_Sonic)/2		/* $1D */
.equ fr_Run11, (ptr_MS_Run11-Map_Sonic)/2		/* $1E */
.equ fr_Run12, (ptr_MS_Run12-Map_Sonic)/2		/* $1F */
.equ fr_Run13, (ptr_MS_Run13-Map_Sonic)/2		/* $20 */
.equ fr_Run14, (ptr_MS_Run14-Map_Sonic)/2		/* $21 */
.equ fr_Run21, (ptr_MS_Run21-Map_Sonic)/2		/* $22 */
.equ fr_Run22, (ptr_MS_Run22-Map_Sonic)/2		/* $23 */
.equ fr_Run23, (ptr_MS_Run23-Map_Sonic)/2		/* $24 */
.equ fr_Run24, (ptr_MS_Run24-Map_Sonic)/2		/* $25 */
.equ fr_Run31, (ptr_MS_Run31-Map_Sonic)/2		/* $26 */
.equ fr_Run32, (ptr_MS_Run32-Map_Sonic)/2		/* $27 */
.equ fr_Run33, (ptr_MS_Run33-Map_Sonic)/2		/* $28 */
.equ fr_Run34, (ptr_MS_Run34-Map_Sonic)/2		/* $29 */
.equ fr_Run41, (ptr_MS_Run41-Map_Sonic)/2		/* $2A */
.equ fr_Run42, (ptr_MS_Run42-Map_Sonic)/2		/* $2B */
.equ fr_Run43, (ptr_MS_Run43-Map_Sonic)/2		/* $2C */
.equ fr_Run44, (ptr_MS_Run44-Map_Sonic)/2		/* $2D */
.equ fr_Roll1, (ptr_MS_Roll1-Map_Sonic)/2		/* $2E */
.equ fr_Roll2, (ptr_MS_Roll2-Map_Sonic)/2		/* $2F */
.equ fr_Roll3, (ptr_MS_Roll3-Map_Sonic)/2		/* $30 */
.equ fr_Roll4, (ptr_MS_Roll4-Map_Sonic)/2		/* $31 */
.equ fr_Roll5, (ptr_MS_Roll5-Map_Sonic)/2		/* $32 */
.equ fr_Warp1, (ptr_MS_Warp1-Map_Sonic)/2		/* $33 */
.equ fr_Warp2, (ptr_MS_Warp2-Map_Sonic)/2		/* $34 */
.equ fr_Warp3, (ptr_MS_Warp3-Map_Sonic)/2		/* $35 */
.equ fr_Warp4, (ptr_MS_Warp4-Map_Sonic)/2		/* $36 */
.equ fr_Stop1, (ptr_MS_Stop1-Map_Sonic)/2		/* $37 */
.equ fr_Stop2, (ptr_MS_Stop2-Map_Sonic)/2		/* $38 */
.equ fr_Duck, (ptr_MS_Duck-Map_Sonic)/2		/* $39 */
.equ fr_Balance1, (ptr_MS_Balance1-Map_Sonic)/2	/* $3A */
.equ fr_Balance2, (ptr_MS_Balance2-Map_Sonic)/2	/* $3B */
.equ fr_Float1, (ptr_MS_Float1-Map_Sonic)/2		/* $3C */
.equ fr_Float2, (ptr_MS_Float2-Map_Sonic)/2		/* $3D */
.equ fr_Float3, (ptr_MS_Float3-Map_Sonic)/2		/* $3E */
.equ fr_Float4, (ptr_MS_Float4-Map_Sonic)/2		/* $3F */
.equ fr_Spring, (ptr_MS_Spring-Map_Sonic)/2		/* $40 */
.equ fr_Hang1, (ptr_MS_Hang1-Map_Sonic)/2		/* $41 */
.equ fr_Hang2, (ptr_MS_Hang2-Map_Sonic)/2		/* $42 */
.equ fr_Leap1, (ptr_MS_Leap1-Map_Sonic)/2		/* $43 */
.equ fr_Leap2, (ptr_MS_Leap2-Map_Sonic)/2		/* $44 */
.equ fr_Push1, (ptr_MS_Push1-Map_Sonic)/2		/* $45 */
.equ fr_Push2, (ptr_MS_Push2-Map_Sonic)/2		/* $46 */
.equ fr_Push3, (ptr_MS_Push3-Map_Sonic)/2		/* $47 */
.equ fr_Push4, (ptr_MS_Push4-Map_Sonic)/2		/* $48 */
.equ fr_Surf, (ptr_MS_Surf-Map_Sonic)/2		/* $49 */
.equ fr_BubStand, (ptr_MS_BubStand-Map_Sonic)/2	/* $4A */
.equ fr_Burnt, (ptr_MS_Burnt-Map_Sonic)/2		/* $4B */
.equ fr_Drown, (ptr_MS_Drown-Map_Sonic)/2		/* $4C */
.equ fr_Death, (ptr_MS_Death-Map_Sonic)/2		/* $4D */
.equ fr_Shrink1, (ptr_MS_Shrink1-Map_Sonic)/2	/* $4E */
.equ fr_Shrink2, (ptr_MS_Shrink2-Map_Sonic)/2	/* $4F */
.equ fr_Shrink3, (ptr_MS_Shrink3-Map_Sonic)/2	/* $50 */
.equ fr_Shrink4, (ptr_MS_Shrink4-Map_Sonic)/2	/* $51 */
.equ fr_Shrink5, (ptr_MS_Shrink5-Map_Sonic)/2	/* $52 */
.equ fr_Float5, (ptr_MS_Float5-Map_Sonic)/2		/* $53 */
.equ fr_Float6, (ptr_MS_Float6-Map_Sonic)/2		/* $54 */
.equ fr_Injury, (ptr_MS_Injury-Map_Sonic)/2		/* $55 */
.equ fr_GetAir, (ptr_MS_GetAir-Map_Sonic)/2		/* $56 */
.equ fr_WaterSlide, (ptr_MS_WaterSlide-Map_Sonic)/2	/* $57 */
