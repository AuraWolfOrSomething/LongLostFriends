.thumb
.align

.include "RecordPlaythroughStatsDefinitions.asm"

@function prototypes
.global PostCombatIncrementFatigue
.type PostCombatIncrementFatigue, %function

.global CanUnitFatigue
.type CanUnitFatigue, %function

@.global PostCombatStaffIncrementFatigue
@.type PostCombatStaffIncrementFatigue, %function

@.global PostPrepRestoreFatigue
@.type PostPrepRestoreFatigue, %function

.global PostMapFatigueFunctions
.type PostMapFatigueFunctions, %function



@Relevant EA Literals
@FatigueExemptCharList: null-terminated list of characters for whom fatigue should not be incremented ever

CanUnitFatigue: @takes unit struct in r0, returns bool

push {r4-r7,r14}
mov r4,r0

@check if current chapter is greater than or equal to first fatigue chapter
ldr r0,=#0x202BCF0 @chapter data struct
ldrb r0,[r0,#0xE] @chapter ID
ldr r1,=FatigueStartingChapter
ldrb r1,[r1]
cmp r0,r1 @if current chapter ID < defined chapter ID
blt RetFalse

@check for correct allegiance
ldrb r0,[r4,#0xB]
lsr r0,#6 @top 2 bits denote allegiance
cmp r0,#0 @neither being set = player
bne RetFalse

@check if they're on the exempt list
ldr r0,[r4]
ldrb r5,[r0,#4]
ldr r6,=FatigueExemptCharList
LoopStart:
ldrb r0,[r6]
cmp r0,#0
@beq RetTrue
beq CheckIfForceDeployed
cmp r0,r5
beq RetFalse
add r6,#1
b LoopStart

CheckIfForceDeployed:
mov r0, r5
ldr r3, =#0x08084800 @check if unit is forced
mov lr, r3
.short 0xF800
cmp r0,#0 @if unit is forced deployed, they cannot get fatigue
bne RetFalseForceDeploy

RetTrue:
mov r0,#1
b GoBack

RetFalse:
mov r0,#0
b GoBack

RetFalseForceDeploy:
mov r0,#1
neg r0,r0

GoBack:
pop {r4-r7}
pop {r1}
bx r1


.ltorg
.align


PostCombatIncrementFatigue: @r4=attacker, r5=defender, r6=action struct
push {r4-r7,r14}

@should we increment attacker's fatigue?
mov r0,r4
bl CanUnitFatigue
@cmp r0,#1
@bne CheckDefender
cmp r0,#0
beq CheckDefender

mov r7,r0

@have we performed an action that causes fatigue?
ldrb r0,[r6,#0x11]
cmp r0,#2 @Combat
beq IncrementAttackerFatigue
cmp r0,#3 @Staff; additional fatigue from staff usage is handled elsewhere
beq IncrementAttackerFatigue
cmp r0,#4 @Dance/Play
beq IncrementAttackerFatigue
cmp r0,#6 @Steal
beq IncrementAttackerFatigue
cmp r0,#7 @Summon
beq IncrementAttackerFatigue
cmp r0,#8 @DK Summon (because why not)
bne CheckDefender

IncrementAttackerFatigue:
cmp r7,#1
@bne AddToAccumulatedFatigueAttacker @if force deployed, skip to accumulated fatigue
bne CheckDefender @if force deployed, skip to accumulated fatigue

mov r1,#0x3B @somewhat externalized for ease of editing if need be
ldrb r0,[r4,r1]

@cap of 30 fatigue, but rested bonus and undeployed chapter amount is also stored here, so we want to ignore those when checking the amount of fatigue already on the unit
mov r3, r0
mov r2, #0x1F
and r0, r2
mov r2, #0xE0
and r3, r2
add r0, #1
cmp r0, #0x1E
ble StoreNewFatigueFromActionAttacker

mov r0, #0x1E

StoreNewFatigueFromActionAttacker:
orr r0, r3
strb r0,[r4,r1]

@Keep track of fatigue that would be accumulated by all player units this chapter (even if they are capped or cannot due to forced deployment)

@When the player saves, only keep tracked of the 3 highest amounts (and who accumulated them, if not tied)
@AddToAccumulatedFatigueAttacker:
@ldr r0, [r4]
@ldrb r0, [r0,#4]
@cmp r0, #PlayerUnitRosterSize
@bgt CheckDefender

@sub r0,#1
@ldr r1, =PlaythroughStatsRAM
@ldrb r2, [r1,r0]
@add r2, #1
@cmp r2, #0xFF
@ble StoreAccumulatedFatigueAttacker

@mov r2, #0xFF @cap at 255

@StoreAccumulatedFatigueAttacker:
@strb r2, [r1,r0]

CheckDefender: @should we increment the defender's fatigue?
mov r0,r5
bl CanUnitFatigue
@cmp r0,#1
@bne Return
cmp r0,#0
beq Return

mov r7,r0

@have we performed an action that causes fatigue?
ldrb r0,[r6,#0x11]
cmp r0,#2 @Combat; only combat should increment defender's fatigue
bne Return

IncrementDefenderFatigue:
cmp r7,#1
@bne AddToAccumulatedFatigueDefender @if force deployed, skip to accumulated fatigue
bne Return @if force deployed, skip to accumulated fatigue

mov r1,#0x3B
ldrb r0,[r5,r1]

@cap of 30 fatigue, but rested bonus and undeployed chapter amount is also stored here, so we want to ignore those when checking the amount of fatigue already on the unit
mov r3, r0
mov r2, #0x1F
and r0, r2
mov r2, #0xE0
and r3, r2
add r0, #1
cmp r0, #0x1E
ble StoreNewFatigueFromActionDefender

mov r0, #0x1E

StoreNewFatigueFromActionDefender:
orr r0, r3
strb r0,[r5,r1]

@AddToAccumulatedFatigueDefender:
@ldr r0, [r5]
@ldrb r0, [r0,#4]
@cmp r0, #PlayerUnitRosterSize
@bgt Return

@sub r0,#1
@ldr r1, =PlaythroughStatsRAM
@ldrb r2, [r1,r0]
@add r2, #1
@cmp r2, #0xFF
@ble StoreAccumulatedFatigueDefender

@mov r2, #0xFF @cap at 255

@StoreAccumulatedFatigueDefender:
@strb r2, [r1,r0]

Return:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

.equ CharStructsStart,0x202BE4C


@PostCombatStaffIncrementFatigue: @also gets run post-combat
@r4=attacker, r5=defender, r6=action struct

@push {r4-r7,r14}

@Did we just use a staff?
@ldrb r0,[r6,#0x11]
@cmp r0,#3
@bne EndStaffFatigue

@can the attacker get fatigued?
@mov r0,r4
@bl CanUnitFatigue
@cmp r0,#1
@bne EndStaffFatigue

@what staff did we use?
@ldr r0,=#0x203A4EC @loop is vague as to whether or not this is in r4 so we'll just load it ourselves
@add r0,#0x4A
@ldrh r0,[r0] @equipped item and uses before battle
@mov r1,#0xFF
@and r0,r1 @isolate just the item ID

@what weapon rank requirement does it have?
@mov r1,#36 @length of item table entry 
@mul r0,r1
@ldr r1,=ItemTable
@add r0,r1 @r0=item table entry
@ldrb r0,[r0,#0x1C] @get weapon level
@mov r1,#0 @our final modifier for fatigue

@ASRankCheck:
@cmp r0,#181
@blt BRankCheck
@add r1,#1

@BRankCheck:
@cmp r0,#121
@blt CRankCheck
@add r1,#1

@CRankCheck:
@cmp r0,#71
@blt DRankCheck
@add r1,#1

@DRankCheck:
@cmp r0,#31
@blt ApplyFatigueModifier
@add r1,#1

@no E-rank check because using a staff gives a blanket +1 like every other action; this becomes a modifier rather than a base value as a result

@ApplyFatigueModifier:
@mov r2,r4
@add r2,#0x3B
@ldrb r0,[r2]

@cap of 30 fatigue, but rested bonus and undeployed chapter amount is also stored here, so we want to ignore those when checking the amount of fatigue already on the unit
@mov r7, r0
@mov r3, #0xE0
@and r0, r3
@mov r3, #0x1F
@and r7, r3
@add r0, r1
@cmp r0, #0x1E
@ble StoreNewFatigueFromStaff

@mov r0, #0x1E

@StoreNewFatigueFromStaff:
@orr r0, r7
@strb r0,[r2]

@EndStaffFatigue:

@pop {r4-r7}
@pop {r0}
@bx r0

@.ltorg
@.align

@PostPrepRestoreFatigue: @self-contained, requires no args
PostMapFatigueFunctions:
push {r4-r7, r14}

@loop through ally char structs, check if not deployed, and if so reset fatigue

ldr r4,=CharStructsStart
mov r5,#0

@check if there's a unit here
CharStructLoopStart:
ldr r0,[r4]
cmp r0,#0
beq CharStructLoopReset

@are we deployed?
ldrb r0,[r4,#0xC]
mov r1,#0x8
and r0,r1
cmp r0,#0
@bne CharStructLoopReset
beq ResetUndeployedAndRested

@we aren't deployed, so:
  @increase undeployed chapter count (doesn't keep track after 3)
  @lower fatigue by hp/10 + 1
  @set rested bonus to stats if fatigue <= hp/5
@mov r0,#0
mov r1,#0x3B
ldrb r6,[r4,r1]
mov r7,r6
mov r2,#0x1F
and r6,r2 @current fatigue
mov r2,#0xE0
and r7,r2 @current undeployed chapter count & rest bonus if set

cmp r7,#0xC0
bge LowerFatigueByFrr

add r7,#0x40

LowerFatigueByFrr:
@get value on FatigueRestorationTable
ldr r0,[r4]
ldrb r0,[r0,#4]
ldr r1, =FatigueRestorationTable
ldrb r0,[r1,r0]

@divide max hp by 10 and add 2
@ldrb r0,[r4,#0x12]
@mov r1,#10
@swi 0x6 
@add r0,#2

@get 8 - Lv/5
@mov r2,#0
@ldr r3,[r4,#4]
@ldr r3,[r3,#0x28]
@mov r1,#0x80
@lsl r1,#1
@tst r3,r1
@beq FatigueRestoreGetLevel

@mov r2,#20

@FatigueRestoreGetLevel:
@ldrb r0,[r4,#8]
@add r0,r2
@mov r1,#5
@swi 0x6
@mov r1,#8
@sub r1,r0

@lower fatigue and make sure it isn't a negative value
sub r6,r0 @r1 if swapping to 8 - lv/5 formula
cmp r6,#0 
bge CheckIfSettingRestedBonus

mov r6,#0

CheckIfSettingRestedBonus:
@check if already set
orr r6, r7
mov r2, #0x20
and r7, r2
cmp r7, #0x20
beq StoreLoweredFatigue

@max hp/3
ldrb r0,[r4,#0x12]
mov r1,#3
swi 0x6

@if fatigue > hp/3, don't set rested bonus
mov r7, r6
mov r1, #0x1F
and r7, r1
cmp r7, r0
bgt StoreLoweredFatigue

add r6, #0x20

StoreLoweredFatigue:
@orr r6, r7
mov r1,#0x3B
strb r6,[r4,r1]
b CharStructLoopReset

@otherwise, we are deployed, check if forced deployed
  @if so, keep undeployed chapters and rested bonus
  @if not, reset both
  
ResetUndeployedAndRested:
ldr r0,[r4]
ldrb r0,[r0,#4]
ldr r3, =#0x08084800 @check if unit is forced
mov lr, r3
.short 0xF800
cmp r0,#0
bne CharStructLoopReset

mov r1,#0x3B
ldrb r0,[r4,r1]
mov r2,#0x1F
and r0,r2 @current fatigue
strb r0,[r4,r1]

CharStructLoopReset:
add r5,#1
cmp r5,#0x46
beq CharStructLoopEnd
add r4,#0x48
b CharStructLoopStart

CharStructLoopEnd:

@everyone undeployed has had their fatigue cleared, and everyone deployed has had their undeployed stuff cleared, so we're done

pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align
