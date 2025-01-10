@echo off
:: Überprüfen, ob ADB verfügbar ist
adb version >nul 2>&1
if errorlevel 1 (
    echo ADB ist nicht installiert oder nicht im PATH verfügbar.
    echo Bitte stellen Sie sicher, dass ADB korrekt eingerichtet ist.
    pause
    exit /b
)

:: Überprüfen, ob ein Gerät verbunden ist
echo Überprüfen, ob ein Android-Gerät verbunden ist...
adb devices | findstr /i "device" >nul
if errorlevel 1 (
    echo Kein Android-Gerät gefunden. Bitte ein Gerät anschließen und den USB-Debugging-Modus aktivieren.
    pause
    exit /b
)

:: Datei auf das Gerät kopieren
echo Übertrage ZIP-Datei auf das Gerät...
adb push Magisk-v28.1.zip /sdcard/Magisk.zip
if errorlevel 1 (
    echo Fehler beim Übertragen der ZIP-Datei.
    pause
    exit /b
)

:: Gerät in den Wiederherstellungsmodus versetzen
echo Starte Gerät im Wiederherstellungsmodus neu...
adb reboot recovery
if errorlevel 1 (
    echo Fehler beim Neustart im Wiederherstellungsmodus.
    pause
    exit /b
)

:: Anleitung zur manuellen Installation anzeigen
echo Installation der ZIP-Datei im Wiederherstellungsmodus:
echo 1. Navigiere im Wiederherstellungsmodus zum Menüpunkt "Install".
echo 2. Wähle die Datei /sdcard/Magisk.zip aus.
echo 3. Bestätige die Installation und starte das Gerät neu.
pause
exit /b
