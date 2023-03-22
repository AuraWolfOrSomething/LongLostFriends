
@----------------------------
@Common
@----------------------------

.equ FirstItemWithEffect, 0x4B @this should match what CoreTables/CoreTableDefinitions.event has
.equ NumberOfItemsWithEffect, 0xB4

.equ bl_GetItemIndex, . + 0x080174EC - origin


@----------------------------
@Condition
@----------------------------

.equ bl_GetItemAttributes, . + 0x0801756C - origin
.equ bl_CanUnitWieldStaff, . + 0x080167A4 - origin
.equ ConditionComplete, . + 0x08028BFE - origin
.equ CannotUseItem, . + 0x08028C04 - origin


@----------------------------
@Target
@----------------------------

.equ bl_ClearBG0BG1, . + 0x0804E884 - origin
.equ bl_EndFaceById, . + 0x08005758 - origin
.equ TargetComplete, . + 0x08029062 - origin
.equ DefaultTargetSelection, . + 0x0802905C - origin


@----------------------------
@Effect
@----------------------------

.equ gActionData, 0x0203A958
.equ gActiveBattleUnit, 0x0203A4EC

.equ bl_GetUnit, . + 0x08019430 - origin
.equ EffectComplete, . + 0x0802FF76 - origin

