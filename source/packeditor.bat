::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBxRRgmLAE+1EbsQ5+n//NaOoUITGus8d+8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJ+LxwbTxabL3+7CrYT5eXu4eOTuy0=
::ZQ05rAF9IBncCkqN+0xwdVsaSwPNP3mjFaEd5Ov04ueSrEQJTYI=
::ZQ05rAF9IAHYFVzEqQJ+LxwbTxabL3+7CrYT5eXu4eOTuy0=
::eg0/rx1wNQPfEVWB+kM9LVsJDEqFOyS5FKwP/On37OWKr1gTXfYmGA==
::fBEirQZwNQPfEVWB+kM9LVsJDEqFOyS5FKwP/On37OWKr1gTXfYmGA==
::cRolqwZ3JBvQF1fEqQJ+LxwbTxabL3+7CrYT5eXu4eOTuy0=
::dhA7uBVwLU+EWBeD8w0zOgJHWAWOP2S3C6AS4fzijw==
::YQ03rBFzNR3SWATEukU3ZxhGVReWPWe5CbgR/eby+/Pn
::dhAmsQZ3MwfNWATEukU3ZxhGVReWPWe5CbgR/eby+/Pn
::ZQ0/vhVqMQ3MEVWAtB9wZhxTAweQJXiuB7kf5+X2+uSOtlRTU+Vwe53CyaCPLOMc50jxe585zxo=
::Zg8zqx1/OA3MEVWAtB9wZhxTAweQJXiuB7kf5+X2+uSOtlR9
::dhA7pRFwIByZRRnK80V/KwlNXxCDMGi1C7gJ5uHv9oo=
::Zh4grVQjdCyDJGyX8VAjFBxRRgmLAE+/Fb4I5/jH3+uEqWgZXfYwasHewrHu
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion
title MCCC Pack editor ^| Made by: Zipp
color f
cls
echo.
echo Made by: ZIPP
timeout /t 1 /nobreak >nul
title MCCC Pack editor ^| Checking files...
set "appDir=%appdata%\PackEditor"
if NOT exist "%appDir%" mkdir "%appDir%"
if NOT exist "%appdata%\PackEditor\pack.mcmeta" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/pack.mcmeta' -UseBasicParsing -OutFile '%appDir%\pack.mcmeta'"
)
if NOT exist "%appdata%\PackEditor\credits.txt" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/credits.txt' -UseBasicParsing -OutFile '%appDir%\credits.txt'"
)
if NOT exist "%appdata%\PackEditor\mcccpack.txt" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/mcccpack.txt' -UseBasicParsing -OutFile '%appDir%\mcccpack.txt'"
)
cls
title MCCC Pack editor ^| Made by: Zipp
set /p "zipPath=Enter MCPACK path (.zip): "
set "zipPath=%zipPath:"=%"
where 7z >nul 2>&1 || (
    echo Error: 7z.exe was not found in PATH. Please download and install 7-Zip and add it to PATH.
    pause >nul
    exit
)
where winrar >nul 2>&1 || (
    echo Error: winrar.exe was not found in PATH. Please install WinRAR and add it to PATH.
    pause >nul
    exit
)
echo Extraction started...
title MCCC Pack editor ^| Extracting...
for %%F in ("%zipPath%") do (
    set "fileName=%%~nF"
    set "ext=%%~xF"
    set "parentDir=%%~dpF"
)
if /i not "%ext%"==".zip" (
    echo This is not a .zip file!
    pause >nul
    exit
)
set "safeFileName=%fileName: =_%"
set "safeFileName=%safeFileName:§=%"
set "extractFolder=%parentDir%%safeFileName%"
if exist "%extractFolder%" rd /s /q "%extractFolder%"
mkdir "%extractFolder%"
7z x "%zipPath%" -o"%extractFolder%" -y >nul
set "mcmeta=%appdata%\PackEditor\pack.mcmeta"
set "credits=%appdata%\PackEditor\credits.txt"
if not exist "%mcmeta%" (
    echo pack.mcmeta was not found.
    pause >nul
    exit
)
if not exist "%credits%" (
    echo credits.txt was not found.
    pause >nul
    exit
)
title MCCC Pack editor ^| Copying files...
copy /Y "%mcmeta%" "%extractFolder%\pack.mcmeta" >nul
copy /Y "%credits%" "%extractFolder%\credits.txt" >nul
set "commentFile=%appdata%\PackEditor\mcccpack.txt"
if not exist "%commentFile%" (
    echo mcccpack.txt was not found.
    pause >nul
    exit
)
set "outputZip=%zipPath%"
if exist "%outputZip%" del /F /Q "%outputZip%"
pushd "%extractFolder%"
title MCCC Pack editor ^| Overwriting...
winrar a -afzip -r -ibck -z"%commentFile%" "%outputZip%" *
popd
echo ---------------------------------------
echo Done
pause >nul
exit
