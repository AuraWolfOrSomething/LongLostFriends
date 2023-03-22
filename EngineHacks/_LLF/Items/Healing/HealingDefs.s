
@-------------------------
@Common
@-------------------------

.equ gActionData, 0x0203A958
.equ gpCurrentRound, 0x0203A608


@-------------------------
@NewUnitTryHeal
@-------------------------

@.equ PlaythroughStatsRAM, 0x02026E30
.equ blGetUnitEquippedItem, . + 0x08016B28 - origin
.equ blGetItemHealthBonus, . + 0x080163F0 - origin


@-------------------------
@NewExecStandardHeal
@-------------------------

.equ blGetUnit, . + 0x08019430 - origin
.equ blSetupSubjectBattleUnitForStaff, . + 0x0802CB24 - origin
.equ blSetupTargetBattleUnitForStaff, . + 0x0802CBC8 - origin
.equ blGetItemHealAmount, . + 0x08016FB8 - origin
.equ blUnitTryHeal, . + 0x080193A4 - origin
.equ blGetUnitCurrentHP, . + 0x08019150 - origin
.equ gTargetBattleUnit, 0x0203A56C
.equ blFinishUpItemBattle, . + 0x0802CC54 - origin
.equ blBeginBattleAnimations, . + 0x0802CA14 - origin


@-------------------------
@HealingItemEffect
@-------------------------

.equ gActiveBattleUnit, 0x0203A4EC
.equ GetUnit, 0x08019430
.equ SetupSubjectBattleUnitForStaff, 0x0802CB24
.equ UnitTryHeal, 0x080193A4
.equ GetUnitCurrentHP, 0x08019150
.equ FinishUpItemBattle, 0x0802CC54
.equ BeginBattleAnimations, 0x0802CA14


@-------------------------
@ItemHealingRoutine
@-------------------------

.equ MakeItem, 0x08016540


@-------------------------
@CheckStaffHealingEnhancement
@-------------------------

.equ CanUnitWieldWeapon, 0x08016574

