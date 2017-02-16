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

SonAni_Walk:	dc.b 0xFF, 8, 9,	0xA, 0xB,	6, 7, afEnd
		.align 2
SonAni_Run:	dc.b 0xFF, 0x1E, 0x1F, 0x20, 0x21, afEnd, afEnd, afEnd
		.align 2
SonAni_Roll:	dc.b 0xFE, 0x2E, 0x2F, 0x30, 0x31, 0x32, afEnd, afEnd
		.align 2
SonAni_Roll2:	dc.b 0xFE, 0x2E, 0x2F, 0x32, 0x30, 0x31, 0x32,	afEnd
		.align 2
SonAni_Push:	dc.b 0xFD, 0x45, 0x46, 0x47, 0x48, afEnd, afEnd, afEnd
		.align 2
SonAni_Wait:	dc.b 0x17, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 2, 2, 2, 3, 4, afBack, 2
		.align 2
SonAni_Balance:	dc.b 0x1F, 0x3A, 0x3B, afEnd
		.align 2
SonAni_LookUp:	dc.b 0x3F, 5, afEnd
		.align 2
SonAni_Duck:	dc.b 0x3F, 0x39, afEnd
		.align 2
SonAni_Warp1:	dc.b 0x3F, 0x33, afEnd
		.align 2
SonAni_Warp2:	dc.b 0x3F, 0x34, afEnd
		.align 2
SonAni_Warp3:	dc.b 0x3F, 0x35, afEnd
		.align 2
SonAni_Warp4:	dc.b 0x3F, 0x36, afEnd
		.align 2
SonAni_Stop:	dc.b 7,	0x37, 0x38, afEnd
		.align 2
SonAni_Float1:	dc.b 7,	0x3C, 0x3F, afEnd
		.align 2
SonAni_Float2:	dc.b 7,	0x3C, 0x3D, 0x53, 0x3E, 0x54, afEnd
		.align 2
SonAni_Spring:	dc.b 0x2F, 0x40, afChange, id_Walk
		.align 2
SonAni_Hang:	dc.b 4,	0x41, 0x42, afEnd
		.align 2
SonAni_Leap1:	dc.b 0xF, 0x43, 0x43, 0x43,	afBack, 1
		.align 2
SonAni_Leap2:	dc.b 0xF, 0x43, 0x44, afBack, 1
		.align 2
SonAni_Surf:	dc.b 0x3F, 0x49, afEnd
		.align 2
SonAni_GetAir:	dc.b 0xB, 0x56, 0x56, 0xA, 0xB, afChange, id_Walk
		.align 2
SonAni_Burnt:	dc.b 0x20, 0x4B, afEnd
		.align 2
SonAni_Drown:	dc.b 0x2F, 0x4C, afEnd
		.align 2
SonAni_Death:	dc.b 3,	0x4D, afEnd
		.align 2
SonAni_Shrink:	dc.b 3,	0x4E, 0x4F, 0x50, 0x51, 0x52, 0, afBack, 1
		.align 2
SonAni_Hurt:	dc.b 3,	0x55, afEnd
		.align 2
SonAni_WaterSlide:
		dc.b 7, 0x55, 0x57, afEnd
		.align 2
SonAni_Null:	dc.b 0x77, 0, afChange, id_Walk
		.align 2
SonAni_Float3:	dc.b 3,	0x3C, 0x3D, 0x53, 0x3E, 0x54, afEnd
		.align 2
SonAni_Float4:	dc.b 3,	0x3C, afChange, id_Walk
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
