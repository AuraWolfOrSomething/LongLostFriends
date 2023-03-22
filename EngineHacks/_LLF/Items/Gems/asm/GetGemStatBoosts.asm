@count how many gems w/ promoted unit limit are in inventory
  @if 0, skip to the end

@check if unit is promoted
  @if not, check number of gems
    @if only 1, check for overdrive band
      @if not, check if gem is compatible with overdrive band

@then, check boosts attached to each gem
  @if promoted/overdrive band, only take first gem's bonus(es)

@promoted unit limit list
@item id

@overdrive band compatibility list
@item id

@passive gem boost list
@item id
@low/high: pow/skl
@low/high: spd/def
@low/high: res/lck

@r4 = unit
@r5 = value to lsl by
@r6 = list of gems
@r7 = if unit is promoted (0 if unpromoted)


.thumb

.include "../GemDefs.s"

.global GetGemStatBoosts
.type GetGemStatBoosts, %function


		GetGemStatBoosts:
		push	{r4-r7,r14}
		add		sp, #-0x08
		mov		r4, r0
		mov		r5, r1
		mov		r6, r13
		
		mov		r1, r6
		ldr		r2, =PromotedLimitGemList
		ldr		r3, =StoreInventoryAtStackPointer
		mov		lr, r3
		.short	0xF800
		mov		r0, #0
		mov		r2, #0
		
		@count number of gems
		CountGems:
		ldrb	r1, [r6,r2]
		cmp		r1, #0
		beq		CheckNumberOfGems
		
			add		r2, #1
			b		CountGems
		
		CheckNumberOfGems:
		cmp		r2, #0
		beq		EndOfStatBoostGems
		
		@check if promoted
		ldr		r0, [r4,#4]
		ldr		r0, [r0,#0x28]
		mov		r1, #0x80
		lsl		r1, #1
		tst		r0, r1
		beq		ContinueOverbandCheck
		
			@set as promoted
			mov		r0, #1
			strb	r0, [r6,#7]
			b		RetrieveGemBoosts
		
		ContinueOverbandCheck:
		@check if more than one gem (if so, overdrive band doesn't work)
		cmp		r2, #1
		bgt		SelnaGemCheck
		
			@check if overdrive band is in inventory
			mov		r0, r4
			ldr		r1, =OverdriveBandLink
			ldrb	r1, [r1]
			ldr		r3, =CheckIfUnitHasItem
			mov		lr, r3
			.short	0xF800
			lsl		r0, #0x18
			cmp		r0, #0
			beq		SelnaGemCheck
		
				@check if gem is compatible with overdrive band
				ldrb	r0, [r6]
				ldr		r2, =ClassGemList
		
		CheckIfOnList:
		ldrb	r1, [r2]
		cmp		r0, r1
		beq		UseOverdriveBand
		
			cmp		r1, #0
			beq		SelnaGemCheck
		
				add		r2, #1
				b		CheckIfOnList
		
		UseOverdriveBand:
		mov		r0, #2
		strb	r0, [r6,#6]
		b		RetrieveGemBoosts @Overdrive Band and Selna Gem doubling can't both be active, so skip checking
		
		SelnaGemCheck:
		mov		r0, r4
		ldr		r1, =SelnaGemLink
		ldrb	r1, [r1]
		ldr		r3, =CheckIfUnitHasItem
		mov		lr, r3
		.short	0xF800
		lsl		r0, #0x18
		cmp		r0, #0
		beq		RetrieveGemBoosts
		
			mov		r0, #1
			strb	r0, [r6,#6]
		
		@apply gems in inventory, one by one
		@if overdrive band is functioning or if unit is promoted, stop after the first one
		
		RetrieveGemBoosts:
		mov		r3, #0
		mov		r7, r6 @r6 will be slowly incremented as gem boosts are gathered, but access to specific spots past the stack pointer is still needed
		
		GetNextGem:
		ldrb	r0, [r6]
		cmp		r0, #0 @if no item id, then the end of the list has been reached
		beq		ReturnStatBoostGems
		
			ldr		r2, =PassiveGemBoostList
		
			GetBoosts:
			ldrb	r1, [r2]
			cmp		r0, r1
			beq		RetrieveStatBoosts
			
				cmp		r1, #0 @check if end of the list is reached
				beq		NoBoostEntryFound
			
					add		r2, #4
					b		GetBoosts
		
			RetrieveStatBoosts:
			@check if this is the Selna gem
			  @if not, check if Selna gem doubling is active
				@if so, double
			
			ldr		r1, =SelnaGemLink
			ldrb	r1, [r1]
			cmp		r0, r1
			beq		NormalGemBoost
			
				ldrb	r1, [r7,#6]
				cmp		r1, #1
				beq		ApplyGemBoost
		
			NormalGemBoost:
			mov		r1, #0
		
			ApplyGemBoost:
			ldr		r0, [r2]
			lsl		r0, r5
			lsr		r0, #0x1C
			lsl		r0, r1
			add		r3, r0
			b		CheckForOverDriveOrPromoted
		
			NoBoostEntryFound:
			mov		r0, #0
		
			@check if overdrive band or promoted
			  @if so, stop after first gem
			  @otherwise, get the next gem (if there is one)
			CheckForOverDriveOrPromoted:
			ldrb	r1, [r7,#6]
			cmp		r1, #2
			beq		TripleBonuses
		
				ldrb	r1, [r7,#7]
				cmp		r1, #1
				beq		ReturnStatBoostGems
		
					add		r6, #1
					b		GetNextGem
		
		TripleBonuses:
		lsl		r1, r0, #1
		add		r3, r1
		
		ReturnStatBoostGems:
		mov		r0, r3
		
		EndOfStatBoostGems:
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align

