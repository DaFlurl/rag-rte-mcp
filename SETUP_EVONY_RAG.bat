@echo off
title Evony RAG - Setup
echo.
echo ============================================================
echo           EVONY KNOWLEDGE RAG - SETUP
echo ============================================================
echo.
echo Installing dependencies...
echo.

cd /d "c:\Users\Admin\Downloads\Evony_Decrypted"
pip install -r evony_rag\requirements.txt

echo.
echo Building knowledge index...
python -c "from evony_rag.embeddings import build_index; build_index()"

echo.
echo ============================================================
echo Setup complete!
echo.
echo Run options:
echo   EVONY_RAG_CLI.bat     - Interactive CLI
echo   EVONY_RAG_API.bat     - LM Studio compatible API
echo   EVONY_RAG_MCP.bat     - MCP server for Windsurf
echo ============================================================
pause
