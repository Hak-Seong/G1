@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 저장소 로컬 점검
echo.
echo === 저장소 로컬 점검 ===
echo 폴더: %CD%
echo.
".\.venv\Scripts\python.exe" tools\verify_repo_local.py %*
set ERR=%ERRORLEVEL%
echo.
if %ERR% neq 0 (
  echo 점검 실패 ^(exit %ERR%^). 위 FAIL 항목을 확인하세요.
  pause
  exit /b %ERR%
)
echo 점검 통과.
pause
exit /b 0
