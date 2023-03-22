.thumb

.equ origin, 0x0801E908
.equ bl_String_GetFromIndex, . + 0x0800A240 - origin
.equ bl_Text_InsertString, . + 0x08004480 - origin
.equ bl_Text_InsertNumberOr2Dashes, . + 0x080044A4 - origin
.equ bl_GetItemWType, . + 0x08017548 - origin
.equ ContinueVanillaRoutine, . + 0x0801E9B0 - origin

.global AttackItemWindowTextAndValues
.type AttackItemWindowTextAndValues, %function


		AttackItemWindowTextAndValues:
		ldr		r4, =AttackItemWindowTextInfo
		mov		r5, r6
		
		TextLoop:
		ldrh	r0, [r4]
		cmp		r0, #0
		beq		InitValueLoop
		
			bl		bl_String_GetFromIndex
			mov		r3, r0
			mov		r0, r5
			ldrb	r1, [r4,#2]
			mov		r2, #0
			bl		bl_Text_InsertString
			ldrb	r0, [r4,#3]
			add		r5, r0
			add		r4, #4
			b		TextLoop
		
		InitValueLoop:
		ldr		r4, =AttackItemWindowValueInfo
		mov		r5, r6
		
		ValueLoop:
		ldrb	r0, [r4]
		cmp		r0, #0
		beq		ContinueVanillaRoutine
		
			cmp		r0, #0x28
			bne		NotWEXP
		
				mov		r0, r10
				ldrh	r0, [r0]
				bl		bl_GetItemWType
		
				add		r0, r8
				add		r0, #0x28
				ldrb	r3, [r0]
				b		DrawValue
		
			NotWEXP:
			mov		r1, r8
			add		r0, r1
			mov		r2, #0
			ldsh	r3, [r0,r2]
		
			DrawValue:
			mov		r0, r5
			ldrb	r1, [r4,#1]
			mov		r2, r9
			bl		bl_Text_InsertNumberOr2Dashes
			ldrb	r0, [r4,#2]
			add		r5, r0
			add		r4, #3
			b		ValueLoop
			
			.align

