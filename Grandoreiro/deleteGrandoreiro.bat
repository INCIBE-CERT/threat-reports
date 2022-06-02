REM The following script is valid when the registry key, path and executable name are matched
Clave=”Uvnerjnx” :: This is an example with "Uvnerjnx" as registry key, but it could vary
Ejecutable=”solodriver.exe”
Directorio=”nowview”
reg delete
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v
%Clave% /f
taskkill /f /im %Ejecutable%
del /F %APPDATA%\%Directorio%\*.exe
del /F %APPDATA%\%Directorio%\*.dll
rmdir /s /q %APPDATA%\%Directorio%