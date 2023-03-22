.thumb
@r0 - Weapon level / stats to be changed
@r1 - Type of weapon equipped / offset of first stat to change
@r2 - Offset of second stat to change
@r3 - Offset of third stat to change
@r4 - offset of unit data in RAM


RANK_HACK_ST:
	push	{r2,r3}
	mov		r2,r4 @Checking for WTD
	mov		r2,#0x53 @The value of Weapon Triangle boosts are stored here
	ldsb	r3,[r4,r2]
	cmp		r3,#0x0
	bge		Continue @If you have WTA or neutrality, move to rank checking
	b		End
Continue:
	mov		r0,r4 @ This loads up your weapon level for whatever weapon you're holding
	add		r0,#0x28
	add		r0,r0,r1
	ldrb	r0,[r0] @Loads the weapon level of your equipped weapon
	WeaponCheck:
	cmp		r1,#0x7
	ble		Splitter
	b		End
	
Splitter:
	ldr r3, TableLocation
	@mov		r2,#0x8				@Each entry is 8 bytes long - Mt/hit boost for S/A/B/C ranks
	lsl r2, r1, #0x3 @mul		r2,r1
	add		r3,r2,r3			@Advances to your weapon's table
	mov		r1,#0x0             @Offset for S rank
	cmp		r0,#251
	bge		RankBonus
	mov		r1,#0x2             @Offset for A rank
	cmp		r0,#181
	bge		RankBonus
	mov		r1,#0x4             @Offset for B rank
	cmp		r0,#121
	bge		RankBonus
	mov		r1,#0x6             @Offset for C rank
	cmp		r0,#71
	blt		End
	
RankBonus:
	add		r3,r1				@Advance to the boost table for your weapon rank
	mov		r0,r4
	add		r0,#0x5A			@Offset of unit's Attack
	ldrh	r2,[r0]				@Load attack
	ldrb	r1,[r3]				@Load attack boost
	add		r2,r2,r1
	strh	r2,[r0]				@Store modified attack
	ldrh	r2,[r0,#0x6]		@Load hit
	ldrb	r1,[r3,#0x1]
	add		r2,r2,r1
	strh	r2,[r0,#0x6]
	@ldrh	r2,[r0,#0xC]		@Load crit
	@ldrb	r1,[r3,#0x2]
	@add		r2,r2,r1
	@strh	r2,[r0,#0xC]

	
End:
	pop		{r2,r3}
	pop		{r4} @ The following come from the original routine
	pop		{r0}
	bx		r0 @Back to normal code
	
.align
TableLocation:
    @handled by installer
