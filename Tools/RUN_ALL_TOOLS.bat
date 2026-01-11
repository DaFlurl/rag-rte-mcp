@echo off
REM ============================================================
REM Run All Enhancement Tools
REM Bug Fixes + RAG Improvements + Docs + Tests
REM ============================================================

echo.
echo ============================================================
echo    EVONY ENHANCEMENT TOOLS
echo    Running: Bug Fixes, RAG, Docs, Tests
echo ============================================================
echo.

cd /d "%~dp0"
cd ..

echo [1/4] Running Bug Fixer...
python tools\bug_fixer.py
echo.

echo [2/4] Running RAG Enhancer...
python tools\rag_enhancer.py
echo.

echo [3/4] Running Doc Generator...
python tools\doc_generator.py
echo.

echo [4/4] Running Test Suite Validation...
python tools\model_test_suite.py
echo.

echo ============================================================
echo    ALL TOOLS COMPLETE!
echo ============================================================
pause
