@echo off
setlocal enabledelayedexpansion
title MCCC Pack editor ^| Made by: Zipp
color f
cls
echo.
echo Made by: ZIPP
timeout /t 1 /nobreak >nul
set "appDir=%appdata%\PackEditor"
if NOT exist "%appDir%" mkdir "%appDir%"
if NOT exist "%appDir%\pack.mcmeta" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/pack.mcmeta' -UseBasicParsing -OutFile '%appDir%\pack.mcmeta'"
)
if NOT exist "%appDir%\credits.txt" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/credits.txt' -UseBasicParsing -OutFile '%appDir%\credits.txt'"
)
if NOT exist "%appDir%\mcccpack.txt" (
    PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/PackEditor/refs/heads/main/assets/mcccpack.txt' -UseBasicParsing -OutFile '%appDir%\mcccpack.txt'"
)
cls
title MCCC Pack editor ^| Made by: Zipp
if "%~1"=="" (
    set /p "zipPath=Enter MCPACK path (.zip): "
) else (
    set "zipPath=%~1"
)
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
)
if /i not "%ext%"==".zip" (
    echo This is not a .zip file!
    pause >nul
    exit
)
set "safeFileName=%fileName: =_%"
set "safeFileName=%safeFileName:§=%"
set "extractFolder=%appDir%\%safeFileName%"
if exist "%extractFolder%" rd /s /q "%extractFolder%"
mkdir "%extractFolder%"
7z x "%zipPath%" -o"%extractFolder%" -y >nul
set "mcmeta=%appDir%\pack.mcmeta"
set "credits=%appDir%\credits.txt"
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
set "commentFile=%appDir%\mcccpack.txt"
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
rd /s /q "%extractFolder%"
title MCCC Pack editor ^| Done.
echo ---------------------------------------
echo Done
pause >nul
exit
