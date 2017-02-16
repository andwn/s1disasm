# ---------------------------------------------------------------------------
# Animation script - Sonic
# ---------------------------------------------------------------------------
Ani_Sonic:

ptr_Walk:	dc.w SonAni_Walk-Ani_Sonic
ptr_Run:	dc.w SonAni_Run-Ani_Sonic
ptr_Roll:	dc.w SonAni_Roll-Ani_Sonic
ptr_Roll2:	dc.w SonAni_Roll2-Ani_Sonic
ptr_Push:	dc.w SonAni_Push-Ani_Sonic
ptr_Wait:	dc.w SonAni_Wait-Ani_Sonic
ptr_Balance:	dc.w SonAni_Balance-Ani_Sonic
ptr_LookUp:	dc.w SonAni_LookUp-Ani_Sonic
ptr_Duck:	dc.w SonAni_Duck-Ani_Sonic
ptr_Warp1:	dc.w SonAni_Warp1-Ani_Sonic
ptr_Warp2:	dc.w SonAni_Warp2-Ani_Sonic
ptr_Warp3:	dc.w SonAni_Warp3-Ani_Sonic
ptr_Warp4:	dc.w SonAni_Warp4-Ani_Sonic
ptr_Stop:	dc.w SonAni_Stop-Ani_Sonic
ptr_Float1:	dc.w SonAni_Float1-Ani_Sonic
ptr_Float2:	dc.w SonAni_Float2-Ani_Sonic
ptr_Spring:	dc.w SonAni_Spring-Ani_Sonic
ptr_Hang:	dc.w SonAni_Hang-Ani_Sonic
ptr_Leap1:	dc.w SonAni_Leap1-Ani_Sonic
ptr_Leap2:	dc.w SonAni_Leap2-Ani_Sonic
ptr_Surf:	dc.w SonAni_Surf-Ani_Sonic
ptr_GetAir:	dc.w SonAni_GetAir-Ani_Sonic
ptr_Burnt:	dc.w SonAni_Burnt-Ani_Sonic
ptr_Drown:	dc.w SonAni_Drown-Ani_Sonic
ptr_Death:	dc.w SonAni_Death-Ani_Sonic
ptr_Shrink:	dc.w SonAni_Shrink-Ani_Sonic
ptr_Hurt:	dc.w SonAni_Hurt-Ani_Sonic
ptr_WaterSlide:	dc.w SonAni_WaterSlide-Ani_Sonic
ptr_Null:	dc.w SonAni_Null-Ani_Sonic
ptr_Float3:	dc.w SonAni_Float3-Ani_Sonic
ptr_Float4:	dc.w SonAni_Float4-Ani_Sonic

SonAni_Walk:	dc.b 0xFF, fr_Walk13, fr_Walk14,	fr_Walk15, fr_Walk16, fr_Walk11, fr_Walk12, afEnd
		.align 2
SonAni_Run:	dc.b 0xFF,  fr_Run11,  fr_Run12,  fr_Run13,  fr_Run14,     afEnd,     afEnd, afEnd
		.align 2
SonAni_Roll:	dc.b 0xFE,  fr_Roll1,  fr_Roll2,  fr_Roll3,  fr_Roll4,  fr_Roll5,     afEnd, afEnd
		.align 2
SonAni_Roll2:	dc.b 0xFE,  fr_Roll1,  fr_Roll2,  fr_Roll5,  fr_Roll3,  fr_Roll4,  fr_Roll5, afEnd
		.align 2
SonAni_Push:	dc.b 0xFD,  fr_Push1,  fr_Push2,  fr_Push3,  fr_Push4,     afEnd,     afEnd, afEnd
		.align 2
SonAni_Wait:	dc.b 0x17, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand
		dc.b fr_Stand, fr_Stand, fr_Stand, fr_Wait2, fr_Wait1, fr_Wait1, fr_Wait1, fr_Wait2, fr_Wait3, afBack, 2
		.align 2
SonAni_Balance:	dc.b 0x1F, fr_Balance1, fr_Balance2, afEnd
		.align 2
SonAni_LookUp:	dc.b 0x3F, fr_LookUp, afEnd
		.align 2
SonAni_Duck:	dc.b 0x3F, fr_Duck, afEnd
		.align 2
SonAni_Warp1:	dc.b 0x3F, fr_Warp1, afEnd
		.align 2
SonAni_Warp2:	dc.b 0x3F, fr_Warp2, afEnd
		.align 2
SonAni_Warp3:	dc.b 0x3F, fr_Warp3, afEnd
		.align 2
SonAni_Warp4:	dc.b 0x3F, fr_Warp4, afEnd
		.align 2
SonAni_Stop:	dc.b 7,	fr_Stop1, fr_Stop2, afEnd
		.align 2
SonAni_Float1:	dc.b 7,	fr_Float1, fr_Float4, afEnd
		.align 2
SonAni_Float2:	dc.b 7,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		.align 2
SonAni_Spring:	dc.b 0x2F, fr_Spring, afChange, id_Walk
		.align 2
SonAni_Hang:	dc.b 4,	fr_Hang1, fr_Hang2, afEnd
		.align 2
SonAni_Leap1:	dc.b 0xF, fr_Leap1, fr_Leap1, fr_Leap1,	afBack, 1
		.align 2
SonAni_Leap2:	dc.b 0xF, fr_Leap1, fr_Leap2, afBack, 1
		.align 2
SonAni_Surf:	dc.b 0x3F, fr_Surf, afEnd
		.align 2
SonAni_GetAir:	dc.b 0xB, fr_GetAir, fr_GetAir, fr_Walk15, fr_Walk16, afChange, id_Walk
		.align 2
SonAni_Burnt:	dc.b 0x20, fr_Burnt, afEnd
		.align 2
SonAni_Drown:	dc.b 0x2F, fr_Drown, afEnd
		.align 2
SonAni_Death:	dc.b 3,	fr_Death, afEnd
		.align 2
SonAni_Shrink:	dc.b 3,	fr_Shrink1, fr_Shrink2, fr_Shrink3, fr_Shrink4, fr_Shrink5, fr_Null, afBack, 1
		.align 2
SonAni_Hurt:	dc.b 3,	fr_Injury, afEnd
		.align 2
SonAni_WaterSlide:
		dc.b 7, fr_Injury, fr_WaterSlide, afEnd
		.align 2
SonAni_Null:	dc.b 0x77, fr_Null, afChange, id_Walk
		.align 2
SonAni_Float3:	dc.b 3,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		.align 2
SonAni_Float4:	dc.b 3,	fr_Float1, afChange, id_Walk
		.align 2

.equ id_Walk, (ptr_Walk-Ani_Sonic)/2	/* 0 */
.equ id_Run, (ptr_Run-Ani_Sonic)/2	/* 1 */
.equ id_Roll, (ptr_Roll-Ani_Sonic)/2	/* 2 */
.equ id_Roll2, (ptr_Roll2-Ani_Sonic)/2	/* 3 */
.equ id_Push, (ptr_Push-Ani_Sonic)/2	/* 4 */
.equ id_Wait, (ptr_Wait-Ani_Sonic)/2	/* 5 */
.equ id_Balance, (ptr_Balance-Ani_Sonic)/2	/* 6 */
.equ id_LookUp, (ptr_LookUp-Ani_Sonic)/2	/* 7 */
.equ id_Duck, (ptr_Duck-Ani_Sonic)/2	/* 8 */
.equ id_Warp1, (ptr_Warp1-Ani_Sonic)/2	/* 9 */
.equ id_Warp2, (ptr_Warp2-Ani_Sonic)/2	/* $A */
.equ id_Warp3, (ptr_Warp3-Ani_Sonic)/2	/* $B */
.equ id_Warp4, (ptr_Warp4-Ani_Sonic)/2	/* $C */
.equ id_Stop, (ptr_Stop-Ani_Sonic)/2	/* $D */
.equ id_Float1, (ptr_Float1-Ani_Sonic)/2	/* $E */
.equ id_Float2, (ptr_Float2-Ani_Sonic)/2	/* $F */
.equ id_Spring, (ptr_Spring-Ani_Sonic)/2	/* $10 */
.equ id_Hang, (ptr_Hang-Ani_Sonic)/2	/* $11 */
.equ id_Leap1, (ptr_Leap1-Ani_Sonic)/2	/* $12 */
.equ id_Leap2, (ptr_Leap2-Ani_Sonic)/2	/* $13 */
.equ id_Surf, (ptr_Surf-Ani_Sonic)/2	/* $14 */
.equ id_GetAir, (ptr_GetAir-Ani_Sonic)/2	/* $15 */
.equ id_Burnt, (ptr_Burnt-Ani_Sonic)/2	/* $16 */
.equ id_Drown, (ptr_Drown-Ani_Sonic)/2	/* $17 */
.equ id_Death, (ptr_Death-Ani_Sonic)/2	/* $18 */
.equ id_Shrink, (ptr_Shrink-Ani_Sonic)/2	/* $19 */
.equ id_Hurt, (ptr_Hurt-Ani_Sonic)/2	/* $1A */
.equ id_WaterSlide, (ptr_WaterSlide-Ani_Sonic)/2 /* $1B */
.equ id_Null, (ptr_Null-Ani_Sonic)/2	/* $1C */
.equ id_Float3, (ptr_Float3-Ani_Sonic)/2	/* $1D */
.equ id_Float4, (ptr_Float4-Ani_Sonic)/2	/* $1E */
