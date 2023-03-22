
.equ UnitState, 0x00010004 @RS (dead, REMU)
@.equ UnitState, 0x0001000C @vanilla (dead, not deployed, REMU)
.equ gChapterData, 0x0202BCF0
.equ bl_GetUnit, . + 0x08019430 - origin
.equ bl_GetUnitTotalSupportLevels, . + 0x08028264 - origin
.equ bl_GetROMUnitSupportCount, . + 0x080281C8 - origin
.equ bl_GetUnitSupportingUnit, . + 0x080281F4 - origin
.equ bl_AddSupportPoints, . + 0x08028290 - origin
.equ bl_BXR3, . + 0x080D18CC - origin

.equ gSupportConvoReadyValueList, 0x0859B9A8
.equ bl_GetSupportLevelBySupportIndex, . + 0x0802823C - origin
