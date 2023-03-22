.thumb

.equ origin, 0x08028434
.include "../SupportPointEarningDefs.s"

.global ProcessSupportGains
.type ProcessSupportGains, %function


		ProcessSupportGains:
		push	{r4-r7,r14}
		mov		r7, r9
		mov		r6, r8
		push	{r6-r7}
		ldr		r3, =gChapterData
		
		@Vanilla normally checks if current turn is 1, but we're doing this after the chapter
		@ldrh	r0, [r1,#0x10]
		@cmp		r0, #1
		@beq		End @vanilla
		@bne		End @if units should only gain points at the beginning of the chapter
		
		@new check for RS
		  @check if this chapter is set to not gain support points for
		ldr		r2, =ChapterExceptionList
		ldrb	r1, [r3,#0x0E]
		
		CheckIfValidChapter:
		ldrb	r0, [r2]
		cmp		r0, r1
		beq		End
		
			cmp		r0, #0xFF
			beq		CanGainSupportPoints
			
				add		r2, #0x01
				b		CheckIfValidChapter
		
		CanGainSupportPoints:
		ldrb	r1, [r3,#0x14]
		mov		r0, #0x80
		tst		r0, r1
		bne		End
		
			mov		r4, #1
		
		NewUnitLoop: @08028450
		mov		r0, r4
		bl		bl_GetUnit
		mov		r5, r0
		add		r4, #1
		mov		r9, r4
		
		@if unit doesn't exist, skip
		cmp		r5, #0
		beq		NextUnit
		
			ldr		r0, [r5]
			cmp		r0, #0
			beq		NextUnit
		
			@08028466
			ldr		r0, [r5,#0x0C]
			ldr		r1, =UnitState
			tst		r0, r1
			bne		NextUnit
				
			@Vanilla stops units with 5 supports from gaining any more support points, but there's no support cap in RS (other than how many partners a unit has)
			@mov		r0, r5
			@bl		bl_GetUnitTotalSupportLevels
			@cmp		r0, #4
			@bgt		NextUnit
			
			mov		r0, r5
			bl		bl_GetROMUnitSupportCount
			mov		r8, r0
			mov		r7, #0
			cmp		r7, r8
			bge		NextUnit
		
				NewPartnerLoop: @08028488
				mov		r0, r5
				mov		r1, r7
				bl		bl_GetUnitSupportingUnit
				mov		r4, r0
				cmp		r4, #0
				beq		NextPartner
				
					ldr		r6, [r4,#0x0C]
					ldr		r0, =UnitState
					tst		r0, r6
					bne		NextPartner
					
					@if partner isn't a player unit, skip
					mov		r1, #0x0B
					ldsb	r1, [r4,r1]
					@mov		r12, r1
					mov		r0, #0xC0
					tst		r0, r1
					bne		NextPartner
				
					@080284B0
					@not gonna use this, but here's vanilla stuff
					
					@check distance
					  @if 1, succeed
					  @if 0, check if one is rescuing the other (skip if not, somehow)
					  @else, skip
					@mov		r0, r5
					@mov		r1, r4
					@ldr		r3, =GetDistance
					@bl		bl_BXR3
					@cmp		r0, #1
					@beq		CheckIfUnitIsRescued
					
					@cmp		r0, #0
					@bne		NextPartner
					
					@check if rescuing
					@ldrb	r0, [r5,#0x1B]
					@cmp		r0, r12
					@bne		NextPartner
					@b		PartnerTotalSupportLevels
					
					@if unit is being rescued by someone that's not current partner (but is adjacent), skip
					@CheckIfUnitIsRescued: @080284F2
					@ldr		r0, [r5,#0x0C]
					@mov		r1, #0x20
					@tst		r0, r1
					@bne		NextPartner 
					
					@tst		r6, r1
					@bne		NextPartner
					
					@support max check for partner
					@PartnerTotalSupportLevels: @08028502
					@mov		r0, r4
					@bl		bl_GetUnitTotalSupportLevels
					@cmp		r0, #4
					@bgt		NextPartner
					
					@new check for RS
					  @if both units are deployed, multiply support point rate by 2
					  @if both units are undeployed, multiplty support point rate by 1.5
					mov		r2, #0x10
					ldr		r0, [r5,#0x0C]
					mov		r1, #8 @unit state: not deployed
					and		r0, r1
					and		r1, r6
					cmp		r0, r1
					bne		GoToAddSupportPoints
					
					mov		r2, #0
					cmp		r0, #0
					beq		GoToAddSupportPoints
					
						mov		r2, #1
				
						@all checks have been passed; add to unit's current support points
						GoToAddSupportPoints: @0802850C
						mov		r0, r5
						mov		r1, r7
						bl		bl_AddSupportPoints
				
					NextPartner: @08028514
					add		r7, #1
					cmp		r7, r8
					blt		NewPartnerLoop
		
			NextUnit: @0802851A
			mov		r4, r9
			cmp		r4, #0x3F
			ble		NewUnitLoop
		
		End: @08028520
		pop		{r3-r4}
		mov		r8, r3
		mov		r9, r4
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

