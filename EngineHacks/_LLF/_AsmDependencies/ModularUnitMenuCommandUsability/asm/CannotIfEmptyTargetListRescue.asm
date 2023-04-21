.thumb

.include "../MumcuDefs.s"

.global CannotIfEmptyTargetListRescue
.type CannotIfEmptyTargetListRescue, %function


		CannotIfEmptyTargetListRescue:
		push	{r14}
		ldr		r1, =MakeRescueTargetList
		mov		lr, r1
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

