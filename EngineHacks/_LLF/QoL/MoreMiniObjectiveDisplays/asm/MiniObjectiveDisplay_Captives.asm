.thumb

.include "../MoreMiniObjectiveDisplayDefs.s"

.global MiniObjectiveDisplay_Captives
.type MiniObjectiveDisplay_Captives, %function


		MiniObjectiveDisplay_Captives:
		mov		r4, r6
		add		r4, #0x34
		
		@Display the text "Captives"
		ldr		r0, =MiniObjectiveDisplay_CaptivesTextLink
		ldrh	r0, [r0]
		ldr		r3, =String_GetFromIndex
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0
		mov		r2, #0
		.short	0xF800
		
		@Check if player has enough captives for win condition
		  @if so, numbers will be green (4)
		  @if not, numbers will be blue (2)
		ldr		r3, =CheckIfEnoughCaptives
		mov		lr, r3
		.short	0xF800
		mov		r7, #2
		lsl		r7, r0

		@current amount of captives
		ldr		r3, =GetCurrentCaptiveAmount
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertNumberOr2Dashes
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x28
		mov		r2, r7
		.short	0xF800
		
		@slash symbol
		ldr		r0, =SlashSymbolLink
		ldrh	r0, [r0]
		ldr		r3, =String_GetFromIndex
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertString
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x30
		mov		r2, #0
		.short	0xF800
		
		@captives needed for win condition
		ldr		r3, =GetRequiredCaptiveAmount
		mov		lr, r3
		.short	0xF800
		ldr		r3, =Text_InsertNumberOr2Dashes
		mov		lr, r3
		mov		r3, r0
		mov		r0, r4
		mov		r1, #0x38
		mov		r2, r7
		.short	0xF800
		
		@Done
		ldr		r3, =MiniObjectiveDisplaysEnd
		@add		r3, #1
		bx		r3

