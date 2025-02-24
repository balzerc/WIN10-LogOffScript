REM This script clears credentials and user data upon log out for shared devices.
REM It deletes files from the Downloads directory, clears cookies and cache from Microsoft Edge and Google Chrome,
REM removes the Work account profile, and deletes MS Teams/Zoom cache and saved credentials.
REM This script should be added to the Group Policy sign out policy.
REM Created by Cole Balzer, 2025-02-24

@echo off
REM Delete all files and folders in the guest user profile Downloads directory
del /s /q /f "%USERPROFILE%\Downloads\*.*"
for /d %%p in ("%USERPROFILE%\Downloads\*.*") do rmdir "%%p" /s /q


REM Delete all cookies and cache from Microsoft Edge browser
taskkill /IM msedge.exe /F
del /s /q /f "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge.Stable_8wekyb3d8bbwe\AC\*.*"
for /d %%p in ("%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge.Stable_8wekyb3d8bbwe\AC\*.*") do rmdir "%%p" /s /q
del /s /q /f "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\*.*"
for /d %%p in ("%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\*.*") do rmdir "%%p" /s /q
del /s /q /f "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default"


REM Delete all cookies and cache from Google Chrome browser
taskkill /F /IM chrome.exe /T
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\Cache_Data\*.*"
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Network\Cookies"
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Network\Cookies-journal"
del /s /q /f "%LOCALAPPDATA%\Google\Chrome\User Data\*.*"

REM Delete Work account profile from local signed-in account (requires sign out)
for /d %%p in ("%LOCALAPPDATA%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\*.*") do rmdir "%%p" /s /q

REM Sign out and delete cache content from Zoom
taskkill /F /IM Zoom.exe
del /s /q /f "%APPDATA%\Zoom\*.*"'

REM Delete cache content from MS Teams and remove Credential Manager "Generic Credentials"
taskkill /F /IM Teams.exe
taskkill /F /IM msteams.exe
taskkill /F /IM ms-teams.exe
taskkill /F /FI "SERVICES eq office*"
REM This script will delete all the saved credentials for the current user
del /s /q /f "%LOCALAPPDATA%\Packages\MSTeams_8wekyb3d8bbwe"
cmdkey.exe /list > "%TEMP%\List.txt"
findstr.exe Target "%TEMP%\List.txt" > "%TEMP%\tokensonly.txt"
FOR /F "tokens=1,2 delims= " %%G IN (%TEMP%\tokensonly.txt) DO cmdkey.exe /delete:%%H
del "%TEMP%\List.txt" /s /f /q
del "%TEMP%\tokensonly.txt" /s /f /q