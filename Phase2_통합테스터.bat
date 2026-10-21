@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Phase 2A+2B 통합 테스터
echo 녹취 파일로 Phase 2A+2B 통합 검증 테스터를 실행합니다...
".\.venv\Scripts\python.exe" tools\run_phase2_tester.py %*
if errorlevel 1 pause
