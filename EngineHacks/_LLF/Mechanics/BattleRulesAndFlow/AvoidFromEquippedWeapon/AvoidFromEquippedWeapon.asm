.thumb

.global AvoidFromEquippedWeapon
.type AvoidFromEquippedWeapon, %function


		AvoidFromEquippedWeapon:
		mov		r1, #0x4A
		ldrb	r1, [r0,r1]
		ldr		r3, =AvoidWeaponList
		
		LoopThroughList:
		ldrb	r2, [r3]
		cmp		r2, #0
		beq		End
		
			cmp		r1, r2
			beq		AddAvoid
			
				add		r3, #2
				b		LoopThroughList
		
		AddAvoid:
		ldrb	r1, [r3,#1]
		mov		r3, #0x62
		ldrh	r2, [r0,r3]
		add		r2, r1
		strh	r2, [r0,r3]
		
		End:
		bx		r14
		
		.align
		.ltorg

