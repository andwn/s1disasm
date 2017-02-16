# ---------------------------------------------------------------------------
# Sprite mappings - explosion from a badnik or monitor
# ---------------------------------------------------------------------------
Map_ExplodeItem:dc.w byte_8ED0-Map_ExplodeItem, byte_8ED6-Map_ExplodeItem
		dc.w byte_8EDC-Map_ExplodeItem, byte_8EE2-Map_ExplodeItem
		dc.w byte_8EF7-Map_ExplodeItem
byte_8ED0:	dc.b 1
		dc.b 0xF8, 9, 0,	0, 0xF4
byte_8ED6:	dc.b 1
		dc.b 0xF0, 0xF, 0, 6, 0xF0
byte_8EDC:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x16, 0xF0
byte_8EE2:	dc.b 4
		dc.b 0xEC, 0xA, 0, 0x26, 0xEC
		dc.b 0xEC, 5, 0,	0x2F, 4
		dc.b 4,	5, 0x18,	0x2F, 0xEC
		dc.b 0xFC, 0xA, 0x18, 0x26,	0xFC
byte_8EF7:	dc.b 4
		dc.b 0xEC, 0xA, 0, 0x33, 0xEC
		dc.b 0xEC, 5, 0,	0x3C, 4
		dc.b 4,	5, 0x18,	0x3C, 0xEC
		dc.b 0xFC, 0xA, 0x18, 0x33,	0xFC
		.align 2
# ---------------------------------------------------------------------------
# Sprite mappings - explosion from when	a boss is destroyed
# ---------------------------------------------------------------------------
Map_ExplodeBomb:dc.w byte_8ED0-Map_ExplodeBomb
		dc.w byte_8F16-Map_ExplodeBomb
		dc.w byte_8F1C-Map_ExplodeBomb
		dc.w byte_8EE2-Map_ExplodeBomb
		dc.w byte_8EF7-Map_ExplodeBomb
byte_8F16:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x40, 0xF0
byte_8F1C:	dc.b 1
		dc.b 0xF0, 0xF, 0, 0x50, 0xF0
		.align 2


