.thumb

.equ origin, 0x08017E44
.equ ContinueLoadUnitStats, . + 0x08017E72 - origin

.global LoadUnitStatsRewrite
.type LoadUnitStatsRewrite, %function


		LoadUnitStatsRewrite:
		mov		r6, r1
		add		r6, #0x0D
		mov		r7, r4
		add		r7, #0x14
		
		LoopMainStats: @pow/skl/spd/def/res
		mov		r0, r2
		add		r0, #0x0C
		ldrb	r0, [r0,r3]
		ldrb	r5, [r6,r3]
		add		r0, r5
		strb	r0, [r7,r3]
		add		r3, #1
		cmp		r3, #5
		blt		LoopMainStats
		
		@luck and con
		ldrb	r0, [r1,#0x12]
		strb	r0, [r4,#0x19]
		mov		r0, #0
		strb	r0, [r4,#0x1A]
		b		ContinueLoadUnitStats

