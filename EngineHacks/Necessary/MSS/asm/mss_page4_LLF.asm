.thumb
.include "mss_defs.s"

.equ SS_FatigueText, PersonalInfoTable+4
.equ MSSFatigueGetter, SS_FatigueText+4
.equ SS_RestedBonusThresholdText, MSSFatigueGetter+4
.equ MSSRestedBonusThresholdGetter, SS_RestedBonusThresholdText+4
.equ SS_FatigueRestoredText, MSSRestedBonusThresholdGetter+4
.equ MSSFatigueRestoredGetter, SS_FatigueRestoredText+4
.equ SS_FatigueUndeployedChapterText, MSSFatigueRestoredGetter+4
.equ MSSFatigueUndeployedChapterGetter, SS_FatigueUndeployedChapterText+4

page_start

ldr r0, SS_FatigueText
draw_textID_at 13, 3@, colour=White @Ftg

ldr r3, MSSFatigueGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 17, 3

ldr r0, SS_RestedBonusThresholdText
draw_textID_at 21, 3@, colour=White @Rbt

ldr r3, MSSRestedBonusThresholdGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 25, 3

ldr r0, SS_FatigueRestoredText
draw_textID_at 13, 5@, colour=White @Frn

ldr r3, MSSFatigueRestoredGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 17, 5

ldr r0, SS_FatigueUndeployedChapterText
draw_textID_at 21, 5@, colour=White @Cuc

ldr r3, MSSFatigueUndeployedChapterGetter
mov r14, r3
mov r0, r8
.short 0xF800
draw_number_at 25, 5

draw_textID_at 13, 9, textID=0xd4c, width=16, colour=Blue

@ first like
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
adr    r0,PersonalInfoTable  @load first like
ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
@add    r1,#2
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh BufferText
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*9)+(2*17))
mov    r3, #0
blh    DrawText, r4
add    r7, #8

@ second like
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
adr    r0,PersonalInfoTable  @load first like
ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#2
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh BufferText
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*11)+(2*17))
mov    r3, #0
blh    DrawText, r4
add    r7, #8

draw_textID_at 13, 13, textID=0xd4d, width=16, colour=Blue

@ first dislike
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
adr    r0,PersonalInfoTable  @load first like
ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#4
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh BufferText
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*13)+(2*17))
mov    r3, #0
blh    DrawText, r4
add    r7, #8

@ second dislike
mov    r0,r8
ldr    r1,[r0]               @load character pointer
ldrb   r1,[r1,#0x4]	         @load character number
adr    r0,PersonalInfoTable  @load first like
ldr    r0,[r0]
mov    r2,#12
mul    r1,r2
add    r1,#6
ldrh   r0,[r0,r1]		@load textid
mov    r3, r7
mov r1, #12
ldrh r2,[r3] @current number
add r2,r1 @for the next one.
strb r1, [r3, #4] @store width
strb r2, [r3, #8] @assign the next one.
blh BufferText
mov    r2, #0x0
str    r2, [sp]
str    r0, [sp, #4]
mov    r2, #0 @colour
mov    r0, r7
ldr    r1, =(tile_origin+(0x20*2*15)+(2*17))
mov    r3, #0
blh    DrawText, r4
add    r7, #8

page_end

.align
.ltorg
PersonalInfoTable:
