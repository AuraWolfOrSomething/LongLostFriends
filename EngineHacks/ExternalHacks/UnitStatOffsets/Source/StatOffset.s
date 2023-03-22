@Allows stat modifiers to be applied to units on load, separate from character data
@Uses the +6 unused byte in UNIT data to index to a table of stat mods
@Branch from 0x8017D34

@r0-r4 = scratch
@r5 = unit struct
@r6 = unit deployment data in RAM

.thumb

.global Stat_Offsetter
.type Stat_Offsetter, %function

.equ gChapterData, 0x0202BCF0


		Stat_Offsetter:
		
		@this is now called differently, so we need to add to the beginning portion
		push	{r4-r7,r14}
		mov		r5, r0
		mov		r6, r1
		
		@with that out of the way, back to the actual thing we wanted to do
		ldrb    r0,[r6,#0x6]    @Loading our mod index
		cmp     r0,#0x0         @If zero, no mod and return immediately
		beq     StatOffs_Return
		
		ldr		r1, =gChapterData
		mov		r7, #0x0E
		ldsb	r7, [r1,r7]
		ldr     r1, =StatOffsTable @Load table with pointers to the table of each chapter
		lsl		r7, #2 @pointers are 4 bytes long
		add		r1, r7
		ldr		r1, [r1]
		
		mov		r2,#0x7F
		and		r0,r2
		sub     r0,r0,#1
		@mov     r2,#0xA         @Each entry in the table is ten bytes long
		@mul     r0,r2
		lsl		r0,#3			@Each entry is 8 bytes long
		add     r0,r1,r0        @Index to our entry
		mov     r3,#0x0
		ldsb    r1,[r0,r3]      @Loading HP mod
		ldrb    r2,[r5,#0x12]   @And current HP
		add     r1,r2,r1
		cmp     r1,#0x0
		
		bgt     StoreHP
		mov     r1,#0x0
		
		StoreHP:
		strb    r1,[r5,#0x12]   @Add together base and mod HP and store, flooring at 0
		strb    r1,[r5,#0x13]
		mov     r4,r5
		add     r4,#0x13
		
		ModApplyLoop:           @Do the same for Str/Skl/Spd/Def/Res/Lck 
		add     r3,#0x1
		ldsb    r1,[r0,r3]
		ldrb    r2,[r4,r3]
		add     r1,r2,r1
		cmp     r1,#0x0
		bge     StoreStat
		
		mov     r1,#0x0
		
		StoreStat:
		strb    r1,[r4,r3]
		cmp     r3,#0x6
		blt     ModApplyLoop    @Only run until Lck
		
		ApplyCon:
		mov     r3,#0x7
		ldsb    r1,[r0,r3]
		mov     r3,#0x1A
		ldsb    r2,[r5,r3]
		add     r1,r2,r1
		strb    r1,[r5,r3]      @No need to floor at zero - CON mods can be negative
		
		@ApplyMove:
		@mov     r3,#0x8
		@ldsb    r1,[r0,r3]
		@mov     r3,#0x1D
		@ldsb    r2,[r5,r3]
		@add     r1,r2,r1
		@strb    r1,[r5,r3]
		
		@ApplyMagic:
		@mov     r3,#0x9
		@ldsb    r1,[r0,r3]
		@mov     r3,#0x3A
		@ldsb    r2,[r5,r3]
		@add     r1,r2,r1
		@cmp     r1,#0x0
		@bge     StoreMagic
		@mov     r1,#0x0
		
		@StoreMagic:
		@strb    r1,[r5,r3]
		
		ldrb    r0, [r6,#0x6]
		mov		r1, #0x80
		tst		r0, r1
		beq		StatOffs_Return
		
		@Check if pointer for status
		ldr		r1, =EEUS_StartingStatusTable
		add		r1, r7
		ldr		r1, [r1]
		cmp		r1, #0
		beq		StatOffs_Return
		
		sub		r0, #0x81
		lsl		r0, #1 @entries for this module are 2 bytes long (current hp, then status)
		add		r2, r0, r1
		
		CheckSettingForCurrentHp:
		ldrb	r1, [r2]
		cmp		r1, #0
		beq		StoreStatus @if equal to 0, just keep current at max hp
		
		strb	r1, [r5,#0x13]
		
		StoreStatus:
		ldrb	r0, [r2,#1]
		mov		r1, #0x30
		strb	r0, [r5,r1]

		StatOffs_Return:
		@mov     r0,r5           @Back to vanilla code
		@add     sp,#0x14
		@pop     {r4-r7}
		@pop     {r1}
		@bx      r1
		
		pop		{r4-r7}
		pop		{r0}
		bx		r0

		.align
		.ltorg


