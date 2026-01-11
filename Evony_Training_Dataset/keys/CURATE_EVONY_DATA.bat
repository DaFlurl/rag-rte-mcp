@echo off
title Evony Data Curator - Quality Analysis
echo.
echo ============================================================
echo        EVONY DATA CURATOR - QUALITY ANALYSIS
echo ============================================================
echo.
echo This tool will analyze all files for training quality:
echo   - Detect junk, personal notes, fragments
echo   - Score relevance to Evony
echo   - Identify duplicates
echo   - Generate review report for human approval
echo.
echo NO files will be copied - only analyzed.
echo Review the report before building the final dataset.
echo.
echo ============================================================
echo.

cd /d "c:\Users\Admin\Downloads\Evony_Decrypted"
python -m evony_hub.data_curator

echo.
echo ============================================================
echo Analysis complete! Review DATA_CURATION_REPORT.md
echo ============================================================
pause
