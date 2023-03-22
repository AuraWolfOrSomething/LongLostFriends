
.equ PlaythroughStatsChapterSize, 0x18 @24 dec
.equ PlaythroughStatsSuspendSize, 0x48 @72 dec
.equ PlayerUnitRosterSize, 0x3C @60 dec
.equ MaxAccRecStat, 0xFFFF

.equ PlaythroughStatsRAM, 0x02026E30
.equ ChapterDataStruct, 0x0202BCF0
.equ BattleUnitAttacker, 0x0203A4EC
.equ BattleUnitDefender, 0x0203A56C

.equ AfterBattleThingIRAM, 0x03003060
.equ ReadSramFastAddr, 0x030067A0 @has pointer to function (ldr twice)

.equ WriteAndVerifySramFast, 0x080D184C+1
