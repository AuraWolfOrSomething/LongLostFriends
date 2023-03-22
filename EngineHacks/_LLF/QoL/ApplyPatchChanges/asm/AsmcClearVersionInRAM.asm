.thumb

.include "../ApplyPatchChangesDefs.s"

.global AsmcClearVersionInRAM
.type AsmcClearVersionInRAM, %function


		AsmcClearVersionInRAM:
		ldr		r1, =CurrentVersionRamLink
		ldr		r1, [r1]
		mov		r0, #0
		strb	r0, [r1]
		bx		r14
		
		.align
		.ltorg

