.thumb

.global OverwriteAiIsUnitExceptionFunction
.type OverwriteAiIsUnitExceptionFunction, %function


		OverwriteAiIsUnitExceptionFunction:
		ldr		r1, =OverwriteAiIsUnitExceptionFunction
		ldr		r3, =AiTargetExceptionCheck
		bx		r3

