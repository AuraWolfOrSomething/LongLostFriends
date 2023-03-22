@This makes it so debuff names can be drawn where status would be on the MMB
@Edit the image to account for any adjustments made to this

.thumb

.equ origin, 0
.include "../StatusDebuffsDefs.s"

.global MMB_DrawStatusText
.type MMB_DrawStatusText, %function


		MMB_DrawStatusText:
		push	{r4-r7,r14}
		add		sp, #-8
		mov		r4, r0 @Spot on MMB
		
		@If no unit, skip
		cmp		r1, #0
		beq		End

			mov		r5, r1 @Unit
			mov		r0, #0
			str		r0, [sp] @Exact place in StatusTextImage if we have a status or debuff
			str		r0, [sp,#4] @Number to display next to the name of status/debuff 
			ldr		r6, =LastStatusInUseLink
			ldrb	r6, [r6]
			
			@Check for Status
			mov		r1, #0x30
			ldrb	r2, [r5,r1]
			lsl		r0, r2, #0x1C
			lsr		r0, #0x1C
			ldr		r3, =StatusTextOnMinimugBox
			
			@If no status, check debuffs
			cmp		r0, #0
			beq		CheckDebuffs
			
			@If unit has a status that "isn't being used", use the first status text
			cmp		r0, r6
			bhi		StatusConfirmed
			
				@Store status duration as the number to display
				lsr		r2, #4
				str		r2, [sp,#4]
				
				@Find this status in the image
				mov		r2, #0xA0
				mul		r0, r2
				add		r3, r0
		
				StatusConfirmed:
				str		r3, [sp]
		
		CheckDebuffs:
		mov		r0, r5
		ldr		r1, =GetDebuffs
		mov		lr, r1
		.short	0xF800
		ldr		r1, [r0]
		ldr		r2, =AnyDebuffsBitfieldLink
		ldr		r2, [r2]
		tst		r1, r2
		beq		DrawImageOfText
		
			add		r6, #1
			mov		r2, #0xA0 @size of each status text in the image
			mul		r6, r2 @if this unit has a debuff, add this to find the debuff location in status text image
			ldr		r7, =DebuffCheckingList
			
		LoopThroughList:
		ldr		r1, [r7]
		cmp		r1, #0
		beq		DrawImageOfText
		
			mov		r0, r5
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		CheckNextDebuff
			
				@If unit has 1 status & at least 1 debuff OR at least 2 debuffs, use the first status text
				ldr		r1, [sp]
				cmp		r1, #0
				bne		DisplayMultipleImage
				
					@If not, remember where this is
					ldr		r1, =StatusTextOnMinimugBox
					add		r1, r6
					str		r1, [sp]
					
					@If this is absorb, store a 0 (will not display duration)
					ldr		r1, [r7]
					ldr		r2, =IsAbsorbDebuffActive
					cmp		r1, r2
					bne		StoreDebuffNumber
					
						mov		r0, #0x17
					
						StoreDebuffNumber:
						str		r0, [sp,#4]
						b		CheckNextDebuff
					
				DisplayMultipleImage:
				ldr		r0, =StatusTextOnMinimugBox
				str		r0, [sp]
				
				@The number to display next to multiple is how many ailments the unit has, instead of how long/strong the ailment is
				ldr		r0, [sp,#4]
				mov		r1, #1
				lsl		r1, #8
				tst		r1, r0
				bne		AddToAilmentCount
				
					@If this is the second ailment (debuff after status, second debuff), change number to be considered as a quantity counter
					mov		r0, #1
					lsl		r0, #8
					add		r0, #1
				
					AddToAilmentCount:
					add		r0, #1
					str		r0, [sp,#4]
			
			CheckNextDebuff:
			add		r6, #0xA0
			add		r7, #4
			b		LoopThroughList
		
		DrawImageOfText:
		ldr		r0, [sp]
		ldr		r1, =VramOffset
		mov		r2, #0x28
		ldr		r3, =CpuFastSet
		mov		lr, r3
		.short	0xF800
		
		@Idk what this is for
		ldr		r0, =Short16F
		strh	r0, [r4]
		add		r0, #1
		strh	r0, [r4,#2]
		add		r0, #1
		strh	r0, [r4,#4]
		add		r0, #1
		strh	r0, [r4,#6]
		add		r0, #1
		strh	r0, [r4,#8]
		mov		r0, #0
		strh	r0, [r4,#0x0A]
		
		@If the number we have is the number of ailments the unit has, remove counter bit
		ldr		r0, [sp,#4]
		lsl		r0, #24
		lsr		r0, #24
		
		@Draw number on the minimug box
		ldr		r1, =Short1128
		add		r0, r1
		strh	r0, [r4,#0x0C]
		
		End:
		add		sp, #8
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

