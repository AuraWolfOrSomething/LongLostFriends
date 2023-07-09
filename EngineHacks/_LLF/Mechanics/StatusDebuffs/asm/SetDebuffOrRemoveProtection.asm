@Unlike AddDebuffOrRemoveProtection, if a unit is hit with a debuff they already have, the duration will be overwritten

.thumb

.global SetDebuffOrRemoveProtection
.type SetDebuffOrRemoveProtection, %function


		SetDebuffOrRemoveProtection:
		push	{r4-r7,r14}
		mov		r4, r0 @unit
		mov		r5, r1 @where debuff is in unit debuff entry
		mov		r6, r2 @how much of the byte is for this debuff
		mov		r7, r3 @value to set (unless blocked by warden)
		
		ldr		r1, =IsWardenActive
		mov		lr, r1
		.short	0xF800
		cmp		r0, #0
		bne		RemoveWarden
		
			mov		r0, r4
			ldr		r1, =GetDebuffs
			mov		lr, r1
			.short	0xF800
			ldrb	r1, [r0,r5]
			mov		r2, #0xFF
			eor		r2, r6
			and		r1, r2
			orr		r1, r7
			strb	r1, [r0,r5]
			b		End
			
			RemoveWarden:
			mov		r0, r4
			ldr		r1, =RemoveWardenBuffOnUnit
			mov		lr, r1
			.short	0xF800
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

