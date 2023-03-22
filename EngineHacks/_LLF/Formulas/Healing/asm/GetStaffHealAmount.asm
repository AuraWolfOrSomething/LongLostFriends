.thumb

.global GetStaffHealAmount
.type GetStaffHealAmount, %function


		GetStaffHealAmount:
		push	{r4-r6,r14}
		mov		r4, r0 @user
		mov		r5, #0 @staff healing
		mov		r6, r2 @target
		mov		r2, #0xFF
		and		r1, r2
		ldr		r3, =StaffHealingList
		
		LoopThroughList:
		ldrb	r2, [r3]
		cmp		r2, #0
		beq		ReturnHealAmount
		
			cmp		r1, r2
			beq		StaffEntryFound
			
				add		r3, #3
				b		LoopThroughList
				
		StaffEntryFound:
		ldrb	r5, [r3,#1] @base amount of healing
		mov		r1, r6
		ldrb	r3, [r3,#2] @healing formula id
		ldr		r2, =StaffHealingFormulaList
		lsl		r3, #2
		ldr		r2, [r2,r3]
		mov		lr, r2
		.short	0xF800
		add		r5, r0
		
		GoToCheckStaffHealingEnhancement:
		mov		r0, r4
		ldr		r1, =CheckStaffHealingEnhancement
		mov		lr, r1
		.short	0xF800
		add		r5, r0
		
		@If S-rank in Staffs, +5 to healing
		mov		r1, #0x2C
		ldrb	r0, [r4,r1]
		ldr		r1, =WEXPRankRequirementsTable
		ldrb	r1, [r1,#5]
		cmp		r0, r1
		blt		CapHealing
		
			add		r5, #5

		CapHealing:
		cmp		r5, #80
		ble		ReturnHealAmount
		
			mov		r5, #80
			b		ReturnHealAmount
		
		ReturnHealAmount:
		mov		r0, r5
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		
		.align
		.ltorg

