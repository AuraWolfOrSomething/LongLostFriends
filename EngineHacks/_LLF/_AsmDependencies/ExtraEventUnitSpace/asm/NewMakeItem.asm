.thumb

.global NewMakeItem
.type NewMakeItem, %function


		NewMakeItem:
		@push	{r14}
		@mov		r2, r0
		@mov		r0, #0xFF
		@and		r2, r0
		lsl		r2, r0, #0x18
		lsr		r2, #0x18
		
		lsl		r0, r2, #3
		add		r0, r2
		lsl		r0, #2
		ldr		r1, =ItemTable
		add		r3, r0, r1
		ldr		r1, [r3,#8]
		mov		r0, #8
		and		r1, r0
		mov		r0, #0xFF
		cmp		r1, #0
		bne		CheckIfIndestructible
		
		ldrb	r0, [r3,#0x14]
		
		CheckIfIndestructible:
		cmp		r1, #0
		beq		LoadFullDurability
		
		mov		r0, #0
		
		LoadFullDurability:
		lsl		r0, #8
		add		r0, r2
		@pop		{r1}
		@bx		r1
		bx		r14

