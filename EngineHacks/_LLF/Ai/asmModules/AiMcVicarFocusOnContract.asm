.thumb

.include "../AiDefinitions.s"

.global AiMcVicarFocusOnContract
.type AiMcVicarFocusOnContract, %function


		AiMcVicarFocusOnContract:
		push	{r14}
		ldr		r0, =gActiveUnitId
		ldrb	r0, [r0]
		ldr		r1, =GetUnit
		mov		lr, r1
		.short	0xF800
		ldr		r0, [r0]
		ldrb	r0, [r0,#4]
		ldr		r1, =McVicarIdLinkAi
		ldrb	r1, [r1]
		cmp		r0, r1
		bne		ValidTarget
		
			@If active unit is McVicar, target isn't valid
			mov		r0, #0
			b		End
		
		ValidTarget:
		mov		r0, #1
		
		End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

