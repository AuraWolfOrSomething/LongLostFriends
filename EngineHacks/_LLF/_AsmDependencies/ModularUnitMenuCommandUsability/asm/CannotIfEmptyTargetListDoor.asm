.thumb

.include "../MumcuDefs.s"

.global CannotIfEmptyTargetListDoor
.type CannotIfEmptyTargetListDoor, %function


		CannotIfEmptyTargetListDoor:
		push	{r14}
		mov		r1, #0x1E
		ldr		r2, =MakeTargetListForDoorAndBridges
		mov		lr, r2
		.short	0xF800
		ldr		r0, =GetTargetListSize
		mov		lr, r0
		.short	0xF800
		cmp		r0, #0
		beq		End
		
			mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

