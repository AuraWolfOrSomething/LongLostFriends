.thumb
.include "_Definitions.h.s"

.set prGetTargetPosition, EALiterals+0x00

SplitUpSelection_OnChange:
	push {r4-r7, lr}
	
	@ Saving Target Struct in r4
	mov r4, r1
	
	ldrb r0, [r4, #0]
	ldrb r1, [r4, #1]
	
	_blh prChangeActiveUnitFacing
	
	bl ClearRangeMoveMap
	_blh prMoveRange_HideGfx
	
	@Display blue square for active unit destination
	
	@ Loading Target Unit Struct
	ldrb r0, [r4, #2]
	_blh prUnit_GetStruct
	mov r7, r0
	
	@ Loading Active Unit Struct
	ldr r5, =ppActiveUnit
	ldr r5, [r5]
	
	@ [r1, r2] = [active.x, active.y]
	ldrb r1, [r5, #0x10]
	ldrb r2, [r5, #0x11]
	
	@ Getting Target position in [r1, r2]
	ldr r3, prGetTargetPosition
	_blr r3
	
	ldr r6, =ppMoveMapRows
	ldr r6, [r6]
	
	@ Loading row
	lsl r2, #2 @ y*4
	add r2, r6
	ldr r2, [r2]
	
	add r2, r1 @ x
	mov r0, #0
	strb r0, [r2]

	@Display blue square for target unit destination
	mov r0, r5
	
	@ [r1, r2] = [target.x, target.y]
	ldrb r1, [r7, #0x10]
	ldrb r2, [r7, #0x11]
	
	@ Getting Target position in [r1, r2]
	ldr r3, prGetTargetPosition
	_blr r3
	
	@ Loading row
	lsl r2, #2 @ y*4
	add r2, r6
	ldr r2, [r2]
	
	add r2, r1 @ x
	mov r0, #0
	strb r0, [r2]
	
	mov r0, #1 @ &1 = Blue Move Display
	_blh prMoveRange_ShowGfx
	
	pop {r4-r7}
	
	pop {r1}
	bx r1

.ltorg
.align

ClearRangeMoveMap:
	push {lr}
	
	ldr r3, =ppMoveMapRows
	
	ldr r0, [r3]
	mov r1, #1
	neg r1, r1
	
	_blh prMap_Fill
	
	ldr r3, =ppRangeMapRows
	
	ldr r0, [r3]
	mov r1, #0
	
	_blh prMap_Fill
	
	pop {r0}
	bx r0

.ltorg
.align

EALiterals:
	@ POIN prGetTargetPosition
