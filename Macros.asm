# ---------------------------------------------------------------------------
# Set a VRAM address via the VDP control port.
# input: 16-bit VRAM address, control port (default is ($C00004).l)
# ---------------------------------------------------------------------------

.macro locVRAM loc,controlport=(vdp_control_port).l
#		.if (narg==1)
#		move.l	#(0x40000000+((\loc&0x3FFF)<<16)+((\loc&0xC000)>>14)),(vdp_control_port).l
#		.else
		move.l	#(0x40000000+((\loc&0x3FFF)<<16)+((\loc&0xC000)>>14)),\controlport
#		.endc
.endm

# ---------------------------------------------------------------------------
# DMA copy data from 68K (ROM/RAM) to the VRAM
# input: source, length, destination
# ---------------------------------------------------------------------------

.macro writeVRAM v1,v2,v3
		lea	(vdp_control_port).l,a5
		move.l	#0x94000000+(((\v2>>1)&0xFF00)<<8)+0x9300+((\v2>>1)&0xFF),(a5)
		move.l	#0x96000000+(((\v1>>1)&0xFF00)<<8)+0x9500+((\v1>>1)&0xFF),(a5)
		move.w	#0x9700+((((\v1>>1)&0xFF0000)>>16)&0x7F),(a5)
		move.w	#0x4000+(\v3&0x3FFF),(a5)
		move.w	#0x80+((\v3&0xC000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
.endm

# ---------------------------------------------------------------------------
# DMA copy data from 68K (ROM/RAM) to the CRAM
# input: source, length, destination
# ---------------------------------------------------------------------------

.macro writeCRAM v1,v2,v3
		lea	(vdp_control_port).l,a5
		move.l	#0x94000000+(((\v2>>1)&0xFF00)<<8)+0x9300+((\v2>>1)&0xFF),(a5)
		move.l	#0x96000000+(((\v1>>1)&0xFF00)<<8)+0x9500+((\v1>>1)&0xFF),(a5)
		move.w	#0x9700+((((\v1>>1)&0xFF0000)>>16)&0x7F),(a5)
		move.w	#0xC000+(\v3&0x3FFF),(a5)
		move.w	#0x80+((\v3&0xC000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
.endm

# ---------------------------------------------------------------------------
# DMA fill VRAM with a value
# input: value, length, destination
# ---------------------------------------------------------------------------

.macro fillVRAM value,length,loc
		lea	(vdp_control_port).l,a5
		move.w	#0x8F01,(a5)
		move.l	#0x94000000+((\length&0xFF00)<<8)+0x9300+(\length&0xFF),(a5)
		move.w	#0x9780,(a5)
		move.l	#0x40000080+((\loc&0x3FFF)<<16)+((\loc&0xC000)>>14),(a5)
		move.w	#\value,(vdp_data_port).l
.endm

# ---------------------------------------------------------------------------
# Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
# input: source, destination, width [cells], height [cells]
# ---------------------------------------------------------------------------

.macro copyTilemap source,loc,width,height
		lea	(\source).l,a1
		move.l	#0x40000000+((\loc&0x3FFF)<<16)+((\loc&0xC000)>>14),d0
		moveq	#\width,d1
		moveq	#\height,d2
		bsr.w	TilemapToVRAM
.endm

# ---------------------------------------------------------------------------
# stop the Z80
# ---------------------------------------------------------------------------

.macro stopZ80
		move.w	#0x100,(z80_bus_request).l
.endm

# ---------------------------------------------------------------------------
# wait for Z80 to stop
# ---------------------------------------------------------------------------

.macro waitZ80
	1001:	btst	#0,(z80_bus_request).l
		bne.s	1001b
.endm

# ---------------------------------------------------------------------------
# reset the Z80
# ---------------------------------------------------------------------------

.macro resetZ80
		move.w	#0x100,(z80_reset).l
.endm

.macro resetZ80a
		move.w	#0,(z80_reset).l
.endm

# ---------------------------------------------------------------------------
# start the Z80
# ---------------------------------------------------------------------------

.macro startZ80
		move.w	#0,(z80_bus_request).l
.endm

# ---------------------------------------------------------------------------
# disable interrupts
# ---------------------------------------------------------------------------

.macro disable_ints
		move	#0x2700,sr
.endm

# ---------------------------------------------------------------------------
# enable interrupts
# ---------------------------------------------------------------------------

.macro enable_ints
		move	#0x2300,sr
.endm

# ---------------------------------------------------------------------------
# long conditional jumps
# ---------------------------------------------------------------------------

.macro jhi loc
		bls.s	1001f
		jmp	\loc
	1001:
.endm

.macro jcc loc
		bcs.s	1001f
		jmp	\loc
	1001:
.endm

.macro jhs loc
		jcc	\loc
.endm

.macro jls loc
		bhi.s	1001f
		jmp	\loc
	1001:
.endm

.macro jcs loc
		bcc.s	1001f
		jmp	\loc
	1001:
.endm

.macro jlo loc
		jcs	\loc
.endm

.macro jeq loc
		bne.s	1001f
		jmp	\loc
	1001:
.endm

.macro jne loc
		beq.s	1001f
		jmp	\loc
	1001:
.endm

.macro jgt loc
		ble.s	1001f
		jmp	\loc
	1001:
.endm

.macro jge loc
		blt.s	1001f
		jmp	\loc
	1001:
.endm

.macro jle loc
		bgt.s	1001f
		jmp	\loc
	1001:
.endm

.macro jlt loc
		bge.s	1001f
		jmp	\loc
	1001:
.endm

.macro jpl loc
		bmi.s	1001f
		jmp	\loc
	1001:
.endm

.macro jmi loc
		bpl.s	1001f
		jmp	\loc
	1001:
.endm

# ---------------------------------------------------------------------------
# check if object moves out of range
# input: location to jump to if out of range, x-axis pos (obX(a0) by default)
# ---------------------------------------------------------------------------

.macro out_of_range exit,pos=obX(a0)
#		.if (narg==2)
		move.w	\pos,d0		/* get object position (if specified as not obX) */
#		.else
#		move.w	obX(a0),d0	/* get object position */
#		.endc
		andi.w	#0xFF80,d0	/* round down to nearest $80 */
		move.w	(v_screenposx).w,d1 /* get screen position */
		subi.w	#128,d1
		andi.w	#0xFF80,d1
		sub.w	d1,d0		/* approx distance between object and screen */
		cmpi.w	#128+320+192,d0
		bhi.w	\exit /* TODO: Find a batter way to do this */
.endm

# Copy pasting this for a .s version because fuck

.macro out_of_range_s exit,pos=obX(a0)
#		.if (narg==2)
		move.w	\pos,d0		/* get object position (if specified as not obX) */
#		.else
#		move.w	obX(a0),d0	/* get object position */
#		.endc
		andi.w	#0xFF80,d0	/* round down to nearest $80 */
		move.w	(v_screenposx).w,d1 /* get screen position */
		subi.w	#128,d1
		andi.w	#0xFF80,d1
		sub.w	d1,d0		/* approx distance between object and screen */
		cmpi.w	#128+320+192,d0
		bhi.s	\exit /* TODO: Find a batter way to do this */
.endm

# ---------------------------------------------------------------------------
# play a sound effect or music
# input: track, terminate routine, branch or jump, move operand size
# ---------------------------------------------------------------------------

.macro music track,terminate,branch,byte
		  .if OptimiseSound==1
			move.b	#\track,(v_snddriver_ram+v_playsnd1).l
		    .if \terminate==1
			rts
		    .endc
		  .else
	 	    .if \byte==1
			move.b	#\track,d0
		    .else
			move.w	#\track,d0
		    .endc
		    .if \branch==1
		      .if \terminate==0
			bsr.w	PlaySound
		      .else
			bra.w	PlaySound
		      .endc
		    .else
		      .if \terminate==0
			jsr	(PlaySound).l
		      .else
			jmp	(PlaySound).l
		      .endc
		    .endc
		  .endc
.endm

.macro sfx track,terminate,branch,byte
		  .if OptimiseSound==1
			move.b	#\track,(v_snddriver_ram+v_playsnd2).l
		    .if \terminate==1
			rts
		    .endc
		  .else
	 	    .if \byte==1
			move.b	#\track,d0
		    .else
			move.w	#\track,d0
		    .endc
		    .if \branch==1
		      .if \terminate==0
			bsr.w	PlaySound_Special
		      .else
			bra.w	PlaySound_Special
		      .endc
		    .else
		      .if \terminate==0
			jsr	(PlaySound_Special).l
		      .else
			jmp	(PlaySound_Special).l
		      .endc
		    .endc
		  .endc
.endm

# ---------------------------------------------------------------------------
# bankswitch between SRAM and ROM
# (remember to enable SRAM in the header first!)
# ---------------------------------------------------------------------------

.macro gotoSRAM
		move.b  #1,(0xA130F1).l
.endm

.macro gotoROM
		move.b  #0,(0xA130F1).l
.endm
