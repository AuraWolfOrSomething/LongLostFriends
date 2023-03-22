.thumb

.equ origin, 0x080323D4
.include "../ActiveSupportDefs.s"

.global ActionSupport
.type ActionSupport, %function

@sp: replacing r8
@sp,#4: replacing r9 (also saving an extra ldr)


		ActionSupport:
		push	{r4-r7,r14}
		add		sp, #-0x08
		
		ldr		r0, =gActionData
		ldrb	r0, [r0,#0x0D]
		bl		bl_GetUnit
		mov		r4, r0 @partner
		ldr		r0, =gActiveUnit
		ldr		r0, [r0]
		str		r0, [sp,#4] @unit
		ldr		r1, [r4]
		ldrb	r1, [r1,#4]
		mov		r5, r1 @partner char id
		bl		bl_GetSupportDataIdForOtherUnit
		mov		r7, r0 @partner's support id
		ldr		r1, [sp,#4]
		ldr		r1, [r1]
		ldrb	r1, [r1,#4]
		mov		r6, r1 @unit char id
		mov		r0, r4
		bl		bl_GetSupportDataIdForOtherUnit
		str		r0, [sp] @unit's support id
		
		@vanilla FE8 checks if these units can support and then does nothing with the return
		@mov		r1, r0
		@mov		r0, r4
		@bl		bl_CanUnitSupportCommandWith
		
		@change support totals from "Can support to increase" to the minimal value of next rank
		ldr		r0, [sp,#4]
		mov		r1, r7
		bl		bl_GainNextSupportRank
		mov		r0, r4
		ldr		r1, [sp]
		bl		bl_GainNextSupportRank
		
		@get new support rank
		ldr		r0, [sp,#4]
		mov		r1, r7
		bl		bl_GetSupportLevelBySupportIndex
		
		mov		r2, r0
		mov		r0, r6
		mov		r1, r5
		ldr		r3, =ContemporarySupportFix
		mov		lr, r3
		.short	0xF800
		
		@check if either unit has an active support
		  @if both of them don't, set them to be active support partners
		ldr		r3, [sp,#4]
		mov		r2, #0x38
		ldrb	r0, [r3,r2]
		cmp		r0, #0
		bne		EnsureSupportTotalsMatch
		
			ldrb	r0, [r4,r2]
			cmp		r0, #0
			bne		EnsureSupportTotalsMatch
		
				strb	r5, [r3,r2]
				strb	r6, [r4,r2]
		
		EnsureSupportTotalsMatch:
		ldr		r5, [sp,#4]
		add		r5, #0x32
		add		r5, r7
		ldrb	r0, [r5]
		add		r4, #0x32
		ldr		r1, [sp]
		add		r4, r1
		ldrb	r1, [r4]
		cmp		r0, r1
		beq		End
		
			cmp		r0, r1
			ble		SomeComparison
		
				strb	r0, [r4]
		
		SomeComparison:
		cmp		r0, r1
		bge		End
		
			strb	r1, [r5]
		
		End:
		mov		r0, #0
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

