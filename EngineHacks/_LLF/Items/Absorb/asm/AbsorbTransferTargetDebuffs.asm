.thumb

.global AbsorbTransferTargetDebuffs
.type AbsorbTransferTargetDebuffs, %function


		AbsorbTransferTargetDebuffs:
		push	{r4-r7}
		mov		r5, r0
		mov		r6, r1
		ldr		r7, =UnitDebuffEntryList
		
		LoopThroughDebuffList:
		ldrb	r3, [r7]
		cmp		r3, #0xFF
		beq		End
		
			ldrb	r4, [r7,#1]
			ldrb	r1, [r5,r3]
			and		r1, r4
			cmp		r1, #0
			beq		NextDebuff
			
				ldrb	r0, [r6,r3]
				and		r0, r4
				cmp		r0, r1
				bge		CompleteTransfer
				
					mov		r0, r1
				
					CompleteTransfer:
					
					@Give staff user debuff that target had (unless debuff was less than what staff user will already have)
					mov		r2, #0xFF
					eor		r2, r4
					ldrb	r1, [r6,r3]
					and		r1, r2
					orr		r0, r1
					strb	r0, [r6,r3] 
					
					@Remove debuff from target
					ldrb	r0, [r5,r3]
					and		r0, r2
					strb	r0, [r5,r3]
					
					NextDebuff:
					add		r7, #2
					b		LoopThroughDebuffList
		
		End:
		pop		{r4-r7}
		bx		r14
		
		.align
		.ltorg

