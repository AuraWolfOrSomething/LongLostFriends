@This makes it so that status decay happens for the faction that just ended their phase, rather than the one that just started
@This doesn't include any of the code for zooming into units that fully recovered

.thumb

.equ origin, 0x08018858
.include "../StatusDebuffsDefs.s"

.global MapMain_UpdateUnitStatus
.type MapMain_UpdateUnitStatus, %function


		MapMain_UpdateUnitStatus:
		push	{r4-r7,lr}
		@mov		r4, r8
		@push	{r4}
		
		@Initialize unit list to zoom in on
		mov		r0, #0
		mov		r1, #0
		bl		bl_InitTargets
		
		@Don't lower NPC status duration until first NPC phase
		ldr		r3, =gChapterData
		ldrb	r0, [r3,#0x0F]
		ldrb	r1, [r3,#0x10]
		cmp		r1, #1
		bne		GoToGetPreviousFactionPhase
		
			cmp		r0, #0
			beq		End
				
				GoToGetPreviousFactionPhase:
				ldr		r1, =GetPreviousFactionPhase
				mov		lr, r1
				.short	0xF800
				ldrb	r0, [r0]
				add		r5, r0, #1 @unit to check
				mov		r6, r0
				add		r6, #0x40 @stop once all units of this faction have been checked
				
				@Initialize unit list to zoom in on
				@mov		r0, #0
				@mov		r8, r0
				@mov		r1, #0
				@bl			bl_InitTargets
				@b		CheckIfAllUnitsInFaction
		
		CheckForNextUnit: @08018878
		ldr		r1, =gUnitLookup
		mov		r0, #0xFF
		and		r0, r5
		lsl		r0, #2
		add		r0, r1
		ldr		r4, [r0]
		cmp		r4, #0
		beq		AddToFactionCount
		
			ldr		r0, [r4]
			cmp		r0, #0
			beq		AddToFactionCount
			
				ldr		r0, [r4,#0x0C]
				ldr		r1, =UnitState
				tst		r0, r1
				bne		AddToFactionCount
				
					mov		r3, r4
					add		r3, #0x31
					ldrb	r2, [r3]
					mov		r7, #0xF0
					mov		r12, r7
					mov		r0, r12
					and		r0, r2
					cmp     r0, #0
					beq     noBarrier
					
						lsr     r1, r2, #4
						sub     r1, #1
						lsl     r0, r1,#4
						
					noBarrier:
					mov     r1, #0xF
					and     r1, r2
					cmp 	r1, #0
					beq noTorch
					
						sub r1, #1
						mov r2, #1
						mov r8, r2
					
					noTorch: 
					orr 	r0, r1
					mov 	r3, r4
					add    	r3, #0x31
					strb 	r0, [r3]
					
					mov		r0, r4
					ldr		r3, =ProcessDebuffs
					mov		lr, r3
					.short	0xF800
					mov		r1, #0x30
					ldrb	r3, [r4,r1]
					mov		r0, r12
					and		r0, r3
					cmp		r0, #0
					beq		AddToFactionCount
					
						mov		r2, #0x0F
						and		r2, r3
						@check if unit has recovery status (just used for eggs in vanilla)
						cmp		r2, #0x0A
						beq		AddToFactionCount
		
							@lower by 1; if 0, clear status
							lsr		r0, r3, #4
							sub		r0, #1
							cmp		r0, #0
							ble		StoreDecrementedStatus
							
								lsl		r0, #4
								orr		r0, r2
							
							StoreDecrementedStatus:
							strb	r0, [r4,r1]
		
			AddToFactionCount:
			add		r5, #1
			
			CheckIfAllUnitsInFaction: @08018922
			cmp		r5, r6
			blt		CheckForNextUnit
		
				@mov		r0, r8
				@cmp		r0, #0
				@beq		End
				
					@bl		bl_InitMapChangeGraphics
					@bl		bl_RefreshEntityMaps
					@bl		bl_DrawTileGraphics
					@mov		r0, #1
					@bl		bl_StartBMXFADE
					@bl		bl_SMS_UpdateFromGameData
					
					@ldr		r3, =InitMapChangeGraphics
					@mov		lr, r3
					@.short	0xF800
					@ldr		r3, =RefreshEntityMaps
					@mov		lr, r3
					@.short	0xF800
					@ldr		r3, =DrawTileGraphics
					@mov		lr, r3
					@.short	0xF800
					@mov		r0, #1
					@ldr		r3, =StartBMXFADE
					@mov		lr, r3
					@.short	0xF800
					@ldr		r3, =SMS_UpdateFromGameData
					@mov		lr, r3
					@.short	0xF800
		
		End:
		@pop		{r4}
		@mov		r8, r4
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

