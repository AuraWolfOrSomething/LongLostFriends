.thumb

.global GetSkillUsageByte
.type GetSkillUsageByte, %function


		GetSkillUsageByte:
		mov		r0, #6 @location in unit debuff entry
		mov		r1, #0x0F @how much of the byte is for skill usage
		lsl		r1, #8
		add		r0, r1
		bx		r14
		
		.align

