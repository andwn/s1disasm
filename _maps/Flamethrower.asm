# ---------------------------------------------------------------------------
# Sprite mappings - flame thrower (SBZ)
# ---------------------------------------------------------------------------
Map_Flame:	dc.w AT_116_pipe1-Map_Flame, AT_116_pipe2-Map_Flame
		dc.w AT_116_pipe3-Map_Flame, AT_116_pipe4-Map_Flame
		dc.w AT_116_pipe5-Map_Flame, AT_116_pipe6-Map_Flame
		dc.w AT_116_pipe7-Map_Flame, AT_116_pipe8-Map_Flame
		dc.w AT_116_pipe9-Map_Flame, AT_116_pipe10-Map_Flame
		dc.w AT_116_pipe11-Map_Flame, AT_116_valve1-Map_Flame
		dc.w AT_116_valve2-Map_Flame, AT_116_valve3-Map_Flame
		dc.w AT_116_valve4-Map_Flame, AT_116_valve5-Map_Flame
		dc.w AT_116_valve6-Map_Flame, AT_116_valve7-Map_Flame
		dc.w AT_116_valve8-Map_Flame, AT_116_valve9-Map_Flame
		dc.w AT_116_valve10-Map_Flame, AT_116_valve11-Map_Flame
AT_116_pipe1:		dc.b 1
		dc.b 0x28, 5, 0x40, 0x14, 0xFB /* broken pipe style flamethrower */
AT_116_pipe2:		dc.b 2
		dc.b 0x20, 1, 0,	0, 0xFD
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe3:		dc.b 2
		dc.b 0x20, 1, 8,	0, 0xFC
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe4:		dc.b 3
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x20, 1, 0,	0, 0xFD
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe5:		dc.b 3
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x20, 1, 8,	0, 0xFC
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe6:		dc.b 4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x20, 1, 0,	0, 0xFD
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe7:		dc.b 4
		dc.b 8,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x20, 1, 8,	0, 0xFC
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe8:		dc.b 5
		dc.b 0xF8, 0xB, 0, 8, 0xF4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x20, 1, 0,	0, 0xFD
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe9:		dc.b 5
		dc.b 0xF8, 0xB, 8, 8, 0xF4
		dc.b 8,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x20, 1, 8,	0, 0xFC
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe10:	dc.b 6
		dc.b 0xE8, 0xB, 0, 8, 0xF4
		dc.b 0xF7, 0xB, 0, 8, 0xF4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0xF, 6, 0, 2, 0xF8
		dc.b 0x20, 1, 0,	0, 0xFD
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_pipe11:	dc.b 6
		dc.b 0xE7, 0xB, 8, 8, 0xF4
		dc.b 0xF8, 0xB, 8, 8, 0xF4
		dc.b 7,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x20, 1, 8,	0, 0xFC
		dc.b 0x28, 5, 0x40, 0x14, 0xFB
AT_116_valve1:	dc.b 1
		dc.b 0x28, 5, 0x40, 0x18, 0xF9 /* valve style flamethrower */
AT_116_valve2:	dc.b 2
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 0,	0, 0xFD
AT_116_valve3:	dc.b 2
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 8,	0, 0xFC
AT_116_valve4:	dc.b 3
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 0,	0, 0xFD
AT_116_valve5:	dc.b 3
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 8,	0, 0xFC
AT_116_valve6:	dc.b 4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 0,	0, 0xFD
AT_116_valve7:	dc.b 4
		dc.b 8,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 8,	0, 0xFC
AT_116_valve8:	dc.b 5
		dc.b 0xF8, 0xB, 0, 8, 0xF4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0x10, 6, 0,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 0,	0, 0xFD
AT_116_valve9:	dc.b 5
		dc.b 0xF8, 0xB, 8, 8, 0xF4
		dc.b 8,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 8,	0, 0xFC
AT_116_valve10:	dc.b 6
		dc.b 0xE8, 0xB, 0, 8, 0xF4
		dc.b 0xF7, 0xB, 0, 8, 0xF4
		dc.b 8,	6, 0, 2, 0xF8
		dc.b 0xF, 6, 0, 2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 0,	0, 0xFD
AT_116_valve11:	dc.b 6
		dc.b 0xE7, 0xB, 8, 8, 0xF4
		dc.b 0xF8, 0xB, 8, 8, 0xF4
		dc.b 7,	6, 8, 2, 0xF8
		dc.b 0x10, 6, 8,	2, 0xF8
		dc.b 0x28, 5, 0x40, 0x18, 0xF9
		dc.b 0x20, 1, 8,	0, 0xFC
		.align 2


