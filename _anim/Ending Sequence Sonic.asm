# ---------------------------------------------------------------------------
# Animation script - Sonic on the ending sequence
# ---------------------------------------------------------------------------
AniScript_ESon:	dc.w byte_551C-AniScript_ESon
		dc.w byte_552A-AniScript_ESon
		dc.w byte_5534-AniScript_ESon
byte_551C:	dc.b 3,	1, 0, 1, 0, 1, 0, 1, 0,	1, 0, 1, 2, 0xFA
byte_552A:	dc.b 5,	3, 4, 3, 4, 3, 4, 3, 0xFA, 0
byte_5534:	dc.b 3,	5, 5, 5, 6, 7, 0xFE, 1
		.align 2
