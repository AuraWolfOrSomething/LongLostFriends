.thumb

@.equ WatchfulID, SkillTester+4

.global Capture_Target_Check
.type Capture_Target_Check, %function

.equ gChapterData, 0x0202BCF0
.equ gUnitSubject, 0x02033F3C

.equ CheckEventId, 0x08083DA8
.equ AreAllegiancesAllied, 0x08024D8C
.equ CanUnitRescue, 0x0801831C
.equ AddTarget, 0x0804F8BC

@checks if target unit is an enemy and can be rescued
@r0=current target's data ptr

Capture_Target_Check:
push	{r4-r6,r14}
mov		r4,r0

@can only capture units that are on list
ldr		r5, =GlobalCapturableUnitList
ldr		r6, [r4]
ldrb	r6, [r6,#4]

LoopThroughList:
ldrb	r0, [r5]
cmp		r0, #0 @end of list
beq		GoBack

	cmp		r6, r0
	bne		ContinueListLoop
	
		ldrb	r0, [r5,#1]
		cmp		r0, #0xFF @if all chapters, skip chapter check
		beq		CheckIfEventID
		
			ldr		r1, =gChapterData
			ldrb	r1, [r1,#0x0E]
			cmp		r0, r1
			bne		ContinueListLoop
			
		CheckIfEventID:
		ldrh	r0, [r5,#2]
		cmp		r0, #0
		beq		CheckIfOtherCondition
		
			ldr		r1, =CheckEventId
			mov		lr, r1
			.short	0xF800
			cmp		r0, #0
			beq		ContinueListLoop
		
		CheckIfOtherCondition:
		ldr		r0, [r5,#4]
		cmp		r0, #0
		beq		OnCaptureList
		
			mov		lr, r0
			.short	0xF800
			cmp		r0, #0
			bne		OnCaptureList
	
ContinueListLoop:
add		r5, #8
b		LoopThroughList

@ldr		r1,=WatchfulID
@ldr		r3,=SkillTester
@mov		r14,r3
@.short	0xF800
@cmp		r0,#1
@beq		GoBack 		@can't be captured if they have watchful

@If target can be selected by Recapture, then unavailable from Capture
@mov		r0,r4
@ldr		r3,=IsRecapturePossible
@mov		lr,r3
@.short	0xF800
@cmp		r0,#1
@beq		GoBack

OnCaptureList:
ldr		r0, =AreAllegiancesAllied
mov		r14,r0
ldr		r0, =gUnitSubject
ldr		r5,[r0]
mov		r1,#0xB
ldsb	r0,[r5,r1]
ldsb	r1,[r4,r1]
.short	0xF800
cmp		r0,#0x0
bne		GoBack
mov		r0,r5
ldr		r1, =CanUnitRescue
mov		r14,r1
mov		r1,r4
.short	0xF800
cmp		r0,#0x0
beq		GoBack				@can't capture if you can't rescue
ldr		r0, =AddTarget
mov		r14,r0
ldrb	r0,[r4,#0x10]
ldrb	r1,[r4,#0x11]
ldrb	r2,[r4,#0xB]
mov		r3,#0x0
.short	0xF800
GoBack:
pop		{r4-r6}
pop		{r0}
bx		r0

.align
.ltorg

