.thumb

.include "../PostMapFunctionsDefs.s"

.global PostMapPartySwapGold
.type PostMapPartySwapGold, %function


		PostMapPartySwapGold:
		@get pointers
		ldr		r2, =gChapterData
		ldr		r3, =OtherCurrencyRamLink
		ldr		r3, [r3]
		
		@load values
		ldr		r0, [r2,#8] @gold
		ldr		r1, [r3] @other party's gold
		
		@swap values
		str		r0, [r3]
		str		r1, [r2,#8]
		
		@done
		bx		r14
		
		.align
		.ltorg


