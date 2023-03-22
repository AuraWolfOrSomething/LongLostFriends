
If you want to make any adjustments to:

- PlaythroughStatsChapterSize
- PlaythroughStatsSuspendSize
- PlayerUnitRosterSize
- PlaythroughStatsRAM

...be sure to change the definition in each copy of RecordPlaythroughStatsDefinitions.asm. It is present outside of this folder.


Damage
0x2C1EC?


_________________________
--------Save Data--------
-------------------------

Per chapter played so far (can only store 26 chapters)
(offset, size)
0, 2: unit that accumulated the most fatigue, and how much fatigue
2, 2: unit that accumulated the second most fatigue, and how much fatigue
4, 2: unit that accumulated the third most fatigue, and how much fatigue

(for the units and accumulating fatigue, if is a tie, 0x80+number of units that tied)

6, 2: damage dealt on player phase
8, 2: damage dealt on enemy phase
0xA, 2: damage received
0xC, 2: damage healed
0xE, 2: experience gained
0x10, 1: (to be implemented) number of times powerful weapon/magic/staff/item was used
0x11, 1: number of enemies captured
0x12, 2: turncount (already kept track by the game, but since there's free space here...)
0x14, 4: (to be implemented) bitfield for side objectives completed

other ideas
- # of deployed units with Noc 3, # with Noc 2, # with Noc 1
- # of bargain items bought (could also allocate space for saving when the player has bought them in this chapter)
- total fatigue restored
- instead of bitfield for side objectives, could have a counter, but specific side objectives can be worth more than 1 point

____________________________
--------Suspend Data--------
----------------------------

(offset, size)
0, 0x3C: fatigue accumulated by unitID
0x3C, 2: damage dealt on player phase
0x3E, 2: damage dealt on enemy phase
0x40, 2: damage received
0x42, 2: damage healed
0x44, 2: experience gained
0x46, 1: number of times powerful weapon/magic/staff/item was used
0x47, 1: number of times an enemy was captured

