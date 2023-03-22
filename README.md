
## HelpText
This assembly changes how information accessed through helptext can be viewed. There's two main things to note here:
- You can add additional elements to how a text id is displayed. In vanilla, weapons have shared characteristics such as might and weight, but they also have values in those elements. You can use the way the game presents these variables for other information.
- More than one text id can be assigned to a single thing. During gameplay, the player can press "A" to access the next text id. I didn't get around to doing every time the player can view helptext for items, but I got the more essential times covered.

If you want to make a new module, I recommend looking at the Skills module for reference, as that's the latest one that I've done. Before I end this section, shoutouts to Vesly for his ExtendWeaponDescBox assembly.


## Planning
Shoutouts to Vesly once again for his DebugPlaceUnits assembly, which is used as a base and also gave me inspiration for this idea. When the player turns planning on with the map menu command Plan, they can now also move and act with enemies, NPCs, and grayed out units. You can go to spots that units wouldn't normally be able to go to as well. The Future command is also accessible. This command plays the next closest turn event(s). The player can't win or lose while planning. Attempting to resume the game will bring the player to the point before selecting Plan, but selecting Act will also do this.

In its current version, the chapter events need some "edits" to fully utilize this/avoid the free win exploit. Feel free to take a look at the events in LLF if you are considering including this mechanic.


## Items
There's a few new items in here. Yep.

One thing I want to actually note is that I changed the debuff system that comes with SkillSystem for new stuff. There are a few items that are made with those changes in mind, so they can't be separately ported without either further edits or completely adopting the debuff system used by LLF.

## Supports
LLF isn't a particularly long hack at this point, but I wanted to tinker with the GBA system in advance.
- Support points are gained at the end of the chapter. Regardless of if the units are deployed or not, each pair will gain progress to the next rank, but they get 50% more if they're both undeployed OR 100% more if they're both deployed.
- You can reach A rank with all partners, but only 1 support can be "active" at a time. Once you've unlocked a second partner, you can switch the active partner during preparations in the Supports screen by selecting the unit and pressing "A" on the new partner you want active.
- I sacrificed the 7th support partner slot for saving which partner is active.
- Since the "Remaining x" text isn't useful, I changed it for displaying whether or not a unit is "set" to have a paired ending with someone or not. If a unit has an A-rank support with their current active partner, you can press "A" on that same screen to "set" the ending to be paired.  I keep saying "set" because there currently isn't anything that actually checks for this in the credits (i.e. it's not an actual feature yet), but if there's someone that wants to look into it, there's at least a baseline for it to exist. Or something.
- Affinity bonuses can now provide 1/10 of a point instead of 1/2 of a point in any stat. I wanted all affinities to have at least +1 Atk and Def by A rank, but I also wanted them to have unique bonuses, so...yeah.


## Non-LLF code
Finally, I also want to note some edits I made to engine hacks that aren't in the _LLF folder. I didn't want to add them into the _LLF even if they were externally downloaded and added in because I didn't make them, but I still wanted to list any changes of the top of my head in case someone randomly uses this as a base for their own stuff.

ExternalHacks
- EscapeArrive: Commented out some inline edits (related: _LLF/QoL/EscapeTheEscapeSoftlock)
- Fatigue: Does not affect ability to deploy a unit, undeploying restores some fatigue and gives units extra exp (and temporary stats if fatigue is low enough)
- PreventTrade: Added a check specifically for HeavyHoveringBoots
- RandomizeRNs: Added ExpandedModularSave module 
- UnitStatOffsets: Changed where it hooks, now reads off of a table indexed by chapter ID

Necessary
- Antihuffman: In AntihuffmanString_GetFromIndex, added comparison to see if r5 is 0 before doing a comparison between r0 and r5
- CalcLoops: BattleProcCalcLoop/ProcStart/proc_start has added functionality for Perfectus, Glancing Blows, and Skl advantage guaranteeing crits with Killer weapons; WeaponUsabilityCalcLoop/CanUnitWieldWeapon will prevent items with 0 uses on ItemResetList from being wielded;  WeaponUsabilityCalcLoop/DoesUnitHaveWRank will go to WeaponRankModifierLoop to determine unit's current Weapon Rank
- ExpandedModularSave: Suspend data won't update if planning, save more bytes for non-player units, save 4 bytes intended for managing two currencies, save rns before beginning battle
- GrowthGetters: Added check for Learning Ring
- IconRework: Something about fixing a sword being displayed instead of a mounted icon when rescuing units
- ItemRangeFix: Added check for LastLegs. For a previous project, I think I had some weird issue with Capture, so there's some change related to that in here
- MSS: Adjusted formats for Page 1 and 3, replaced "Equipment" with AS on Page 2, added some stuff to work with helptext changes
- StatGetters: Commented some getters (only one worthing noting is hp from equipped items), added new ones
- SuspendDebuffs: Replaced existing format with a new format specifically for LLF (related: Mechanics/StatusDebuffs)
- UnitMenu: Added Draw Back, Split Up, Cross, and Advance; changed entry for Wait

QualityOfLife
- BattleStatsWithAnimsOff: New icons by Alusq
- HpBars: New bars by Alusq, removed two of the hp bars (adjusted calculation with this in mind), added buff & debuff arrow displays
- ModularMinimugBox: AI can be displayed over Name (related: _LLF/QoL/AiToggle), added check for Prime Five being active
- ShowHealAmount: Added passing the target unit for calculation (mostly for a gimmick staff healing formula that is userLuck + targetLuck)

SkillSystem
- Commented a lot of unused skills, added some skills (see _LLF/Skills)
- Commented Acrobat for a new version that cooperates with _LLF/Mechanics/TerrainMovementCost
- Commented out SkillDescGetter for a new version in HelpText
- Edited RTextLoop to make helptext cursor flow more smoothly
- GetSkill: If units have Canto as class skill, they do not get access to personal skill; Enemies/NPCs will read Fatigue byte as an additional skill

