.thumb

.global DebuffInitialization
.type DebuffInitialization, %function


		DebuffInitialization:
		push 	{r4-r5,r14}
		mov 	r0, r4
		mov 	r1, r5
		ldr 	r3, =GetDebuffs
		mov 	lr,r3
		.short 	0xF800
		
		@Clear out the first eight bytes
		mov 	r1, #0
		str 	r1, [r0]                
		str 	r1, [r0,#4]
		
		@Done
		pop		{r4-r5}
		pop 	{r0}
		bx 		r0

		.align
		.ltorg

