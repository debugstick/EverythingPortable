@echo off
setlocal enabledelayedexpansion
Color 0A
cls
title PORTABLE STEAM LAUNCHER
set nag=BE SURE TO TURN CAPS LOCK OFF! (never said it was on just make sure)
set new_version=OFFLINE
if exist replacer.bat del replacer.bat
if "%~1" neq "" (call :%~1 & exit /b !current_version!)

:FOLDERCHECK
cls
if not exist .\bin\steam\ mkdir .\bin\steam\
if not exist .\data\AppData\ mkdir .\data\AppData\
if not exist .\data\AppData\Local\ mkdir .\data\AppData\Local\
if not exist .\data\AppData\Roaming\ mkdir .\data\AppData\Roaming\
if not exist .\dll\32\ mkdir .\dll\32\
if not exist .\doc\ mkdir .\doc\
if not exist .\extra\ mkdir .\extra\
if not exist .\ini\ mkdir .\ini\
call :VERSION
goto CREDITS

:VERSION
cls
echo 15 > .\doc\version.txt
set /p current_version=<.\doc\version.txt
if exist .\doc\version.txt del .\doc\version.txt
exit /b

:CREDITS
cls
if exist .\doc\steam_license.txt goto STEAMCHECK
echo ================================================== > .\doc\steam_license.txt
echo =              Script by MarioMasta64            = >> .\doc\steam_license.txt
echo =           Script Version: v%current_version%- release        = >> .\doc\steam_license.txt
echo ================================================== >> .\doc\steam_license.txt
echo =You may Modify this WITH consent of the original= >> .\doc\steam_license.txt
echo = creator, as long as you include a copy of this = >> .\doc\steam_license.txt
echo =      as you include a copy of the License      = >> .\doc\steam_license.txt
echo ================================================== >> .\doc\steam_license.txt
echo =    You may also modify this script without     = >> .\doc\steam_license.txt
echo =         consent for PERSONAL USE ONLY          = >> .\doc\steam_license.txt
echo ================================================== >> .\doc\steam_license.txt

:CREDITSREAD
cls
title PORTABLE STEAM LAUNCHER - ABOUT
for /f "DELIMS=" %%i in (.\doc\steam_license.txt) do (echo %%i)
pause

:STEAMCHECK
cls
if not exist .\bin\steam\steam.exe goto ARCHCHECK
goto WGETUPDATE

:ARCHCHECK
cls
set arch=
if exist "%PROGRAMFILES(X86)%" set arch=64

:FILECHECK
cls
if not exist .\extra\SteamSetup.exe goto DOWNLOADSTEAM
if not exist .\bin\7-ZipPortable\7-ZipPortable.exe goto 7ZIPINSTALLERCHECK
.\bin\7-ZipPortable\App\7-Zip%arch%\7z.exe e .\extra\SteamSetup.exe steam.exe -o.\bin\steam\
goto STEAMCHECK

:DOWNLOADSTEAM
cls
title PORTABLE STEAM LAUNCHER - DOWNLOAD STEAM
if exist SteamSetup.exe goto MOVESTEAM
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe -q --show-progress https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe

:MOVESTEAM
cls
move SteamSetup.exe .\extra\SteamSetup.exe
goto FILECHECK

:7ZIPINSTALLERCHECK
if not exist .\extra\7-ZipPortable_16.04.paf.exe goto DOWNLOAD7ZIP
title PORTABLE STEAM LAUNCHER - RUNNING 7ZIP INSTALLER
.\extra\7-ZipPortable_16.04.paf.exe /destination="%CD%\bin\"
goto FILECHECK

:DOWNLOAD7ZIP
cls
title PORTABLE STEAM LAUNCHER - DOWNLOAD 7ZIP
if exist 7-ZipPortable_16.04.paf.exe goto MOVE7ZIP
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe -q --show-progress http://downloads.sourceforge.net/portableapps/7-ZipPortable_16.04.paf.exe

:MOVE7ZIP
cls
move 7-ZipPortable_16.04.paf.exe .\extra\7-ZipPortable_16.04.paf.exe
goto FILECHECK

:WGETUPDATE
::cls
:: title PORTABLE STEAM LAUNCHER - UPDATE WGET
:: wget https://eternallybored.org/misc/wget/current/wget.exe
:: move wget.exe .\bin\
goto MENU

:DOWNLOADWGET
cls
.\bin\wget.exe call :CHECKWGETDOWNLOADER
exit /b

:CHECKWGETDOWNLOADER
cls
if not exist .\bin\downloadwget.vbs call :CREATEWGETDOWNLOADER
if exist .\bin\downloadwget.vbs call :EXECUTEWGETDOWNLOADER
exit /b

:CREATEWGETDOWNLOADER
cls
echo ' Set your settings > .\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> .\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo ' Fetch the file >> .\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> .\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> .\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> .\bin\downloadwget.vbs
echo objADOStream.Open >> .\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> .\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> .\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> .\bin\downloadwget.vbs
echo Set objFSO = Nothing >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> .\bin\downloadwget.vbs
echo objADOStream.Close >> .\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> .\bin\downloadwget.vbs
echo End if >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> .\bin\downloadwget.vbs
exit /b

:EXECUTEWGETDOWNLOADER
cls
title PORTABLE OBS LAUNCHER - DOWNLOAD WGET
cscript.exe .\bin\downloadwget.vbs
move wget.exe .\bin\
exit /b

:MENU
cls
title PORTABLE STEAM LAUNCHER - MAIN MENU
echo %NAG%
set nag=SELECTION TIME!
echo 1. reinstall steam [not a feature yet]
echo 2. launch steam
echo 3. reset steam [not a feature yet]
echo 4. uninstall steam [not a feature yet]
echo 5. update program
echo 6. about
echo 7. exit
echo.
echo a. download dll's
echo.
echo b. download other projects
echo.
echo c. write a quicklauncher
echo.
echo d. type your steam login [to automatically login between pc]
echo e. remove steam login [to not login automatically]
echo.
set /p choice="enter a number and press enter to confirm: "
if "%choice%"=="1" goto NEW
if "%choice%"=="2" goto DEFAULT
if "%choice%"=="3" goto SELECT
if "%choice%"=="4" goto DELETE
if "%choice%"=="5" goto UPDATECHECK
if "%choice%"=="6" goto ABOUT
if "%choice%"=="7" goto EXIT
if "%choice%"=="a" goto DLLDOWNLOADERCHECK
if "%CHOICE%"=="b" goto PORTABLEEVERYTHING
if "%CHOICE%"=="c" goto QUICKLAUNCHERCHECK
if "%CHOICE%"=="d" goto STEAMINIMAKER
if "%CHOICE%"=="e" del .\ini\steam.ini>nul:
set nag="PLEASE SELECT A CHOICE 1-7 or a/b/c/d/e"
goto MENU

:DLLDOWNLOADERCHECK
if not exist launch_dlldownloader.bat goto DOWNLOADDLLDOWNLOADER
start launch_dlldownloader.bat
goto MENU

:DOWNLOADDLLDOWNLOADER
cls
title PORTABLE STEAM LAUNCHER - DOWNLOAD DLL DOWNLOADER
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe -q --show-progress https://raw.githubusercontent.com/MarioMasta64/DLLDownloaderPortable/master/launch_dlldownloader.bat
cls
goto DLLDOWNLOADERCHECK

:NULL
cls
set nag="NOT A FEATURE YET!"
goto MENU

:NEW
cls
goto NULL

:DEFAULT
:: cls
:: title DO NOT CLOSE - Steam is Running
:: xcopy /q ".\data\AppData\locallow\*" "%UserProfile%\data\AppData\LocalLow" /e /i /y
set path="%PATH%;%CD%\dll\32\;"
set "COMMONPROGRAMFILES(X86)=%CD%\bin\CommonFiles\"
set "LOCALAPPDATA=%CD%\data\AppData\Local"
set "APPDATA=%CD%\data\AppData\Roaming"
:: cls
:: echo STEAM IS RUNNING
setlocal enabledelayedexpansion
if exist .\ini\steam.ini ( 
  for /f "delims=" %%a in (.\ini\steam.ini) do ( 
    set "a=%%a" 
    if "!a:~1,5!"=="User:" set "user=!a:~6,-1!" 
    if "!a:~1,5!"=="Pass:" set "pass=!a:~6,-1!" 
  ) 
  start .\bin\steam\steam.exe -login "!user!" "!pass!" 
) 
if not exist .\ini\steam.ini start .\bin\steam\steam.exe 
:: goto EXIT
exit

:SELECT
cls
title PORTABLE STEAM LAUNCHER - RESET STEAM
echo %NAG%
set nag=SELECTION TIME!
echo type "yes" to reset steam
echo or anything else to cancel
set /p choice="are you sure: "
if "%choice%"=="yes" goto NOWRESETTING
goto MENU

:NOWRESETTING
goto NULL

:DELETE
goto NULL

:UPDATECHECK
cls
if exist version.txt del version.txt
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe -q --show-progress https://raw.githubusercontent.com/MarioMasta64/EverythingPortable/master/version.txt
cls
set Counter=0 & for /f "DELIMS=" %%i in ('type version.txt') do (set /a Counter+=1 & set "Line_!Counter!=%%i")
if exist version.txt del version.txt
set new_version=%Line_6%
if "%new_version%"=="OFFLINE" goto ERROROFFLINE
if %current_version% EQU %new_version% goto LATEST
if %current_version% LSS %new_version% goto NEWUPDATE
if %current_version% GTR %new_version% goto NEWEST
goto ERROROFFLINE

:LATEST
cls
title PORTABLE STEAM LAUNCHER - LATEST BUILD :D
echo you are using the latest version!!
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
goto MENU

:NEWUPDATE
cls
title PORTABLE STEAM LAUNCHER - OLD BUILD D:
echo %NAG%
set nag=SELECTION TIME!
echo you are using an older version
echo enter yes or no
echo Current Version: v%current_version%
echo New Version: v%new_version%
set /p choice="Update?: "
if "%choice%"=="yes" goto UPDATE
if "%choice%"=="no" goto MENU
set nag="please enter YES or NO"
goto NEWUPDATE

:UPDATE
cls
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe -q --show-progress https://raw.githubusercontent.com/MarioMasta64/EverythingPortable/master/launch_steam.bat
cls
if exist launch_steam.bat.1 goto REPLACERCREATE
goto ERROROFFLINE

:REPLACERCREATE
cls
echo @echo off > replacer.bat
echo Color 0A >> replacer.bat
echo del launch_steam.bat >> replacer.bat
echo rename launch_steam.bat.1 launch_steam.bat >> replacer.bat
echo start launch_steam.bat >> replacer.bat
echo exit >> replacer.bat
start replacer.bat
exit

:NEWEST
cls
title PORTABLE STEAM LAUNCHER - TEST BUILD :0
echo YOURE USING A TEST BUILD MEANING YOURE EITHER
echo CLOSE TO ME OR YOURE SOME SORT OF PIRATE
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
start launch_steam.bat
exit

:ABOUT
cls
del .\doc\steam_license.txt
start launch_steam.bat
exit

:PORTABLEEVERYTHING
cls
title PORTABLE STEAM LAUNCHER - DOWNLOAD SUITE
if not exist .\bin\wget.exe call :DOWNLOADWGET
if not exist launch_everything.bat .\bin\wget.exe -q --show-progress https://raw.githubusercontent.com/MarioMasta64/EverythingPortable/master/launch_everything.bat
cls
start launch_everything.bat
exit

:QUICKLAUNCHERCHECK
cls
title PORTABLE STEAM LAUNCHER - QUICKLAUNCHER WRITER
echo @echo off > quicklaunch_steam.bat
echo Color 0A >> quicklaunch_steam.bat
:: echo cls >> quicklaunch_steam.bat
:: echo title DO NOT CLOSE - Steam is Running >> quicklaunch_steam.bat
:: echo xcopy /q ".\data\AppData\locallow\*" "%%sUserProfile%%\data\AppData\LocalLow" /e /i /y >> quicklaunch_steam.bat
echo set path="%%PATH%%;%%CD%%\dll\32\;" >> quicklaunch_steam.bat
echo set "COMMONPROGRAMFILES(X86)=%%CD%%\bin\commonfiles\">> quicklaunch_steam.bat
echo set "LOCALAPPDATA=%%CD%%\data\AppData\local\" >> quicklaunch_steam.bat
echo set "APPDATA=%%CD%%\data\AppData\roaming\" >> quicklaunch_steam.bat
echo setlocal enabledelayedexpansion >> quicklaunch_steam.bat
echo if exist .\ini\steam.ini ( >> quicklaunch_steam.bat
echo   for /f "delims=" %%%%a in (.\ini\steam.ini) do ( >> quicklaunch_steam.bat
echo     set "a=%%%%a" >> quicklaunch_steam.bat
echo     if "^!a:~1,5^!"=="User:" set "user=^!a:~6,-1^!" >> quicklaunch_steam.bat
echo     if "^!a:~1,5^!"=="Pass:" set "pass=^!a:~6,-1^!" >> quicklaunch_steam.bat
echo   ) >> quicklaunch_steam.bat
echo   start .\bin\steam\steam.exe -login "^!user^!" "^!pass^!" >> quicklaunch_steam.bat
echo ) >> quicklaunch_steam.bat
echo if not exist .\ini\steam.ini start .\bin\steam\steam.exe >> quicklaunch_steam.bat
:: echo xcopy /q "%%UserProfile%%\data\data\AppData\LocalLow\*" .\data\AppData\locallow /e /i /y >> quicklaunch_steam.bat
:: echo rmdir /s /q "%%UserProfile%%\data\AppData\LocalLow" >> quicklaunch_steam.bat
echo exit >> quicklaunch_steam.bat
echo A QUICKLAUNCHER HAS BEEN WRITTEN TO: quicklaunch_steam.bat
pause
exit

:STEAMINIMAKER
cls
set /p username="username: "
set /p password="password: "
echo "User:%username%"> .\ini\steam.ini
echo "Pass:%password%">> .\ini\steam.ini
echo steam login saved to .\ini\steam.ini
pause
goto MENU

:ERROROFFLINE
cls
set nag="YOU SEEM TO BE OFFLINE PLEASE RECONNECT TO THE INTERNET TO USE THIS FEATURE"
goto MENU

:EXIT
xcopy /q "%UserProfile%\data\AppData\LocalLow\*" .\data\AppData\LocalLow /e /i /y
rmdir /s /q "%UserProfile%\data\AppData\LocalLow"
exit