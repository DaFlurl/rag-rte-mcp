REM dir *.exe /S /B > tmpFile
REM set /p listVar= < tmpFile
REM del tmpFile

for /r "." %%a in (*.exe) do start "H:\Evony\" "%%~fa"