mkdir temp
echo f | xcopy /f /y modDesc.xml temp\modDesc.xml
echo f | xcopy /f /y icon.png temp\icon.png
echo d | xcopy /f /y /s scripts temp\scripts
cd temp
7z a -tzip FS17_PriceLogger.zip *
echo f | xcopy /f /y FS17_PriceLogger.zip ..\FS17_PriceLogger.zip
cd ..
rmdir /s /q temp
xcopy /f /y FS17_PriceLogger.zip "C:\Users\Jeffrey\Documents\My Games\FarmingSimulator2017\mods\FS17_PriceLogger.zip"
del /f /q FS17_PriceLogger.zip
