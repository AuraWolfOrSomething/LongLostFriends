
@-------------------
@Common
@-------------------

.equ gChapterData, 0x0202BCF0
.equ CheckEventID, 0x08083DA8
.equ m4aSongNumStart, 0x080D01FC


@-------------------
@Plan
@-------------------

.equ PlayerPhase_Suspend, 0x0801C894
.equ SetEventID, 0x08083D80 


@-------------------
@Act
@-------------------

.equ LoadSuspendedGame, 0x080A5C14
.equ EndBMAPMAIN, 0x080311F0
.equ gProcStatePool, 0x02024E68
.equ GameControl_8030FE4, 0x08030FE4

@For the funny bugged version of ActResetUnitPositions
@.equ StartMapMain, 0x080311BC
@.equ gProc_MapMain, 0x0859A1F0
@.equ ProcStart, 0x08002C7C
@.equ MapMain_ResumeFromPhaseIdle, 0x08031300


@-------------------
@Future
@-------------------

.equ ProcGoto, 0x08002F24

.equ GetChapterEventDataPointer, 0x080346B0

.equ gPopupNumber, 0x030005F8
.equ Popup_CreateExt, 0x08011490
.equ CallMapEventEngine, 0x0800D07C

.equ gProc_PlayerPhase, 0x0859AAD8
.equ ProcFind, 0x08002E9C
.equ ProcStartBlocking, 0x08002CE0

.equ Text_SetColorId, 0x08003E60
.equ String_GetFromIndex, 0x800A240
.equ Text_DrawString, 0x08004004
.equ GetBgMapBuffer, 0x08001C4C
.equ Text_Display, 0x08003E70

.equ MaxNumberOfTurnEventsToPlayForFaction, 8
.equ TurnLimit, 0x000003E6

