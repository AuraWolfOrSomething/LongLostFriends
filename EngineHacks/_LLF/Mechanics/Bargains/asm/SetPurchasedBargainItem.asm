.thumb

.include "../BargainsDefs.s"

.global SetPurchasedBargainItem
.type SetPurchasedBargainItem, %function


		SetPurchasedBargainItem:
		push	{r4,r14}
		mov		r4, r1
		
		@Check if shop is being accessed during prep screen
		ldr		r1, =gGameState
		ldrb	r0, [r1,#4]
		mov		r1, #0x10
		and		r1, r0
		cmp		r1, #0
		beq		End
		
		@Find chapter's battle prep shop
		ldr		r1, =gChapterData
		mov		r0, #0x0E
		ldsb	r0, [r1,r0]
		ldr		r1, =ChapterBattlePrepShopTable
		lsl		r0, #2 @entries are 4 bytes long (pointers to the shop)
		add		r1, r0
		ldr		r1, [r1]
		
		LoopThroughBattlePrepShop:
		ldrb	r0, [r1]
		cmp		r0, r4
		beq		ItemFound
		cmp		r0, #0
		beq		End
		add		r1, #2
		b		LoopThroughBattlePrepShop
		
		ItemFound:
		ldrb	r0, [r1,#1]
		ldr		r3, =SetEventId
		mov		lr, r3
		.short	0xF800
		
		End:
		mov		r0, #0
		pop		{r4}
		pop		{r1}
		bx		r1

