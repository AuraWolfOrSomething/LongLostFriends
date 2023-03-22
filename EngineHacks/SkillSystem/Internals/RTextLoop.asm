@loop for r-text
.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.global RTextLoop
.type RTextLoop, %function

RTextLoop:
push {r4-r7,lr}
mov r4,r0
ldr r5, =0x2003bfc
ldr r0, [r5, #0xc]
ldr r1, =Skill_Getter
mov lr,r1
.short 0xf800
mov r6, r0 @save skill buffer
mov r7, r1 @save number of skills 
ldrb r2, [r0] @first skill
cmp r2, #0
bne HasSkills

@if unit has no skills, but directional input would put the cursor at a skill helptext location, check directional input
mov r0, r4
add r0, #0x50
ldrh r0, [r0]

@if down, keep going down
cmp r0, #0x80
beq GoDown

@if up, keep going up
cmp r0, #0x40
beq GoUp

@skills are on the right, so don't need to check for going left; if right, check which skill helptext cursor would be on before interfering
ldr r0, [r4,#0x2C]
ldr r1, =ST_Skill1
cmp r0, r1
beq GoUp
@if ST_Skill4, go down to con

GoDown:
mov r0, r4
blh 0x8089384
b	End

DefaultGoLeft:
mov r0, r4
blh      0x80893B4  @change to next one left
cmp r0, #1 @can it loop again?
beq End

HasSkills:
mov r1, r6
ldr     r0,[r4,#0x2C]     @current position           @ 08088B56 6AE0     
ldrh    r0,[r0,#0x12]     @slot number           @ 08088B58 8A40  
cmp r7, r0 @skill number vs total skills
ble CheckDir

add     r1,r1,r0                @ 08088B5E 1809     
ldrb    r0,[r1]           @skill number     @ 08088B60 8808     
cmp     r0,#0x0                @ 08088B62 2800     
bne     End       @has item, we're done here         @ 08088B64 D113

@if unit doesn't have a skill where the cursor would next be, check directional input
@if going down, keep going down
     
CheckDir:
mov     r0, r4
add     r0, #0x50
ldrh    r0, [r0]

@If up, keep going up
cmp     r0, #0x40
beq     GoUp

@If down, check number of skills
  @if unit has 4 or 5 skills, go to the left left (will redirect to unit's last skill after either this redirection or a second one)
  @otherwise, keep going down
cmp		r0,#0x80
bne		CheckIfRight

cmp r7, #4
blt	GoDown
b	GoLeft
     
@If right, go up
CheckIfRight:
cmp     r0,#0x10
bne     GoLeft

GoUp:
mov r0,r4
blh      #0x8089354    @change to next one up           @ 08088B7A F000FBEB 
b       End                @ 08088B7E E006     

GoLeft:     
mov     r0,r4                @ 08088B78 1C20     
blh 0x80893b4 @goes left
b End

@ loc_0x8088B84:
@ cmp     r0,#0x80   @down             @ 08088B84 2880     
@ bne     End                @ 08088B86 D102     
@ mov     r0,r4                @ 08088B88 1C20     
@ blh      0x8089384    @change to next one down            @ 08088B8A F000FBFB 
End:
pop     {r4-r7}                @ 08088B8E BC30     
pop     {r0}                @ 08088B90 BC01     
bx      r0                @ 08088B92 4700     

.ltorg
