.thumb
.include "mss_defs.s"

.equ SS_FatigueText, CheckIfRecruitOrFatigue+4
.equ MSSFatigueGetter, SS_FatigueText+4
.equ SS_RestedBonusThresholdText, MSSFatigueGetter+4
.equ MSSRestedBonusThresholdGetter, SS_RestedBonusThresholdText+4
.equ SS_FatigueRestoredText, MSSRestedBonusThresholdGetter+4
.equ MSSFatigueRestoredGetter, SS_FatigueRestoredText+4
.equ SS_FatigueUndeployedChapterText, MSSFatigueRestoredGetter+4
.equ MSSFatigueUndeployedChapterGetter, SS_FatigueUndeployedChapterText+4
.equ McVicarIdLink, MSSFatigueUndeployedChapterGetter+4
.equ McVicarProgressTracking, McVicarIdLink+4
.equ Const_2003D4C, McVicarProgressTracking+4
.equ DrawSpecialUiChar, Const_2003D4C+4

@This page has:
@Fatigue stats (Ftg + the other 3)
@Weapon ranks that the particular unit has
@All support partners

page_start

@Check if recruitment info should appear instead of Fatigue
ldr r3, CheckIfRecruitOrFatigue
mov r14, r3
mov r0, r8
.short 0xF800
cmp r0, #0
beq DisplayFatigueStats

@Recruitment info
mov r5, #0
mov r6, r0
ldrh r0, [r6,#2]
bl DisplayRecruitmentInfoLine
ldr r1, =(tile_origin+(0x20*2*3)+(2*13))
mov r3, #0
blh DrawText, r4

@If McVicar, need to display progress towards recruitment
ldrb r0, [r6]
ldr r1, McVicarIdLink
cmp r0, r1
bne DisplayNextRecruitmentInfoLine

ldr r0, McVicarProgressTracking
mov r14, r0
.short 0xF800
cmp r0, #3
bne DrawProgress

mov r5, #1

DrawProgress:
draw_number_at 21, 3

@slash marker
ldr r0, Const_2003D4C
add	r0, #0x36
mov	r1, #0
mov	r2, #0x16
ldr	r3, DrawSpecialUiChar
mov	lr, r3
.short 0xF800

mov r0,#4
draw_number_at 25, 3

DisplayNextRecruitmentInfoLine:
add r7, #8

ldrh r0, [r6,#4]
add r0, r5
bl DisplayRecruitmentInfoLine
ldr r1, =(tile_origin+(0x20*2*5)+(2*13))
mov r3, #0
blh DrawText, r4

add r7, #8
b SkipFatigueStats

@copied this from page4 likes/dislikes implementation
DisplayRecruitmentInfoLine:
push {r14}
mov r3, r7
mov r1, #20 @width
ldrh r2, [r3]
add r2, r1
strb r1, [r3,#4]
strb r2, [r3,#8]
blh BufferText
mov r2, #0
str r2, [sp,#4]
str r0, [sp,#8]
mov r2, #0
mov r0, r7
pop {r1}
bx r1

DisplayFatigueStats:
@Ftg
ldr r0, SS_FatigueText
draw_textID_at 13, 3@, colour=White

ldr r3, MSSFatigueGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 17, 3

@Rbt
ldr r0, SS_RestedBonusThresholdText
draw_textID_at 21, 3@, colour=White

ldr r3, MSSRestedBonusThresholdGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 25, 3

@Frs
ldr r0, SS_FatigueRestoredText
draw_textID_at 13, 5@, colour=White

ldr r3, MSSFatigueRestoredGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 17, 5

@Noc
ldr r0, SS_FatigueUndeployedChapterText
draw_textID_at 21, 5@, colour=White

ldr r3, MSSFatigueUndeployedChapterGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 25, 5

SkipFatigueStats:
mov r0, r8
push {r5-r7}
@mov r5, #0x0 	@counter for bar id 
mov r5, #5
mov r7, #0x28 	@weapon rank offset (starts at sword)

LoopWeapons:
mov r6, r8 		@unit
ldrb r6, [r6, r7]
cmp r6, #0x0    @does unit have rank?
ble NoRank

mov     r0, r5        @bar id
mov     r1, #0x1
mov     r2, r5        @tile_y = 5 7 9 11 13 15 17 19 
mov     r3, r7        @weapon id - calculate from currentOffset
sub     r3, r3, #0x28
blh     DrawWeaponRank, r4        @08087864

@08016e50 GetWRankBarData
@08087828 bl 08086B2C
@zeroing out 08087828 will cause weapon rank bars to not appear

@08086B2C has two bls: 08086A40 and 08013104
	@08086A40: 080D1674, 080869D8, 08086960, 080869AC, 08086984, and 08086A08; overwritten at 08086AE2 by NegativeStatBoosts (not related to display issue)
	@08013104: no bls, but zeroing out will cause weapon rank bars to not appear
	
@pg2: ldr r4, =0x02020188
@080D74A0

add 	r5, #0x2 @increment bar counter
  
NoRank:
add r7, #0x1
cmp r7, #0x2F
ble LoopWeapons
b EndRanks

.ltorg

EndRanks:
pop {r5-r7}

blh      DrawSupports

page_end

.align
.ltorg

CheckIfRecruitOrFatigue:
