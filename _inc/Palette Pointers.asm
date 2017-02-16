# ---------------------------------------------------------------------------
# Palette pointers
# ---------------------------------------------------------------------------

.macro palp paladdress,ramaddress,colours
	dc.l \paladdress
	dc.w \ramaddress, (\colours>>1)-1
.endm

PalPointers:

# palette address, RAM address, colours

ptr_Pal_SegaBG:		palp	Pal_SegaBG,v_pal_dry,0x40		/* 0 - Sega logo */
ptr_Pal_Title:		palp	Pal_Title,v_pal_dry,0x40		/* 1 - title screen */
ptr_Pal_LevelSel:	palp	Pal_LevelSel,v_pal_dry,0x40		/* 2 - level select */
ptr_Pal_Sonic:		palp	Pal_Sonic,v_pal_dry,0x10		/* 3 - Sonic */
Pal_Levels:
ptr_Pal_GHZ:		palp	Pal_GHZ,v_pal_dry+0x20, 0x30		/* 4 - GHZ */
ptr_Pal_LZ:		palp	Pal_LZ,v_pal_dry+0x20,0x30		/* 5 - LZ */
ptr_Pal_MZ:		palp	Pal_MZ,v_pal_dry+0x20,0x30		/* 6 - MZ */
ptr_Pal_SLZ:		palp	Pal_SLZ,v_pal_dry+0x20,0x30		/* 7 - SLZ */
ptr_Pal_SYZ:		palp	Pal_SYZ,v_pal_dry+0x20,0x30		/* 8 - SYZ */
ptr_Pal_SBZ1:		palp	Pal_SBZ1,v_pal_dry+0x20,0x30		/* 9 - SBZ1 */
#			zonewarningnoending Pal_Levels,8
ptr_Pal_Special:	palp	Pal_Special,v_pal_dry,0x40		/* $A (10) - special stage */
ptr_Pal_LZWater:	palp	Pal_LZWater,v_pal_dry,0x40		/* $B (11) - LZ underwater */
ptr_Pal_SBZ3:		palp	Pal_SBZ3,v_pal_dry+0x20,0x30		/* $C (12) - SBZ3 */
ptr_Pal_SBZ3Water:	palp	Pal_SBZ3Water,v_pal_dry,0x40		/* $D (13) - SBZ3 underwater */
ptr_Pal_SBZ2:		palp	Pal_SBZ2,v_pal_dry+0x20,0x30		/* $E (14) - SBZ2 */
ptr_Pal_LZSonWater:	palp	Pal_LZSonWater,v_pal_dry,0x10	/* $F (15) - LZ Sonic underwater */
ptr_Pal_SBZ3SonWat:	palp	Pal_SBZ3SonWat,v_pal_dry,0x10	/* $10 (16) - SBZ3 Sonic underwater */
ptr_Pal_SSResult:	palp	Pal_SSResult,v_pal_dry,0x40		/* $11 (17) - special stage results */
ptr_Pal_Continue:	palp	Pal_Continue,v_pal_dry,0x20		/* $12 (18) - special stage results continue */
ptr_Pal_Ending:		palp	Pal_Ending,v_pal_dry,0x40		/* $13 (19) - ending sequence */
			.align 2


.equ palid_SegaBG, (ptr_Pal_SegaBG-PalPointers)/8
.equ palid_Title, (ptr_Pal_Title-PalPointers)/8
.equ palid_LevelSel, (ptr_Pal_LevelSel-PalPointers)/8
.equ palid_Sonic, (ptr_Pal_Sonic-PalPointers)/8
.equ palid_GHZ, (ptr_Pal_GHZ-PalPointers)/8
.equ palid_LZ, (ptr_Pal_LZ-PalPointers)/8
.equ palid_MZ, (ptr_Pal_MZ-PalPointers)/8
.equ palid_SLZ, (ptr_Pal_SLZ-PalPointers)/8
.equ palid_SYZ, (ptr_Pal_SYZ-PalPointers)/8
.equ palid_SBZ1, (ptr_Pal_SBZ1-PalPointers)/8
.equ palid_Special, (ptr_Pal_Special-PalPointers)/8
.equ palid_LZWater, (ptr_Pal_LZWater-PalPointers)/8
.equ palid_SBZ3, (ptr_Pal_SBZ3-PalPointers)/8
.equ palid_SBZ3Water, (ptr_Pal_SBZ3Water-PalPointers)/8
.equ palid_SBZ2, (ptr_Pal_SBZ2-PalPointers)/8
.equ palid_LZSonWater, (ptr_Pal_LZSonWater-PalPointers)/8
.equ palid_SBZ3SonWat, (ptr_Pal_SBZ3SonWat-PalPointers)/8
.equ palid_SSResult, (ptr_Pal_SSResult-PalPointers)/8
.equ palid_Continue, (ptr_Pal_Continue-PalPointers)/8
.equ palid_Ending, (ptr_Pal_Ending-PalPointers)/8
