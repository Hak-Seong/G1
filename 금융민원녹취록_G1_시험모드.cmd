@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 금융민원 녹취록 자동화 (G1) - 시험 모드

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

git status --porcelain >nul 2>&1
if not errorlevel 1 (
  for /f %%i in ('git status --porcelain 2^>nul') do (
    echo [안내] 커밋되지 않은 변경이 있습니다.
    goto after_git
  )
)
:after_git

if not exist "test_workspace" mkdir "test_workspace"
if not exist "test_workspace\data" mkdir "test_workspace\data"
if not exist "test_workspace\tmp" mkdir "test_workspace\tmp"
if not exist "test_workspace\input" mkdir "test_workspace\input"

set "STT_DATA_DIR=%CD%\test_workspace\data"
set "STT_TEMP_DIR=%CD%\test_workspace\tmp"
set "STT_TEST_MODE=1"

echo 시험 모드로 실행합니다. 데이터: test_workspace
".\.venv\Scripts\python.exe" tools\run_g1_launcher.py %*
set ERR=%ERRORLEVEL%
if %ERR% neq 0 (
  echo [오류] 런처가 비정상 종료했습니다. 코드=%ERR%
  echo 로그는 화면·콘솔 출력을 확인하세요.
  pause
  exit /b %ERR%
)
exit /b 0