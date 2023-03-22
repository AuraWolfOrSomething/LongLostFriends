This hack will allow you to set stat modifiers for units when they are loaded
in UNIT data, for instance if you wanted a Levin Sword Myrmidon to have higher
Magic than his fellows without dedicating a separate character slot to this
function.

With this hack, byte +0x6 in UNIT data (labelled ?? in FEBuilder) will function
as an index to a stat modifier table. If it is 0, no stat mods will be applied.

Each entry in the stat modifier table is ten bytes long, one after the other, in
this format:

+0: Max HP
+1: Strength/Magic
+2: Skill
+3: Speed
+4: Defence
+5: Resistance
+6: Luck
+7: Constitution modifier
+8: Movement modifier
+9: Magic*

*For those using the Strength/Magic split; do not use otherwise

Stat modifiers are applied after autoleveling. Negative modifiers are possible,
but if the sum of the stat and modifier comes to a negative number, it will be
floored at zero, or one for HP. 

By default the table is placed at 0xB50000; you are encouraged to change this to
an offset suited to your needs. Note that entries begin at this offset; you do
not need to have a pointer ten bytes before a round number or anything like that.

Install by using #include to add StatOffset.event to your buildfile, then
building your stat offset table.

-Vennobennu