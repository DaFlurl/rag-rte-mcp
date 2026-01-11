@echo off
echo Deploying SOL files to SharedObjects...

REM Get SharedObjects folder ID
set "SO_PATH=%APPDATA%\Macromedia\Flash Player\#SharedObjects"
for /d %%i in ("%SO_PATH%\*") do set "FOLDER_ID=%%~nxi"
echo Found SharedObjects folder: %FOLDER_ID%

REM Create target directories and copy files

REM Node 0 - 0 accounts
xcopy /E /I /Y "Node0" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node0"

REM Node 1 - 0 accounts
xcopy /E /I /Y "Node1" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node1"

REM Node 2 - 0 accounts
xcopy /E /I /Y "Node2" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node2"

REM Node 3 - 0 accounts
xcopy /E /I /Y "Node3" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node3"

REM Node 4 - 0 accounts
xcopy /E /I /Y "Node4" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node4"

REM Node 5 - 0 accounts
xcopy /E /I /Y "Node5" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node5"

REM Node 6 - 0 accounts
xcopy /E /I /Y "Node6" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node6"

REM Node 7 - 0 accounts
xcopy /E /I /Y "Node7" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node7"

REM Node 8 - 0 accounts
xcopy /E /I /Y "Node8" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node8"

REM Node 9 - 0 accounts
xcopy /E /I /Y "Node9" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node9"

REM Node 10 - 0 accounts
xcopy /E /I /Y "Node10" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node10"

REM Node 11 - 0 accounts
xcopy /E /I /Y "Node11" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node11"

REM Node 12 - 0 accounts
xcopy /E /I /Y "Node12" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node12"

REM Node 13 - 0 accounts
xcopy /E /I /Y "Node13" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node13"

REM Node 14 - 0 accounts
xcopy /E /I /Y "Node14" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node14"

REM Node 15 - 0 accounts
xcopy /E /I /Y "Node15" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node15"

REM Node 16 - 0 accounts
xcopy /E /I /Y "Node16" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node16"

REM Node 17 - 0 accounts
xcopy /E /I /Y "Node17" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node17"

REM Node 18 - 0 accounts
xcopy /E /I /Y "Node18" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node18"

REM Node 19 - 0 accounts
xcopy /E /I /Y "Node19" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node19"

REM Node 20 - 0 accounts
xcopy /E /I /Y "Node20" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node20"

REM Node 21 - 0 accounts
xcopy /E /I /Y "Node21" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node21"

REM Node 22 - 0 accounts
xcopy /E /I /Y "Node22" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node22"

REM Node 23 - 0 accounts
xcopy /E /I /Y "Node23" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node23"

REM Node 24 - 0 accounts
xcopy /E /I /Y "Node24" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node24"

REM Node 25 - 0 accounts
xcopy /E /I /Y "Node25" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node25"

REM Node 26 - 0 accounts
xcopy /E /I /Y "Node26" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node26"

REM Node 27 - 0 accounts
xcopy /E /I /Y "Node27" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node27"

REM Node 28 - 0 accounts
xcopy /E /I /Y "Node28" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node28"

REM Node 29 - 0 accounts
xcopy /E /I /Y "Node29" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node29"

REM Node 30 - 0 accounts
xcopy /E /I /Y "Node30" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node30"

REM Node 31 - 0 accounts
xcopy /E /I /Y "Node31" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node31"

REM Node 32 - 0 accounts
xcopy /E /I /Y "Node32" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node32"

REM Node 33 - 0 accounts
xcopy /E /I /Y "Node33" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node33"

REM Node 34 - 0 accounts
xcopy /E /I /Y "Node34" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node34"

REM Node 35 - 0 accounts
xcopy /E /I /Y "Node35" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node35"

REM Node 36 - 0 accounts
xcopy /E /I /Y "Node36" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node36"

REM Node 37 - 0 accounts
xcopy /E /I /Y "Node37" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node37"

REM Node 38 - 0 accounts
xcopy /E /I /Y "Node38" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node38"

REM Node 39 - 0 accounts
xcopy /E /I /Y "Node39" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node39"

REM Node 40 - 0 accounts
xcopy /E /I /Y "Node40" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node40"

REM Node 41 - 0 accounts
xcopy /E /I /Y "Node41" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node41"

REM Node 42 - 0 accounts
xcopy /E /I /Y "Node42" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node42"

REM Node 43 - 0 accounts
xcopy /E /I /Y "Node43" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node43"

REM Node 44 - 0 accounts
xcopy /E /I /Y "Node44" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node44"

REM Node 45 - 0 accounts
xcopy /E /I /Y "Node45" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node45"

REM Node 46 - 0 accounts
xcopy /E /I /Y "Node46" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node46"

REM Node 47 - 0 accounts
xcopy /E /I /Y "Node47" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node47"

REM Node 48 - 0 accounts
xcopy /E /I /Y "Node48" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node48"

REM Node 49 - 0 accounts
xcopy /E /I /Y "Node49" "%SO_PATH%\%FOLDER_ID%\localhost\evony\Node49"

echo.
echo Deployment complete!
pause