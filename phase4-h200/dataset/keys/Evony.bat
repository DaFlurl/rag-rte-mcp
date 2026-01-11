START H:\Evony\roboevony_RE_1.41_CrazyLT\roboevony.exe;H:\Evony\roboevony_RE_1.41_apache\roboevony.exe
"H:\Evony\roboevony_RE_1.41_Balls\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_Chodebitch\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_CoolArrow\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_CrazyBudda\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_CrazyDm\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_CrazyRab\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_CW\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_David960\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_Davidevony\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_GhostRaider\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_IamChoder\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_PAB\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_RQ\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_Saphire\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_Vorador\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_zazz\roboevony.exe"
"H:\Evony\roboevony_RE_1.41_zee\roboevony.exe"
"H:\Evony\Madmum1\roboevony.exe"




START "H:\Evony\roboevony_RE_1.41_CrazyLT\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_apache\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_Balls\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_Chodebitch\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_CoolArrow\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_CrazyBudda\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_CrazyDm\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_CrazyRab\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_CW\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_David960\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_Davidevony\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_GhostRaider\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_IamChoder\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_PAB\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_RQ\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_Saphire\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_Vorador\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_zazz\roboevony.exe"
START "H:\Evony\roboevony_RE_1.41_zee\roboevony.exe"
START "H:\Evony\Madmum1\roboevony.exe"


REM dir *.exe /S /B > tmpFile
REM set /p listVar= < tmpFile
REM del tmpFile

for /r "." %%a in (*.exe) do start "H:\Evony\roboevony_RE_1.41_CrazyLT\roboevony.exe" "%%~fa"