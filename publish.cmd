@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET my_path=%~dp0
SET mod_path=%1
SET mod_path=%mod_path:"=%
FOR %%f IN (%mod_path%) DO SET mod_name=%%~nxf
SET mod_path_src=%mod_path%\src
SET mod_path_out=%mod_path%\out
SET fs17_mods_path=%USERPROFILE%\Documents\My Games\FarmingSimulator2017\mods\
SET fs17_mod_path=%fs17_mods_path%%mod_name%

ECHO #################################### Starting build of %mod_name% ####################################

PUSHD %mod_path_src%
IF NOT EXIST "%TEMP%\%mod_name%\" (
    MKDIR "%TEMP%\%mod_name%\"
)

ECHO #################################### Starting debug of %mod_name% ####################################

SET /a count = 0
FOR /R %%I IN (*.lua) DO (
	call "C:\Program Files\luapower\luajit" -bg "%%~dpnI.lua" "%TEMP%\%mod_name%\%%~nI.luc"
    SET /a count += 1
)
ECHO %count% File debugged
POPD

ECHO #################################### %mod_name% built ####################################

ECHO ############################## Starting publish of %mod_name% ##############################

IF EXIST "%mod_path_out%\%mod_name%.zip" (
    DEL "%mod_path_out%\%mod_name%.zip"
    ECHO DEL %mod_path_out%\%mod_name%.zip
)
PUSHD "%mod_path_src%"
ECHO C:\Program Files\WinRAR\winrar A -r ..\out\%mod_name%.zip
"C:\Program Files\WinRAR\winrar" A -r ..\out\%mod_name%.zip *.*
POPD
IF EXIST "%fs17_mod_path%\" (
    RMDIR /S /Q "%fs17_mod_path%\"
    ECHO RMDIR %fs17_mod_path%\
)
COPY "%mod_path_out%\%mod_name%.zip" "%fs17_mods_path%%mod_name%.zip"

ECHO ################################### %mod_name% published ###################################

CALL "C:\Program Files (x86)\Farming Simulator 2017\FarmingSimulator2017.exe"
ENDLOCAL
EXIT