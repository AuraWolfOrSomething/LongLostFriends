.thumb

.global SaveSuspendConditions
.type SaveSuspendConditions, %function

.equ gChapterData, 0x0202BCF0


		SaveSuspendConditions:
		push	{r4,r14}
		mov		r4, r0
		
		@check if map menu command "Plan" is usable
		  @if so, continue check
		  @if not, don't update suspend data
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		@bne		DoNotUpdate
		beq	GoToMS_SaveSuspend
		
			@check if player phase
			  @if so, update suspend data
			  @if not, don't update suspend data
			@ldr		r0, =gChapterData
			@ldrb	r0, [r0,#0x0F]
			@cmp		r0, #0
			@beq		GoToMS_SaveSuspend
			
		DoNotUpdate:
		pop		{r4}
		pop		{r0}
		bx		r0
		
		GoToMS_SaveSuspend:
		mov		r0, r4
		pop		{r4}
		pop		{r1}
		mov		lr, r1
		b		GoToLynJump_MS_SaveSuspend
		
		.align
		.ltorg

		GoToLynJump_MS_SaveSuspend:

