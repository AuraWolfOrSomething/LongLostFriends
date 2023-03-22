.thumb

.global RnBurnAmount_Save
.type RnBurnAmount_Save, %function

.global RnBurnAmount_Reset
.type RnBurnAmount_Reset, %function

.global RnBurnAmount_Load
.type RnBurnAmount_Load, %function

.equ Word1, 0x00040624

.equ WriteAndVerifySramFast, 0x080D184C|1
.equ ReadSramFastAddr, 0x030067A0
.equ IsSramWorking, 0x080A2CB0|1
.equ GetSaveTargetAddress, 0x080A3064|1
.equ SaveMetadata_Save, 0x080A2F94|1


@----------------------------------------------
@RnBurnAmount_Save
@----------------------------------------------

		RnBurnAmount_Save:
		push	{r0-r6,r14}
		mov		r4, r0
		@copying what EMS main suspend saving does
		ldr		r3, =IsSramWorking
		mov		lr, r3
		.short	0xF800
		cmp		r0, #0
		beq		DoNotSave
		
		mov		r0, r4
		ldr		r3, =GetSaveTargetAddress
		mov		lr, r3
		.short	0xF800
		
		ldr		r3, =gSuspendRnBurnChunk
		ldrh	r1, [r3]
		add		r1, r0
		ldrh	r2, [r3,#2]
		
		ldr		r3, =WriteAndVerifySramFast
		ldr		r0, =AfterPlaythroughStatsRAMPointer
		ldr		r0, [r0]
		mov		lr, r3
		.short	0xF800
		
		ldr		r3, =Word1
		mov		r2, r13
		str		r3, [sp]
		mov		r3, #1
		mov		r1, r4
		strb	r3, [r2,#6]
		mov		r0, r13
		ldr		r3, =SaveMetadata_Save
		mov		lr, r3
		.short	0xF800
		
		DoNotSave:
		pop		{r0-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@----------------------------------------------
@RnBurnAmount_Reset
@----------------------------------------------

		RnBurnAmount_Reset:
		push {r4-r5,r14}
		mov r2, r1   @ WriteAndVerifySramFast arg r2 = size
		mov r1, r0   @ WriteAndVerifySramFast arg r1 = target address

		ldr r0, =AfterPlaythroughStatsRAMPointer
		ldr r0, [r0] @ WriteAndVerifySramFast arg r0 = source address
		
		@Do not reset if we need to burn rns
		@ldrb r3, [r0]
		@ldrb r5, [r0,#1]
		@add r3, r5
		
		@ldrb r4, [r0,#3]
		@ldrb r5, [r0,#5]
		@add r4, r5
		
		@cmp r3, r4
		@blt End_RnBurnAmount_Reset
		
		ldrb r3, [r0,#6]
		cmp	r3, #2
		beq	End_RnBurnAmount_Reset
			
		mov r3, #0
		str r3, [r0]
		@strh r3, [r0,#4]
		str r3, [r0,#4]
		
		ldr r3, =WriteAndVerifySramFast
		mov lr, r3
		.short 0xF800
		
		End_RnBurnAmount_Reset:
		pop {r4-r5}
		pop {r0}
		bx r0
		
		.align
		.ltorg


@----------------------------------------------
@RnBurnAmount_Load
@----------------------------------------------

		RnBurnAmount_Load:
		push	{r4,r14}
		mov r2, r1   @ ReadSramFast arg r2 = size
		@ implied    @ ReadSramFast arg r0 = source address

		ldr r4, =AfterPlaythroughStatsRAMPointer
		ldr r4, [r4]
		mov r1, r4 @ ReadSramFast arg r1 = target address

		ldr r3, =ReadSramFastAddr
		ldr r3, [r3] @ r3 = ReadSramFast
		mov lr, r3
		.short 0xF800

		@ldrb r0, [r4]
		@strb r0, [r4,#3]
		@ldrb r0, [r4,#1]
		@strb r0, [r4,#5]
		@mov r0, #0
		@strh r0, [r4]
		
		ldrh r0, [r4,#4]
		cmp r0, #0
		bne SetBit_DoNotReset
		
			ldrh r0, [r4,#2]
			cmp r0, #0
			beq End_RnBurnAmount_Load
		
		SetBit_DoNotReset:
		mov r0, #2
		strb r0, [r4,#6]
		mov r0, #1
		strb r0, [r4,#7]
		
		End_RnBurnAmount_Load:
		pop	{r4}
		pop {r0}
		bx r0
		
		.align
		.ltorg


