.thumb

.include "../MumcuDefs.s"

.global IsUnitCapableOfUnlockingDoor
.type IsUnitCapableOfUnlockingDoor, %function


		IsUnitCapableOfUnlockingDoor:
		push	{r14}
		mov		r1, #0x1E
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

