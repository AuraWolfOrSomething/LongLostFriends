.thumb

.include "../CaptivesDefs.s"

.global GetChapterCaptiveListEntry
.type GetChapterCaptiveListEntry, %function


		GetChapterCaptiveListEntry:
		ldr		r2, =gChapterData
		mov		r1, #0x0E
		ldsb	r1, [r2,r1]
		ldr		r3, =ChapterCaptiveList
		
		LoopThroughList:
		ldr		r0, [r3]
		cmp		r0, #0
		beq		End @if end of list reached, return with 0
		
			ldrb	r0, [r3]
			cmp		r0, r1
			beq		EntryFound
		
				add		r3, #8 @entries are 8 bytes long
				b		LoopThroughList
		
		EntryFound:
		mov		r0, r3
		
		End:
		bx		r14
		
		.align
		.ltorg

