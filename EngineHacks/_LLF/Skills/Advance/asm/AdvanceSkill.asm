.thumb

.include "../AdvanceDefs.s"

.global AdvanceSkill
.type AdvanceSkill, %function


		AdvanceSkill:
		push	{r14}
		
		@check if dead
		ldrb	r0, [r4,#0x13]
		cmp		r0, #0
		beq		End
		
		ldrb  	r0, [r6,#0x0C]  @allegiance byte of the current character taking action
		ldrb  	r1, [r4,#0x0B]  @allegiance byte of the character we are checking
		cmp 	r0, r1    @check if same character
		bne 	End
		
		@check for Advance skill
		mov		r0, r4
		ldr		r1, =AdvanceSkillLink
		ldrb	r1, [r1]
		ldr		r3, =SkillTester
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		End
		
		@check if moved more than 2 squares
		  @if so, don't activate Advance
		ldrb 	r0, [r6,#0x10]	@squares moved this turn
		mov		r1, #2
		cmp		r0, r1
		bgt		End
		
		@check if waited this turn
		  @if not, don't activate Advance
		ldrb  	r0, [r6,#0x11]  @action taken this turn
		cmp 	r0, #1
		bne 	End
		
		@check if already used Advance this turn
		ldr		r0, [r4,#0x0C]	@status bitfield
		mov		r1, #0x04
		lsl		r1, #0x08
		tst		r0, r1
		bne		End
		
		@unset 0x2 and 0x40, set 0x400, write to status
		ldr		r0, [r4,#0x0C]	@status bitfield
		mov		r1, #0x42
		mvn		r1, r1
		and		r0, r1		@unset bits 0x42
		mov		r1, #0x04
		lsl		r1, #0x08
		orr		r0, r1
		str		r0, [r4,#0x0C]

		@add unit to the AI list so enemies act twice
		ldr		r0, =gAiDataMinusOne
		ldrb	r1, [r4,#0x0B]	@allegiance byte of the character we are checking
		
		AddAILoop:
		add		r0, #0x01
		ldrb	r2, [r0]
		cmp		r2, #0x00
		bne		AddAILoop
		
		strb	r1, [r0]
		add		r0, #0x01
		strb	r2, [r0]

		Event:
		ldr		r0, =CallMapEventEngine		@event engine thingy
		mov		lr, r0
		ldr		r0, =AdvanceEvent	@this event is just "play some sound effects"
		mov		r1, #0x01		@0x01 = wait for events
		.short	0xF800
		
		End:
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

