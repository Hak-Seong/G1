@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 금융민원 녹취록 자동화 (G1)
".\.venv\Scripts\python.exe" tools\run_g1_launcher.py %*
if errorlevel 1 pause
