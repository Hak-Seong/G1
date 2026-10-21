@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 금융민원 녹취록 자동화

if not exist ".venv\Scripts\python.exe" (
  echo [오류] Python 가상환경이 없습니다.
  echo 경로: %CD%\.venv
  pause
  exit /b 1
)
if not exist "tools\run_g1_launcher.py" (
  echo [오류] 실행 스크립트가 없습니다.
  pause
  exit /b 1
)
if not exist "models\large-v3-turbo\model.bin" (
  echo [오류] STT 모델이 없습니다: models\large-v3-turbo
  pause
  exit /b 1
)
if not exist "models\diarization\nemo_en_titanet_small.onnx" (
  echo [경고] 화자분리 모델이 없습니다. STT/검증은 가능하나 화자분리가 제한됩니다.
  timeout /t 3 >nul
)

REM GUI는 콘솔 창 없이 실행 (pythonw)
if exist ".venv\Scripts\pythonw.exe" (
  start "" ".venv\Scripts\pythonw.exe" "tools\run_g1_launcher.py" %*
) else (
  start "" ".venv\Scripts\python.exe" "tools\run_g1_launcher.py" %*
)
exit /b 0