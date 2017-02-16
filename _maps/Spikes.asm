# ---------------------------------------------------------------------------
# Sprite mappings - spikes
# ---------------------------------------------------------------------------
Map_Spike:	dc.w byte_CFF4-Map_Spike
		dc.w byte_D004-Map_Spike
		dc.w byte_D014-Map_Spike
		dc.w byte_D01A-Map_Spike
		dc.w byte_D02A-Map_Spike
		dc.w byte_D049-Map_Spike
byte_CFF4:	dc.b 3			/* 3 spikes */
		dc.b 0xF0, 3, 0,	4, 0xEC
		dc.b 0xF0, 3, 0,	4, 0xFC
		dc.b 0xF0, 3, 0,	4, 0xC
byte_D004:	dc.b 3			/* 3 spikes facing sideways */
		dc.b 0xEC, 0xC, 0, 0, 0xF0
		dc.b 0xFC, 0xC, 0, 0, 0xF0
		dc.b 0xC, 0xC, 0,	0, 0xF0
byte_D014:	dc.b 1			/* 1 spike */
		dc.b 0xF0, 3, 0,	4, 0xFC
byte_D01A:	dc.b 3			/* 3 spikes widely spaced */
		dc.b 0xF0, 3, 0,	4, 0xE4
		dc.b 0xF0, 3, 0,	4, 0xFC
		dc.b 0xF0, 3, 0,	4, 0x14
byte_D02A:	dc.b 6			/* 6 spikes */
		dc.b 0xF0, 3, 0,	4, 0xC0
		dc.b 0xF0, 3, 0,	4, 0xD8
		dc.b 0xF0, 3, 0,	4, 0xF0
		dc.b 0xF0, 3, 0,	4, 8
		dc.b 0xF0, 3, 0,	4, 0x20
		dc.b 0xF0, 3, 0,	4, 0x38
byte_D049:	dc.b 1			/* 1 spike facing sideways */
		dc.b 0xFC, 0xC, 0, 0, 0xF0
		.align 2


