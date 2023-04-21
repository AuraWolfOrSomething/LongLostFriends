.thumb

.include "../MumcuDefs.s"

.global IsUnitCapableOfUnlockingChest
.type IsUnitCapableOfUnlockingChest, %function


		IsUnitCapableOfUnlockingChest:
		push	{r14}
		mov		r1, #0x21
		ldr		r2, =CanUnitOpenLock
		mov		lr, r2
		.short	0xF800
		cmp		r0, #0
		bge		CanUse
		
			mov		r0, #0
			b		End
			
		CanUse:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

