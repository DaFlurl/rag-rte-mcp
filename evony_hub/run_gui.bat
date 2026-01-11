@echo off
title Evony Master Hub - Unified GUI
cd /d "%~dp0"
cd ..
echo Starting Evony Master Hub...
python -m evony_hub.gui
pause
