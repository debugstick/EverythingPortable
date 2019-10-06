@ECHO OFF
CLS
COLOR 0A
TITLE "WGET VER CHECK TEST"

CALL :WGETVERCHECK

:WGETVERCHECK
CALL :WGETVERCHECK1
CALL :WGETVERCHECK2
ECHO %WGETVER% > ..\doc\wget_version.txt
EXIT /B

:WGETVERCHECK1
REM "DELIMS=" : PROCESS EACH LINE
REM ('') : COMMAND (EXECUTE)
FOR /F "DELIMS=" %%A IN ('..\bin\wget.exe --version') DO (
    SET "WGETVERTEXT=%%A"
    EXIT /B
)
EXIT /B

:WGETVERCHECK2
REM "TOKENS=3" : GET 3RD WORK
REM ("") : STRING (DONT EXECUTE)
FOR /F "TOKENS=3" %%B IN ("%WGETVERTEXT%") DO (
	SET "WGETVER=%%B"
)
EXIT /B