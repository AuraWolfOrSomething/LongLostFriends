@echo off

@rem USAGE: "MAKE HACK_full.cmd" [quick]
@rem If first argument is "quick", then this will not update text, tables, or generate a patch
@rem "MACK HACK_quick.cmd" simply calls this but with the quick argument, for convenience

@rem defining buildfile config

@rem set size of window
mode con: cols=180 lines=30

set "start_time=%TIME%"

set "source_rom=%~dp0FE8_clean.gba"

set "main_event=%~dp0BuildfileLLF.event"

set "target_rom=%~dp0LLFv0.1.2.gba"
set "target_ups=%~dp0LLFv0.1.2.ups"

@rem defining tools

set "c2ea=%~dp0Tools\C2EA\c2ea"
set "textprocess=%~dp0Tools\TextProcess\text-process-classic"
set "ups=%~dp0Tools\ups\ups"
set "parsefile=%~dp0EventAssembler\Tools\ParseFile.exe"

@rem set %~dp0 into a variable because batch is stupid and messes with it when using conditionals?

set "base_dir=%~dp0"

@rem do the actual building

echo Copying ROM

copy "%source_rom%" "%target_rom%"

if /I [%1]==[updateAll] (

  @rem only do the following if this is make hack full

  echo:
  echo Processing tables

  cd "%base_dir%Tables"
  echo: | ("%c2ea%" "%source_rom%")

  echo:
  echo Processing text

  cd "%base_dir%Text"
  echo: | ("%textprocess%" text_buildfile.txt --parser-exe "%parsefile%")

)

if /I [%1]==[updateTables] (

  @rem only do the following if this is make hack tables

  echo:
  echo Processing tables

  cd "%base_dir%Tables"
  echo: | ("%c2ea%" "%source_rom%")

)

if /I [%1]==[updateText] (

  @rem only do the following if this is make hack text

  echo:
  echo Processing text

  cd "%base_dir%Text"
  echo: | ("%textprocess%" text_buildfile.txt --parser-exe "%parsefile%")

)

echo:
echo Assembling

cd "%base_dir%EventAssembler"
ColorzCore A FE8 "-output:%target_rom%" "-input:%main_event%"

if /I [%1]==[updateAll] (

  @rem only do the following if this isn't a make hack quick

  echo:
  echo Generating patch

  cd "%base_dir%"
  "%ups%" diff -b "%source_rom%" -m "%target_rom%" -o "%target_ups%"

)

echo:
echo Done!

echo:
echo Started at  %start_time%
echo Finished at %TIME%

echo:
pause
