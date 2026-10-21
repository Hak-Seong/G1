# stt_transcriber

로컬 CPU 전용 **AI 전사 초안 + 사람 검증** 도구 (금융분쟁 녹취록 지원).

> 목표는 AI가 녹취록을 완성하는 것이 아니라, 검증자가 원음과 대조해 확정하는 것입니다.

## Hybrid kickoff (완료된 산출물)

| 영역 | 내용 |
|------|------|
| Cursor 패키지 | `.cursor/rules/`, `docs/`, `prompts/00`–`06` |
| Phase 0 코드 | `tools/diagnose_audio.py`, `tools/benchmark_stt.py`, probe/hash/net_guard |
| 보안 | `.cursorignore`, runtime network guard |

실녹음·실녹취문은 **절대** 이 저장소나 Cursor 채팅에 넣지 마세요.

## Quick start (Phase 0)

**D2:** 설계 기본은 Python **3.11**. 이 PC에는 현재 3.8.4만 잡혀 있습니다. Phase 0 단위테스트는 3.8에서도 통과했지만, Phase 1(faster-whisper 등) 전에 3.11 64-bit를 설치하세요.

```bat
cd c:\Users\Training-17\Desktop\vive\stt_transcriber
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
python tools\make_synth_wav.py
python tools\diagnose_audio.py samples_synth\tone_mono_16k_1s.wav --json
python -m pytest
```

## Cursor Agent 진행 방법

1. 이 폴더를 Cursor 워크스페이스로 연다.
2. Privacy Mode 권장.
3. `prompts/` 번호 순서대로 **한 파일씩** Agent에 붙여넣는다.
4. 각 프롬프트의 완료 기준(테스트) 통과 후 다음 단계.

## Phase 1 MVP 실행

```bat
cd c:\Users\Training-17\Desktop\vive\stt_transcriber
.\.venv\Scripts\activate
set PYTHONPATH=src
python -m transcriber.app
rem 또는 CLI:
python -m transcriber.app --cli "C:\path\to\file.m4a"
```

기본 모델: `models\large-v3-turbo` (CPU int8). 화자 분리는 Phase 2.

## 직접 시험하는 방법

1. `prepare_test.bat`으로 시험 공간 초기화·녹음 복사(필요 시 시나리오 A/B)
2. `금융민원녹취록_G1_시험모드.cmd`로 런처 실행 → `docs/manual_test/manual_test_checklist.md` 따라 판정
3. 결과는 `docs/manual_test/test_result_template.md`에 기록 → 저장소는 `저장소점검.cmd`

## Docs

- `docs/SRS.md` — 요구사항
- `docs/architecture.md` — 아키텍처
- `docs/schema.md` — 데이터 스키마
- `docs/decisions.md` — D1–D11
- `docs/env_checklist.md` — PC 체크리스트
- `docs/manual_test/` — 수동 점검표·결과 기록지
- `docs/git_workflow.md` — 로컬 Git 운영

## Defaults

- Python 3.11, faster-whisper `large-v3-turbo` int8 CPU
- Word: A4, 바탕 11pt (미검증 머리글만 10pt)
- Diarization: channel-first → sherpa-onnx
