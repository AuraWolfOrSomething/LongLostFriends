.thumb

.global NewGuideEntryAvailability
.type NewGuideEntryAvailability, %function

.equ gChapterData, 0x0202BCF0

@Instead of locking entries with event IDs, have most entries available except for entries that give advice on specific chapters
@The "space" in each guide entry that was originally for event IDs will instead have the chapter ID that the entry is available on (0xFF = always available)



		NewGuideEntryAvailability:
		cmp		r0, #0xFF
		beq		ReturnTrue
		
			@Get current chapter's id and check if it matches this entry
			ldr		r2, =gChapterData
			mov		r1, #0x0E
			ldsb	r1, [r2,r1]
			cmp		r0, r1
			beq		ReturnTrue

				mov		r0, #0
				b		End
		
		ReturnTrue:
		mov		r0, #1
		
		End:
		bx		r14
		
		.align
		.ltorg

