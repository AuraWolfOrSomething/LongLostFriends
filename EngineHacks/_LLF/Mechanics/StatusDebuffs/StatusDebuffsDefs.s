
.equ UnitState, 0x0001002C
.equ Short16F, 0x0000016F
.equ Short1128, 0x00001128

.equ gChapterData, 0x0202BCF0
.equ VramOffset, 0x06002DE0
.equ gUnitLookup, 0x0859A5D0
.equ Const_2003CA4, 0x02003CA4

.equ bl_InitTargets, . + 0x0804F8A4 - origin
.equ bl_InitMapChangeGraphics, . + 0x08019CBC - origin
.equ bl_RefreshEntityMaps, . + 0x0801A1F4 - origin
.equ bl_DrawTileGraphics, . + 0x08019C3C - origin
.equ bl_StartBMXFADE, . + 0x0801DDC4 - origin
.equ bl_SMS_UpdateFromGameData, . + 0x080271A0 - origin

@.equ InitTargets, 0x0804F8A4
@.equ InitMapChangeGraphics, 0x08019CBC
@.equ RefreshEntityMaps, 0x0801A1F4
@.equ DrawTileGraphics, 0x08019C3C
@.equ StartBMXFADE, 0x0801DDC4
@.equ SMS_UpdateFromGameData, 0x080271A0

.equ CpuFastSet, 0x080D1674
.equ String_GetFromIndex, 0x800A240
.equ Text_InsertString, 0x8004480
.equ DrawUiSmallNumber, 0x08004BE4
.equ DrawUiNumberOrDoubleDashes, 0x08004B94

.equ Text_Clear, 0x08003DC8
.equ Text_InsertNumberOr2Dashes, 0x080044A4 
