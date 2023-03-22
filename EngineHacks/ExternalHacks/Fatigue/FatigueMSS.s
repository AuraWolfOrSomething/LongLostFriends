.thumb
.align


@function prototypes

.global MSSFatigueGetter
.type MSSFatigueGetter, %function

.global MSSRestedBonusThresholdGetter
.type MSSRestedBonusThresholdGetter, %function

.global MSSFatigueRestoredGetter
.type MSSFatigueRestoredGetter, %function

.global MSSFatigueUndeployedChapterGetter
.type MSSFatigueUndeployedChapterGetter, %function


MSSFatigueGetter: 
@return fatigue value in r0
@r8 = current unit data

push {r4-r7,r14}

@check if this unit can fatigue
mov r0,r8
ldr r1,=CanUnitFatigue
mov r14,r1
.short 0xF800
cmp r0,#0 
beq RetFalse @if not, return -1

@get fatigue
mov r0,r8
add r0,#0x3B
ldrb r0,[r0]

@rested bonus and undeployed chapter amount is also stored with fatigue's byte, so ignore those values
mov r1, #0x1F
and r0, r1
b GoBack

RetFalse:
mov r0,#0xFF

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

MSSRestedBonusThresholdGetter:
@return the most fatigue the unit can have while still receiving benefits from rest
@r8 = current unit data

push {r4-r7,r14}

@check if this unit can fatigue
mov r0,r8
ldr r1,=CanUnitFatigue
mov r14,r1
.short 0xF800
cmp r0,#0 
beq RetNotApplicable @if not, return -1

@otherwise, get max hp/3
mov r0,r8
ldrb r0,[r0,#0x12]
mov r1,#3
swi 0x6
b ReturnThresholdGetter

RetNotApplicable:
mov r0,#0xFF

ReturnThresholdGetter:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align

MSSFatigueRestoredGetter:
@return fatigue restored by not deploying
@r8 = current unit data

push {r4-r7,r14}

@check if this unit can fatigue
mov r0,r8
ldr r1,=CanUnitFatigue
mov r14,r1
.short 0xF800
cmp r0,#0 
beq RetNoRestoredFatigue @if not, return -1

@if so, get value on FatigueRestorationTable
mov r0,r8
ldr r0,[r0]
ldrb r0,[r0,#4]
ldr r1, =FatigueRestorationTable
ldrb r0,[r1,r0]
b ReturnRestoredFatigue

@if so, get max hp/10 + 2
@mov r0,r8
@ldrb r0,[r0,#0x12]
@mov r1,#10
@swi 0x6
@add r0,#2
@b ReturnRestoredFatigue

@if so, get 8 - Lv/5
@mov r2,#0
@mov r0,r8
@ldr r3,[r0,#4]
@ldr r3,[r3,#0x28]
@mov r1,#0x80
@lsl r1,#1
@tst r3,r1
@beq FatigueRestoreGetLevel

@mov r2,#20

@FatigueRestoreGetLevel:
@ldrb r0,[r0,#8]
@add r0,r2
@mov r1,#5
@swi 0x6
@mov r1,#8
@sub r1,r0
@mov r0,r1
@b ReturnRestoredFatigue

RetNoRestoredFatigue:
mov r0,#0xFF

ReturnRestoredFatigue:
pop {r4-r7}
pop {r1}
bx r1
.ltorg
.align


MSSFatigueUndeployedChapterGetter:
@return number of undeployed chapters (caps at 3)
@r8 = current unit data

push {r4-r7,r14}
@check if this unit can fatigue
mov r0,r8
ldr r1,=CanUnitFatigue
mov r14,r1
.short 0xF800
cmp r0,#0 
beq RetFalse @if not, return -1

@load fatigue
mov r0,#0
mov r1,r8
add r1,#0x3B
ldrb r1,[r1]
mov r2,#0x40

CountUndeployedChapterLoop:
cmp r1,r2
blt ReturnUndeployedChapterAmount
add r0,#1
sub r1,r2
b	CountUndeployedChapterLoop

ReturnUndeployedChapterAmount:
pop {r4-r7}
pop {r1}
bx r1
.ltorg
.align

