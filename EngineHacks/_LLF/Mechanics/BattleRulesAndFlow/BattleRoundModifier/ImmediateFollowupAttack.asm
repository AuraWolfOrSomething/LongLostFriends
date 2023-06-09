@Mostly copied from Desperation (I think)

.thumb

.global ImmediateFollowupAttack
.type ImmediateFollowupAttack, %function

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

		ImmediateFollowupAttack:
		
		@Check if weapon has Divine weapon effect
		ldr r0, [sp]
		add r0, #0x4A
		ldrh r0, [r0]
		blh 0x08017724
		cmp	r0, #0x10
		bne NoImmediateFollowup
		
		@Check if attacker can even double attack
		ldr r0, [sp]
		ldr r1, [sp,#4]
		ldr r3, =CheckIfEnoughAS
		mov lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		NoImmediateFollowup
		
		@Now check if they double fr fr
		ldr r0, =CheckIfDoubling
		mov lr, r0
		mov r0, sp
		add r1, sp, #4

		.short 0xf800
		cmp r0, #0
		beq NoImmediateFollowup

		@attacker doubles
		ldr r3, [r6]
		ldr r2, [r3]
		lsl r1, r2, #0xd
		lsr r1, #0xd
		mov r0, #8
		@ mov r0, #40 @attacker skill activated
		@ lsl r0, #8
		@ add r0, #8 @end battle flag?
		orr r1, r0
		ldr r5, =0xfff80000
		mov r0, r5
		and r0, r2
		orr r0, r1
		str r0, [r3]
		ldr r0, [sp] @attacker again
		ldr r1, [sp, #4] @defender
		blh 0x802b018 @battle_oneround
		cmp r0, #0
		bne EndBattle

		@we don't care about the result, we just want to swap them back around if needed
		ldr r0, =CheckIfDoubling @can_double check
		mov lr, r0
		mov r0, sp
		add r1, sp, #4 
		.short 0xf800

		ldr r0, =CheckIfDoubling @can_double check
		mov lr, r0
		mov r1, sp
		add r0, sp, #4 
		.short 0xf800

		@finally the defender goes
		ldr r3, [r6]
		ldr r2, [r3]
		lsl r1, r2, #0xd
		lsr r1, #0xd
		mov r0, #8
		orr r1, r0
		ldr r5, =0xfff80000
		mov r0, r5
		and r0, r2
		orr r0, r1
		str r0, [r3]
		ldr r1, [sp, #4] @defender
		ldr r0, [sp] @attacker
		
		blh 0x802b018 @battle_oneround

		EndBattle:
		ldr r0, =0x802af51
		bx r0

		NoImmediateFollowup:
		ldr r3, [r6]
		ldr r2, [r3]
		lsl r1, r2, #0xd
		lsr r1, #0xd
		mov r0, #8
		orr r1, r0
		ldr r5, =0xfff80000
		mov r0, r5
		and r0, r2
		orr r0, r1
		str r0, [r3]
		ldr r0, =0x802af21
		bx r0

