
.equ origin, 0x0801C940
.equ gGameState, 0x0202BCB0
.equ gChapterData, 0x0202BCF0 
.equ gMapUnit, 0x0202E4D8
.equ gMenu_MapMenu, 0x0859D214
.equ gActiveUnit, 0x03004E50

.equ bl_HandlePlayerCursorMovement, . + 0x0801C8AC - origin
.equ bl_FindNextCursorUnit, . + 0x0801DB4C - origin
.equ bl_m4aSongNumStart, . + 0x080D01FC - origin
.equ bl_BMXFADEExists, . + 0x0801DE18 - origin
.equ bl_CanShowUnitStatScreen, . + 0x0801C928 - origin
.equ bl_MU_EndAll, . + 0x080790A4 - origin
.equ bl_EndPlayerPhaseSideWindows, . + 0x0808D150 - origin
.equ bl_08086DE4, . + 0x08086DE4 - origin
.equ bl_StartStatScreen, . + 0x0808894C - origin
.equ bl_ProcGoto, . + 0x08002F24 - origin
.equ bl_GetUnitSelectionValueThing, . + 0x0801D51C - origin
.equ bl_ShowUnitSMS, . + 0x08028130 - origin
.equ bl_StartMenuAdjusted, . + 0x0804EB98 - origin
.equ bl_080832CC, . + 0x080832CC - origin
.equ bl_SetupActiveUnit, . + 0x0801865C - origin
.equ bl_BWL_IncrementMoveValue, . + 0x080A474C - origin
.equ bl_BreakProcLoop, . + 0x08002E94 - origin
.equ bl_Midway_HandleMapSpriteCursorHover, . + 0x08027ACA - origin
.equ bl_DangerZone, . + 0x080226F8 - origin
.equ bl_080A87C8, . + 0x080A87C8 - origin
.equ bl_HandleMapSpriteCursorHover, . + 0x08027A4C - origin
.equ bl_08027B0C, . + 0x08027B0C - origin
.equ bl_DisplayCursor, . + 0x08015A98 - origin

.equ bl_CheckEventID, . + 0x08083DA8 - origin
.equ bl_SetEventID, . + 0x08083D80 - origin
.equ bl_UnsetEventID, . + 0x08083D94 - origin
