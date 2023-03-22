.thumb

.global DodgeFormula
.type DodgeFormula, %function


		DodgeFormula:
		
		@get weapon byte
		ldrb	r2, [r0,#0x1E]
		ldr		r3, =ItemDodgeTable
		ldrsb	r2, [r3,r2]
		add		r1, r2 @Lck + Weapon Dodge
		
		add		r0, #0x68
		strh	r1, [r0]
		bx		r14

