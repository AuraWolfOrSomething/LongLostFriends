@This is a slightly different version of GetGemStatBoosts

@count how many gems w/ promoted unit limit are in inventory
  @if 0, skip to the end

@check if unit is promoted
  @if not, check number of gems
    @if only 1, check for overdrive band
      @if not, check if gem is compatible with overdrive band

@then, check aid boost attached to each gem
  @if promoted/overdrive band, only take first gem's bonus
  
@promoted unit limit list
@item id

@overdrive band compatibility list
@item id

@passive gem boost list
@item id
@aid

.thumb

.global GemLowerASPenalty
.type GemLowerASPenalty, %function


		GemLowerASPenalty:
		push	{r4-r7,r14}
		cmp		r0, #0 @if no penalty, skip this entire thing
		beq		ReturnToASFormula
		
			mov		r4, r0 @current AS penalty
			mov		r0, r1 @unit
			ldr		r1, =PassiveGemLowerASPenaltyList
			ldr		r3, =GetGemSpecialStatBoost
			mov		lr, r3
			.short	0xF800
			sub		r0, r4, r0
			cmp		r0, #0 @if the reduction is greater than the original penalty, set penalty to 0
			bge		ReturnToASFormula
		
				mov		r0, #0
		
		ReturnToASFormula:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

