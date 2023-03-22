.thumb
.org 0 @paste to e17e8
.align 4
	.equ MemorySlot3,0x30004C4    @item ID to give @[0x30004C4]!!?
@at 2d760 write b4 f0 42 f8 00 00 00 00

push {r4-r7,lr}
ldr r3, =MemorySlot3 
str r3, [r3] @[0x30004C4]!!?


mov r4,r1    @save inventory ptrs
mov r5,r2
mov r6,r0	 @proc
mov r7,#0

ldrb r0,[r4] @get item data
ldr r1, =HeavyHoveringBootsIDLink
ldrb r1,[r1]
cmp r0, r1
bne InitiateLoopA

	@add r7,#1
	mov r2,#1
	orr r7,r2

InitiateLoopA:
mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopA:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueA
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopA
ContinueA:
ldrb r0,[r5]
ldr r1, =HeavyHoveringBootsIDLink
ldrb r1,[r1]
cmp r0, r1
bne InitiateLoopB

	@add r7,#1
	mov r2,#2
	orr r7,r2

InitiateLoopB:
mov r2, #0 @Counter 
ldr r3, =PreventTradingList 
PreventTradingLoopB:
ldrb r1, [r3, r2] 
cmp r1, #0x0 
beq ContinueB
add r2, #1 
cmp r0, r1 @
beq NoTrade
b PreventTradingLoopB
ContinueB: 
cmp r7, #0
beq FinishTrade

cmp r7, #3
beq NoTrade
	
	@Find the unit with the boots
	mov r1, #0x41
	ldrb r1,[r6,r1]
	mov r2,#2
	tst r7,r2
	bne FindReceivingUnit
	
		@We want the unit that the cursor isn't on
		cmp r1,#0
		beq ZeroToOne
		
			mov r1,#0
			b FindReceivingUnit
		
		ZeroToOne:
		mov r1,#1
		
	FindReceivingUnit:
	mov r7,r1
	cmp r1,#1
	beq OneToZero
	
		mov r1,#1
		b CheckForTraveling
	
	OneToZero:
	mov r1,#0
	
	@Do not allow a unit to receive Heavy Hovering Boots if they are rescuing or being rescued
	
	CheckForTraveling:
	lsl r1,#2
	add r1,#0x2C
	ldr r0,[r6,r1]
	ldrb r0,[r0,#0x1B]
	cmp r0,#0
	bne NoTrade
	
		@Do not allow a unit to give away Heavy Hovering Boots if they are on terrain that isn't normally accessible to them
		
		lsl r1,r7,#2
		add r1,#0x2C
		ldr r0,[r6,r1]
		ldr r1,=DoesUnitNeedHhbForCurrentTerrain
		mov lr,r1
		.short 0xF800
		cmp r0,#0
		bne NoTrade

FinishTrade:
ldrh r1,[r5]
ldrh r0,[r4]
strh r1,[r4]
strh r0,[r5]
b End
NoTrade:
ldr r0, MuteCheck
ldrb r0,[r0]
lsl r0,r0,#0x1e
cmp r0,#0
blt Mute
mov r0,#0x6c
ldr r1, PlaySound
mov lr,r1
.short 0xF800
Mute:
pop {r4-r7}
pop {r0}
pop {r4}
pop {r0}
ldr r0, ReturnSkip
bx r0
End:
pop {r4-r7}
pop {r1}
bx r1
.align
AbilityGetter:
.long 0x0801756c
PlaySound:
.long 0x080d01fc
ReturnSkip:
.long 0x0802da83
MuteCheck:
.long 0x0202bc31
