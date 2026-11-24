@echo off
REM Pushes this GPL web portal project to GPLGuyana/gpl-master under specs/design-system/gpl-web-portal-v1.3
REM Uses your own Git login on this computer. Needs Git for Windows (https://git-scm.com/download/win).
setlocal
set "SRC=%~dp0"
set "WORK=%USERPROFILE%\gpl-master"
set "DEST=specs\design-system\gpl-web-portal-v1.3"

where git >nul 2>nul || (echo Git is not installed. Install Git for Windows, then run this again. & pause & exit /b 1)

if not exist "%WORK%\.git" (
  echo Cloning GPLGuyana/gpl-master into %WORK% ...
  git clone https://github.com/GPLGuyana/gpl-master.git "%WORK%" || (echo Clone failed. Check you can open the repo on github.com. & pause & exit /b 1)
)
cd /d "%WORK%"
git checkout main || (pause & exit /b 1)
git pull --ff-only || (pause & exit /b 1)

if not exist "%DEST%" mkdir "%DEST%"
robocopy "%SRC%." "%DEST%" /E /XF push-to-github.cmd /NFL /NDL /NJH /NJS /NP >nul
if %ERRORLEVEL% GEQ 8 (echo Copy failed. & pause & exit /b 1)

git add "%DEST%"
git commit -m "Add GPL Customer Web Portal V1.3 design project (prototype, handoff guide, design system, assets)"
git push origin main
if errorlevel 1 (
  echo.
  echo Push to main was rejected (main may be protected^). Pushing to a branch instead...
  git checkout -b design/gpl-web-portal-v1.3
  git push -u origin design/gpl-web-portal-v1.3 && echo Open a pull request for design/gpl-web-portal-v1.3 on github.com/GPLGuyana/gpl-master
)
echo.
echo Done.
pause
