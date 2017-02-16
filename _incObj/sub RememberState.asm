# ---------------------------------------------------------------------------
# Subroutine to remember whether an object is destroyed/collected
# ---------------------------------------------------------------------------

RememberState:
		out_of_range	1f
		bra.w	DisplaySprite

	1:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	2f
		bclr	#7,2(a2,d0.w)

	2:
		bra.w	DeleteObject

