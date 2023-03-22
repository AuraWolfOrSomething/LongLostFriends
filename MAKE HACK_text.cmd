
@rem using two scripts that do mostly the same thing is annoying to maintain tbh
@rem so we let MAKE HACK_full do everything and do it slightly differently based on its argument

call "%~dp0MASTER MAKE HACK.cmd" updateText
