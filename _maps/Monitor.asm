# ---------------------------------------------------------------------------
# Sprite mappings - monitors
# ---------------------------------------------------------------------------
Map_Monitor:	dc.w AT_40_static0-Map_Monitor, AT_40_static1-Map_Monitor
		dc.w AT_40_static2-Map_Monitor, AT_40_eggman-Map_Monitor
		dc.w AT_40_sonic-Map_Monitor, AT_40_shoes-Map_Monitor
		dc.w AT_40_shield-Map_Monitor, AT_40_invincible-Map_Monitor
		dc.w AT_40_rings-Map_Monitor, AT_40_s-Map_Monitor
		dc.w AT_40_goggles-Map_Monitor, AT_40_broken-Map_Monitor
AT_40_static0:	dc.b 1			/* static monitor */
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_static1:	dc.b 2			/* static monitor */
		dc.b 0xF5, 5, 0,	0x10, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_static2:	dc.b 2			/* static monitor */
		dc.b 0xF5, 5, 0,	0x14, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_eggman:	dc.b 2			/* Eggman monitor */
		dc.b 0xF5, 5, 0,	0x18, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_sonic:		dc.b 2			/* Sonic	monitor */
		dc.b 0xF5, 5, 0,	0x1C, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_shoes:		dc.b 2			/* speed	shoes monitor */
		dc.b 0xF5, 5, 0,	0x24, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_shield:	dc.b 2			/* shield monitor */
		dc.b 0xF5, 5, 0,	0x28, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_invincible:	dc.b 2			/* invincibility	monitor */
		dc.b 0xF5, 5, 0,	0x2C, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_rings:		dc.b 2			/* 10 rings monitor */
		dc.b 0xF5, 5, 0,	0x30, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_s:		dc.b 2			/* 'S' monitor */
		dc.b 0xF5, 5, 0,	0x34, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_goggles:	dc.b 2			/* goggles monitor */
		dc.b 0xF5, 5, 0,	0x20, 0xF8
		dc.b 0xEF, 0xF, 0, 0, 0xF0
AT_40_broken:	dc.b 1			/* broken monitor */
		dc.b 0xFF, 0xD, 0, 0x38, 0xF0
		.align 2


