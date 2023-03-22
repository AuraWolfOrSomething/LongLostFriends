
.thumb

.global EasyMovementPass
.type EasyMovementPass, %function

@Bx'd to from 3003D28
@This function sets the Z flag if the moving unit can cross the other unit's tile, either because they're either both allied/npcs or enemies, or because the mover has Pass

		EasyMovementPass:
		push  	{r0-r6,r14}   @actually necessary to push the scratch registers in this case
		
		CheckIfSameFaction:
		ldrb  	r0, [r3,#0xA]  @allegiance byte of current unit
		eor   	r0, r7     @r7 is allegiance byte of unit on tile we are looking at
		mov   	r1, #0x80
		tst		r0, r1
		beq		SetZFlag
		
		ldrb	r0, [r3,#0xA]  @allegiance byte of current unit
		lsr		r0, #6
		cmp		r0, #0
		b		GoBack
		
		SetZFlag:
		tst   	r0, r1
		
		GoBack:
		pop   	{r0-r6}
		pop   	{r4}
		mov   	r14, r4
		ldr   	r4,GoBackAddress
		bx    	r4

		.align

		GoBackAddress:
		.long 0x03003D34    @note that we need to switch back to arm

