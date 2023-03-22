.thumb

.include "../EeusDefs.s"

.global StoreGenericSkill
.type StoreGenericSkill, %function


		StoreGenericSkill:
		
		@if index isn't 0x80 and above, no skill
		ldrb	r1, [r1,#6]
		mov		r2, #0x80
		tst		r1, r2
		beq		End
		
		@load chapter generic skill table and check if there's a pointer
		ldr		r2, =gChapterData
		mov		r3, #0x0E
		ldsb	r3, [r2,r3]
		ldr     r2, =EEUS_GenericSkillTable @Load table with pointers to the table of each chapter
		lsl		r3, #2 @pointers are 4 bytes long
		add		r2, r3
		ldr		r2, [r2]
		cmp		r2, #0
		beq		End		
		
		sub		r1, #0x81
		add		r2, r1 @entries for this module are 1 byte long (1 skill allowed from this)
		ldrb	r1, [r2]
		cmp		r1, #0
		beq		End
		
		mov		r3, #0x3B
		strb	r1, [r0,r3]
		
		End:
		bx		r14

