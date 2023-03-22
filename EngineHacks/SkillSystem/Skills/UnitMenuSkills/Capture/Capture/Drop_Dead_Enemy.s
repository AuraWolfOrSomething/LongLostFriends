.thumb

.global Drop_Dead_Enemy
.type Drop_Dead_Enemy, %function

@set bit 0x1 of byte 1 if unit has 0 hp when being dropped
@jumped to from 183B0
@r2=char data of droppee

@r5 = dropper
@r6 = x coord (or 0 if giving/taking)
@r7 = y coord (or 0 if giving/taking)

Drop_Dead_Enemy:
push	{r14}
strb	r0,[r5,#0x1B]
strb	r0,[r4,#0x1B]
strb	r6,[r4,#0x10]
strb	r7,[r4,#0x11]
ldrb	r0,[r4,#0x13]
cmp		r0,#0x0
bne		End
@str		r0,[r4]

@check if 0 hp unit has Recapturable
@mov		r0, r4
@ldr		r1, =RecapturableLink
@ldrb	r1, [r1]
@ldr		r3, =SkillTester
@mov		lr, r3
@.short	0xF800
@cmp		r0, #0
@beq		MakeDeadForReal

@check if unit was dropped from "Drop" command
  @if from Drop, they become dead and leave the map
  @if not from Drop (combat), they stay on map
  
@ldr		r1, =0x0203A958
@ldrb	r0, [r1,#0x11]
@cmp		r0, #0xA
@beq		MakeDeadForReal

@regain 1 HP
@mov		r0, #1
@strb	r0, [r4,#0x13]
@b		End

MakeDeadForReal:
ldr		r0,[r4,#0xC]
mov		r1,#0x9 @make them dead?
orr		r0,r1
str		r0,[r4,#0xC]

End:
pop		{r0}
pop		{r4-r7}
pop		{r0}
bx		r0

.align
