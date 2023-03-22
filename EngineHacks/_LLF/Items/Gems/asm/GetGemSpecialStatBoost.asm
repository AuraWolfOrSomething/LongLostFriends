@This is a slightly different version of GetGemStatBoosts

@count how many gems w/ promoted unit limit are in inventory
  @if 0, skip to the end

@check if unit is promoted
  @if not, check number of gems
    @if only 1, check for overdrive band
      @if not, check if gem is compatible with overdrive band

@then, check the boost attached to each gem
  @if promoted/overdrive band, only take first gem's bonus
  
@promoted unit limit list
@item id

@overdrive band compatibility list
@item id

@passive gem boost list
@item id
@boost

.thumb

.include "../GemDefs.s"

.global GetGemSpecialStatBoost
.type GetGemSpecialStatBoost, %function


		GetGemSpecialStatBoost:
		push	{r4-r7,r14}
		add		sp, #-0x08
		mov		r4, r0 @unit
		mov		r5, r1 @list to use
		mov		r6, r13
		mov		r7, #1 @if unit is promoted and if overdrive band should apply (bit 1 = promoted; bit 2 = overdrive band)

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
		beq		EndOfSpecialBoostGems
		
		@check if promoted
		ldr		r0, [r4,#4]
		ldr		r0, [r0,#0x28]
		mov		r1, #0x80
		lsl		r1, #1
		and		r0, r1
		cmp		r0, #0
		bne		RetrieveGemBoosts
	
			@set as unpromoted and check if more than one gem (if so, overdrive band doesn't work)
			mov		r7, #0
			cmp		r2, #1
			bgt		RetrieveGemBoosts
	
				@check if overdrive band is in inventory
				mov		r0, r4
				ldr		r1, =OverdriveBandLink
				ldrb	r1, [r1]
				ldr		r3, =CheckIfUnitHasItem
				mov		lr, r3
				.short	0xF800
				lsl		r0, #0x18
				cmp		r0, #0
				beq		RetrieveGemBoosts
	
					@check if gem is compatible with overdrive band
					ldrb	r0, [r6]
					ldr		r2, =ClassGemList
		
					CheckIfOnList:
					ldrb	r1, [r2]
					cmp		r0, r1
					beq		UseOverdriveBand
					
						cmp		r1, #0
						beq		RetrieveGemBoosts
						
							add		r2, #1
							b		CheckIfOnList
		
		UseOverdriveBand:
		add		r7, #2
		
		@apply gems in inventory, one by one
		@if overdrive band is functioning or if unit is promoted, stop after the first one
		
		RetrieveGemBoosts:
		mov		r3, #0
		
		GetNextGem:
		ldrb	r0, [r6]
		cmp		r0, #0 @if no item id, then the end of the list has been reached
		beq		ReturnSpecialBoostGems
		
			mov		r2, r5
		
			GetEntry:
			ldrb	r1, [r2]
			cmp		r0, r1
			beq		RetrieveSpecialBoost
			
			cmp		r1, #0 @if not on table, no boost
			beq		NoBoostEntryFound
			
				add		r2, #2
				b		GetEntry
		
			RetrieveSpecialBoost:
			ldrb	r0, [r2,#1]
			add		r3, r0
			b		CheckForOverDriveOrPromoted
		
			NoBoostEntryFound:
			mov		r0, #0
		
			@check if overdrive band or promoted
			  @if so, stop after first gem
			  @otherwise, get the next gem (if there is one)
			CheckForOverDriveOrPromoted:
			mov		r2, #2
			and		r2, r7
			cmp		r2, #0
			bne		TripleBonuses
		
				mov		r2, #1
				and		r2, r7
				cmp		r2, #0
				bne		ReturnSpecialBoostGems
				
					add		r6, #1
					b		GetNextGem
		
		TripleBonuses:
		lsl		r1, r0, #1
		add		r3, r1
		
		ReturnSpecialBoostGems:
		mov		r0, r3
		
		EndOfSpecialBoostGems:
		add		sp, #0x08
		pop		{r4-r7}
		pop		{r1}
		bx		r1

		.align

