# ---------------------------------------------------------------------------
# Sprite mappings - harpoon (LZ)
# ---------------------------------------------------------------------------
Map_Harp:	dc.w AT_41_h_retracted-Map_Harp, AT_41_h_middle-Map_Harp
		dc.w AT_41_h_extended-Map_Harp, AT_41_v_retracted-Map_Harp
		dc.w AT_41_v_middle-Map_Harp, AT_41_v_extended-Map_Harp
AT_41_h_retracted:	dc.b 1
		dc.b 0xFC, 4, 0,	0, 0xF8
AT_41_h_middle:	dc.b 1
		dc.b 0xFC, 0xC, 0, 2, 0xF8
AT_41_h_extended:	dc.b 2
		dc.b 0xFC, 8, 0,	6, 0xF8
		dc.b 0xFC, 8, 0,	3, 0x10
AT_41_v_retracted:	dc.b 1
		dc.b 0xF8, 1, 0,	9, 0xFC
AT_41_v_middle:	dc.b 1
		dc.b 0xE8, 3, 0,	0xB, 0xFC
AT_41_v_extended:	dc.b 2
		dc.b 0xD8, 2, 0,	0xB, 0xFC
		dc.b 0xF0, 2, 0,	0xF, 0xFC
		.align 2


