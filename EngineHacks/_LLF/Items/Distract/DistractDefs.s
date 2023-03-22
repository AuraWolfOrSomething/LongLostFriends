
@----------------------------
@Common
@----------------------------

.equ gActionData, 0x0203A958
.equ GetUnit, 0x08019430


@----------------------------
@Distract Condition
@----------------------------

.equ IsGeneratedTargetListEmpty, 0x08029068
.equ AddTarget, 0x0804F8BC


@----------------------------
@Distract Target
@----------------------------

.equ StartTargetSelectionExt, 0x0804FAA4
.equ gSelect_GenericStaff, 0x0859D2F8 
.equ EndTargetSelection, 0x0804FAB8 
.equ FillMovementMapForUnitAndMovement, 0x0801A3CC

.equ gMapRange, 0x0202E4E4
.equ gActiveUnit, 0x03004E50
.equ gBg2MapBuffer, 0x02023CA8
.equ gChapterData, 0x0202BCF0
.equ gGameState, 0x0202BCB0
.equ gMapUnit, 0x0202E4D8

.equ gProc_GoBackToUnitMenu, 0x0859B600

.equ ProcStart, 0x08002C7C
.equ m4aSongNumStart, 0x080D01FC

.equ String_GetFromIndex, 0x0800A240
.equ StartBottomHelpText, 0x08035708
.equ EnsureCameraOntoPosition, 0x08015E0C

.equ BreakProcLoop, 0x08002E94
.equ EndItemEffectSelectionThing, 0x0802951C
.equ FillBgMap, 0x08001220
.equ EnableBgSyncByMask, 0x08001FAC
.equ ProcGoto, 0x08002F24
.equ HandlePlayerCursorMovement, 0x0801C8AC

.equ Text_ResetTileAllocation, 0x08003D20
.equ HideMoveRangeGraphics, 0x0801DACC
.equ EndBottomHelpText, 0x08035748
.equ SetCursorMapPosition, 0x08015BBC

.equ gAP_SelectCursorThing, 0x085A0EA0
.equ AP_Create, 0x0800927C
.equ AP_SetAnimation, 0x08009518
.equ AP_Update, 0x080092BC
.equ AP_Delete, 0x080092A4

.equ gMapMovement, 0x0202E4E0
.equ gMapMovement2, 0x0202E4F0

.equ ClearMapWith, 0x080197E4
.equ DisplayMoveRangeGraphics, 0x0801DA98


@----------------------------
@Distract Effect
@----------------------------

.equ gTargetBattleUnit, 0x0203A56C
.equ gEventSlot1, 0x030004BC
.equ gEventSlot2, 0x030004C0
.equ gEventSlotB, 0x030004E4

.equ SetupSubjectBattleUnitForStaff, 0x0802CB24
.equ FinishUpItemBattle, 0x0802CC54
.equ BeginBattleAnimations, 0x0802CA14
.equ CallMapEventEngine, 0x0800D07C
