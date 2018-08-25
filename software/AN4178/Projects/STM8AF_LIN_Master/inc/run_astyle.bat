@echo off

rem This batch file is used to launch Astyle software automatically.

set ASTYLE="C:\AStyle\bin\astyle.exe"
set OPTIONS_FILE="C:\AStyle\st_astylerc.txt"

rem %ASTYLE% -h

%ASTYLE% --options=%OPTIONS_FILE% .\*.h

pause
