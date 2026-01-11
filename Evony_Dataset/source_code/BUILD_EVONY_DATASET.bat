@echo off
title Evony Dataset Builder
echo.
echo ============================================================
echo           EVONY DATASET BUILDER
echo ============================================================
echo.
echo This will scan all Evony data sources and create a clean,
echo deduplicated dataset for AI training.
echo.
echo Sources:
echo   - C:\Users\Admin\Downloads\Evony_Decrypted
echo   - D:\Svony_Studio
echo   - D:\Users\Admin\Desktop\evony_2024
echo   - G:\Evony_CentOS
echo   - G:\Local-Games-Projects\evony_scripts_collection
echo.
echo Output: Evony_Dataset folder
echo.

cd /d "c:\Users\Admin\Downloads\Evony_Decrypted"
python -m evony_hub.dataset_builder

echo.
echo ============================================================
echo Dataset build complete! Check Evony_Dataset folder.
echo ============================================================
pause
