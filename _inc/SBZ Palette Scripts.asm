# ---------------------------------------------------------------------------
# Scrap Brain Zone palette cycling script
# ---------------------------------------------------------------------------

.macro mSBZp duration,colours,paladdress,ramaddress
	dc.b \duration, \colours
	dc.w \paladdress, \ramaddress
.endm

# duration in frames, number of colours, palette address, RAM address

Pal_SBZCycList1:
	dc.w ((end_SBZCycList1-Pal_SBZCycList1-2)/6)-1
	mSBZp	7,8,Pal_SBZCyc1,v_pal_dry+0x50
	mSBZp	0xD,8,Pal_SBZCyc2,v_pal_dry+0x52
	mSBZp	0xE,8,Pal_SBZCyc3,v_pal_dry+0x6E
	mSBZp	0xB,8,Pal_SBZCyc5,v_pal_dry+0x70
	mSBZp	7,8,Pal_SBZCyc6,v_pal_dry+0x72
	mSBZp	0x1C,0x10,Pal_SBZCyc7,v_pal_dry+0x7E
	mSBZp	3,3,Pal_SBZCyc8,v_pal_dry+0x78
	mSBZp	3,3,Pal_SBZCyc8+2,v_pal_dry+0x7A
	mSBZp	3,3,Pal_SBZCyc8+4,v_pal_dry+0x7C
end_SBZCycList1:
	.align 2

Pal_SBZCycList2:
	dc.w ((end_SBZCycList2-Pal_SBZCycList2-2)/6)-1
	mSBZp	7,8,Pal_SBZCyc1,v_pal_dry+0x50
	mSBZp	0xD,8,Pal_SBZCyc2,v_pal_dry+0x52
	mSBZp	9,8,Pal_SBZCyc9,v_pal_dry+0x70
	mSBZp	7,8,Pal_SBZCyc6,v_pal_dry+0x72
	mSBZp	3,3,Pal_SBZCyc8,v_pal_dry+0x78
	mSBZp	3,3,Pal_SBZCyc8+2,v_pal_dry+0x7A
	mSBZp	3,3,Pal_SBZCyc8+4,v_pal_dry+0x7C
end_SBZCycList2:
	.align 2
