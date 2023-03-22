.thumb

.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

DebuffDef:
push {r4-r6, lr}
mov r5, r0 @stat
mov r4, r1 @unit

@If something that prevents debuffs is active, skip
mov		r0, r4
ldr		r1, =AreDebuffsEffective
mov		lr, r1
.short	0xF800
cmp		r0, #0
beq		End
	
	@Anything that halves debuff effectiveness is effective (does not stack, rounds up to the higher debuff penalty)
	mov		r0, r4
	ldr		r1, =AreDebuffsHalved
	mov		lr, r1
	.short	0xF800
	mov		r6, r0
	
	mov		r0, r4
	ldr		r1, =IsRustbowDebuffActive
	mov		lr, r1
	.short	0xF800
	cmp		r0, #0
	beq		CheckLull

		@Rustbow: Debuff equal to duration
		sub		r0, #1
		lsr		r0, r6
		add		r0, #1
		sub 	r5, r0
	
	CheckLull:
	mov		r0, r4
	ldr		r1, =IsLullDebuffActive
	mov		lr, r1
	.short	0xF800
	cmp		r0, #0
	beq		End
	
		@Lull: -5 to stat
		mov		r0, #4
		lsr		r0, r6
		add		r0, #1
		sub 	r5, r0

End:
mov r0, r5
mov r1, r4
pop {r4-r6,pc}
.ltorg
.align

EALiterals:
@POIN DebuffTable
