.thumb

.equ DZ_Continue, 0x0801B858|1
.equ DZ_NextUnit, 0x0801B930|1

.global DangerZoneIgnoresCaptives
.type DangerZoneIgnoresCaptives, %function


		DangerZoneIgnoresCaptives:
		ldr		r0, [r4]
		cmp		r0, #0
		beq		GoBack_NextUnit
		
			ldr		r0, [r4,#0x0C]
			mov		r1, #0x20
			tst		r0, r1
			bne		GoBack_NextUnit
		
				ldr		r1, [sp]
				ldr		r3, =DZ_Continue
				b		End
		
		GoBack_NextUnit:
		ldr		r3, =DZ_NextUnit
		
		End:
		bx		r3
		
		.align
		.ltorg

