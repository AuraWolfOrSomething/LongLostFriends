
@------------------------------------
@Common
@------------------------------------

.equ bl_GetUnit, . + 0x08019430 - origin
.equ bl_GetSupportDataIdForOtherUnit, . + 0x080283A8 - origin
.equ bl_GetROMUnitSupportCount, . + 0x080281C8 - origin
.equ FindSupportPartnerCharId, 0x080A0B20
.equ GetROMUnitSupportingId, 0x080281DC
.equ GetSupportDataIdForOtherUnit, 0x080283A8
.equ bl_GetCharacterData, . + 0x08019464 - origin
.equ bl_String_GetFromIndex, . + 0x0800A240 - origin
.equ String_GetFromIndex, 0x0800A240


@------------------------------------
@Active Support Functionality
@------------------------------------

@ActionSupport
.equ gActionData, 0x0203A958
.equ gActiveUnit, 0x03004E50
@.equ bl_CanUnitSupportCommandWith, . + 0x08028310 - origin
.equ bl_GainNextSupportRank, . + 0x080282DC - origin
.equ bl_GetSupportLevelBySupportIndex, . + 0x0802823C - origin

@ClearUnitSupports
.equ bl_GetUnitSupportingUnit, . + 0x080281F4 - origin

@Hook_SupportListShouldCursorAppear_Init
.equ bl_080AD47C, . + 0x080AD47C - origin
.equ bl_080AD4A0, . + 0x080AD4A0 - origin
.equ bl_080AD594, . + 0x080AD594 - origin
.equ BXR1, . + 0x080D18C4 - origin

@New_0xA2448
.equ gChapterData, 0x0202BCF0
.equ bl_m4aSongNumStart, . + 0x080D01FC - origin
.equ bl_ProcGoto, . + 0x08002F24 - origin
.equ bl_080A0AD4, . + 0x080A0AD4 - origin
.equ bl_080A2154, . + 0x080A2154 - origin
.equ bl_CursorRoutineThing, . + 0x080AD51C - origin

@SupportListSetNewActive
.equ GetUnitByCharId, 0x0801829C
.equ Text_InitFont, 0x08003C94
.equ Routine_080A20FC, 0x080A20FC
.equ Routine_080A1E7C, 0x080A1E7C

@SupportListShouldCursorAppear
.equ CursorRoutineThing, 0x080AD51C


@------------------------------------
@Active Support Display
@------------------------------------

@DrawUnitScreenSupportList
.equ StatScreenStruct, 0x02003BFC
@.equ Const_2003D34, 0x2003D34 @horizontal positioning
.equ Const_2003D3C, 0x2003D3C @new horizontal positioning
.equ bl_GetROMUnitSupportingId, . + 0x080281DC - origin
.equ bl_DrawIcon, . + 0x080036BC - origin
.equ bl_DrawTextInline, . + 0x0800443C - origin
.equ bl_0802823C, . + 0x0802823C - origin
.equ bl_080286EC, . + 0x080286EC - origin
.equ bl_DrawSpecialUiChar, . + 0x08004B0C - origin
.equ bl_BXR2, . + 0x080D18C8 - origin

@Hook_PrepSupportPairedEnding
.equ bl_Text_InsertString, . + 0x08004480 - origin
.equ bl_080AEBEC, . + 0x080AEBEC - origin
.equ bl_Text_SetXCursor, . + 0x08003E54 - origin
.equ bl_Text_SetColorId, . + 0x08003E60 - origin
.equ bl_Text_DrawNumberOr2Dashes, . + 0x08004144 - origin
.equ bl_Text_SetFont, . + 0x08003D38 - origin
.equ bl_BXR3, . + 0x080D18CC - origin
.equ someVRAMthing, 0x06015000
.equ gPal_UIFont, 0x0859EF00
.equ gCharacterData_1Indexed, 0x08803D64

@PrepSupportPairedEnding
.equ GetUnit, 0x08019430
.equ GetCharacterData, 0x08019464
.equ Text_InsertString, 0x08004480
.equ Text_SetFont, 0x08003D38

