.thumb

.global Proc_BurnConsistentRns
.type Proc_BurnConsistentRns, %function

.equ gBattleStats, 0x0203A4D4
.equ gRNState, 0x03000000

.equ RandNext, 0x08000B88


		Proc_BurnConsistentRns:
		push	{r4-r7,r14}
		
		@we only care about any of this if we're not planning
		ldr		r0, =MM_PlanUsability
		mov		lr, r0
		.short	0xF800
		cmp		r0, #1
		bne		End
		
		@only burn rns if battle is actually happening, not during preview
		ldr		r0, =gBattleStats
		ldrh	r1, [r0]
		mov		r0, #2
		tst		r0, r1
		bne		End
		
		@only burn rns if we haven't done so for this specific purpose yet
		ldr 	r4, =AfterPlaythroughStatsRAMPointer
		ldr 	r4, [r4]
		ldrb	r0, [r4,#6]
		cmp		r0, #1
		beq		End
		
		ldr		r5, =gRNState
		
		@if initial run, save current rns to suspend data
		  @else if resumed run, burn rns until rns match suspend data
		ldrb	r0, [r4,#7]
		cmp		r0, #0
		@beq		InitialRun_SaveRns
		beq		InitialRun_InitLoop
		
			CheckForRnMatch:
			ldrh	r0, [r4]
			ldrh	r1, [r5]
			cmp		r0, r1
			bne		BurnRns
			
				ldrh	r0, [r4,#2]
				ldrh	r1, [r5,#2]
				cmp		r0, r1
				bne		BurnRns
				
					ldrh	r0, [r4,#4]
					ldrh	r1, [r5,#4]
					cmp		r0, r1
					beq		SetBit_DoNotRepeat
					
						BurnRns:
						ldr		r0, =RandNext
						mov		lr, r0
						.short	0xF800
						b		CheckForRnMatch
		
		InitialRun_InitLoop:
		mov		r6, #60 @we want to burn more than rngbodyFE8 will burn on a non-player phase; since I set rngbodyFE8's value to 50, this will burn 10 more rns
		ldrb	r7, [r4]
		
		InitialRun_BurnRns:
		sub		r0, r6, r7
		cmp		r0, #0
		ble		InitialRun_SaveRns
		
			ldr		r0, =RandNext
			mov		lr, r0
			.short	0xF800
			add		r7, #1
			b		InitialRun_BurnRns
		
		InitialRun_SaveRns:
		ldrh	r0, [r5]
		strh	r0, [r4]
		ldrh	r0, [r5,#2]
		strh	r0, [r4,#2]
		ldrh	r0, [r5,#4]
		strh	r0, [r4,#4]
		mov		r0, #3
		ldr		r1, =RnBurnAmount_Save
		mov		lr, r1
		.short	0xF800
		
		SetBit_DoNotRepeat:
		mov		r0, #1
		strb	r0, [r4,#6] @this will also unset Bit_DoNotReset (see RnBurnAmount)
		
		End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


