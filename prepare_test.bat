@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 시험 공간 준비 도구
if not exist ".venv\Scripts\python.exe" (
  echo [오류] .venv\Scripts\python.exe 없음
  pause
  exit /b 1
)
".\.venv\Scripts\python.exe" tools\test_kit.py %*
set ERR=%ERRORLEVEL%
if %ERR% neq 0 (
  echo [오류] test_kit 종료 코드=%ERR%
  pause
)
exit /b %ERR%