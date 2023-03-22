
.thumb

.include "../CommonDefinitions.inc"
.include "../Internal/Definitions.s"

MMBRESGetter:

	.global	MMBRESGetter
	.type	MMBRESGetter, %function
	.set CurrentChapterInfo, EALiterals + 0
	.set CheckIfPrimeFiveIsActive,		EALiterals + 4

	push	{r4,r14}
	mov		r4, r0	@save unit
	
	@check if Prime Five is active
	ldr		r3, CheckIfPrimeFiveIsActive
	mov		r14, r3
	bllr
	cmp		r0, #0
	beq		DisplayRes
	
	ldr		r3, =GetLuk
	b		GetStat
	
	DisplayRes:
	ldr		r3, =GetRes
	
	GetStat:
	mov		r0, r4
	mov		r14, r3
	bllr

	pop		{r4}
	pop		{r1}
	bx		r1

.ltorg

EALiterals:

