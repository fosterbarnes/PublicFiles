@echo off
title Setup Upload to Imgbb Registry

echo ============================================================================
echo                    Upload to Imgbb Registry Setup
echo ============================================================================
echo.
echo This script will help you set up the "Upload to Imgbb" context menu option.
echo You'll need to provide your ImgBB API key and paths to your icon file and PowerShell script.
echo.

REM Prompt for API key
echo Enter your ImgBB API key (get it from https://api.imgbb.com/):
set /p "API_KEY=API Key: "
REM Remove any surrounding quotes if user added them
set "API_KEY=%API_KEY:"=%"
if "%API_KEY%"=="" (
    echo ERROR: API key cannot be empty.
    echo Please get your API key from https://api.imgbb.com/ and try again.
    pause
    exit /b 1
)

REM Check if PowerShell script exists in the same directory
set "SCRIPT_SOURCE=%~dp0UploadToImgbb.ps1"
if not exist "%SCRIPT_SOURCE%" (
    echo ERROR: UploadToImgbb.ps1 not found in the same directory as this batch file.
    echo Please ensure UploadToImgbb.ps1 is in the same folder as this setup script.
    pause
    exit /b 1
)

echo.
echo Copying PowerShell script to Documents\Batch Files folder...
echo.

REM Set up Documents\Batch Files path
set "DOCUMENTS_FOLDER=%USERPROFILE%\Documents"
set "BATCH_FILES_FOLDER=%DOCUMENTS_FOLDER%\Batch Files"
set "SCRIPT_DESTINATION=%BATCH_FILES_FOLDER%\UploadToImgbb.ps1"

REM Create Batch Files directory if it doesn't exist
if not exist "%BATCH_FILES_FOLDER%" (
    echo Creating Batch Files directory...
    mkdir "%BATCH_FILES_FOLDER%" >nul
    if errorlevel 1 (
        echo ERROR: Failed to create Batch Files directory.
        echo Path: %BATCH_FILES_FOLDER%
        pause
        exit /b 1
    )
)

REM Copy the PowerShell script to the Batch Files folder
copy "%SCRIPT_SOURCE%" "%SCRIPT_DESTINATION%" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy PowerShell script to Batch Files folder.
    echo Source: %SCRIPT_SOURCE%
    echo Destination: %SCRIPT_DESTINATION%
    pause
    exit /b 1
)

echo PowerShell script copied to: %SCRIPT_DESTINATION%
echo.

echo Updating PowerShell script with your API key...
echo.

REM Create a temporary file with the updated API key
set "TEMP_SCRIPT=%TEMP%\UploadToImgbb_temp.ps1"
powershell -Command "(Get-Content '%SCRIPT_DESTINATION%') -replace 'YOUR_API_KEY_HERE', '%API_KEY%' | Set-Content '%TEMP_SCRIPT%'"

if errorlevel 1 (
    echo ERROR: Failed to update PowerShell script with API key.
    pause
    exit /b 1
)

REM Replace the copied script with the updated one
copy "%TEMP_SCRIPT%" "%SCRIPT_DESTINATION%" >nul
if errorlevel 1 (
    echo ERROR: Failed to update the PowerShell script.
    pause
    exit /b 1
)

REM Clean up temporary file
del "%TEMP_SCRIPT%" >nul 2>&1

echo PowerShell script updated with your API key.
echo.

REM Set the script path to the Documents\Batch Files location
set "SCRIPT_PATH=%SCRIPT_DESTINATION%"

REM Copy icon to user's Pictures folder
echo Copying icon to Pictures folder...
set "PICTURES_FOLDER=%USERPROFILE%\Pictures"
set "ICON_SOURCE=%~dp0imgbbIcon.ico"
set "ICON_DESTINATION=%PICTURES_FOLDER%\imgbbIcon.ico"

REM Check if source icon exists
if not exist "%ICON_SOURCE%" (
    echo ERROR: imgbbIcon.ico not found in the same directory as this batch file.
    echo Please ensure imgbbIcon.ico is in the same folder as this setup script.
    pause
    exit /b 1
)

REM Copy icon to Pictures folder
copy "%ICON_SOURCE%" "%ICON_DESTINATION%" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy icon to Pictures folder.
    echo Source: %ICON_SOURCE%
    echo Destination: %ICON_DESTINATION%
    pause
    exit /b 1
)

echo Icon copied to: %ICON_DESTINATION%
echo.

REM Set the icon path to the Pictures folder location
set "ICON_PATH=%ICON_DESTINATION%"

echo.
echo Generating registry file...
echo.

REM Convert paths to registry format (double backslashes) - handle spaces properly
set "ICON_PATH_REG=%ICON_PATH:\=\\%"
set "SCRIPT_PATH_REG=%SCRIPT_PATH:\=\\%"

REM Get current date and time
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set "CURRENT_DATE=%%c-%%b-%%a"
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set "CURRENT_TIME=%%a:%%b"

REM Create the registry file content
(
echo Windows Registry Editor Version 5.00
echo.
echo ; ============================================================================
echo ; Upload to Imgbb Registry File
echo ; Generated on %CURRENT_DATE% %CURRENT_TIME%
echo ; ============================================================================
echo ; 
echo ; Icon Path: %ICON_PATH%
echo ; Script Path: %SCRIPT_PATH%
echo ; API Key: [HIDDEN]
echo ; ============================================================================
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\Upload to Imgbb]
echo "Icon"="\"%ICON_PATH_REG%\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\Upload to Imgbb\command]
echo @="powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SCRIPT_PATH_REG%\" \"%%1\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.webp\shell\Upload to Imgbb]
echo "Icon"="\"%ICON_PATH_REG%\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.webp\shell\Upload to Imgbb\command]
echo @="powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SCRIPT_PATH_REG%\" \"%%1\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\Upload to Imgbb]
echo "Icon"="\"%ICON_PATH_REG%\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\Upload to Imgbb\command]
echo @="powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SCRIPT_PATH_REG%\" \"%%1\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\Upload to Imgbb]
echo "Icon"="\"%ICON_PATH_REG%\""
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\Upload to Imgbb\command]
echo @="powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SCRIPT_PATH_REG%\" \"%%1\""
) > ".Upload_to_Imgbb.reg"

if errorlevel 1 (
    echo.
    echo ERROR: Failed to generate registry file.
    pause
    exit /b 1
)

echo.
echo ============================================================================
echo                           Setup Complete!
echo ============================================================================
echo.
echo The registry file ".Upload_to_Imgbb.reg" has been created.
echo.
echo Icon Path: %ICON_PATH%
echo Script Path: %SCRIPT_PATH%
echo API Key: Configured
echo.
echo To complete the setup:
echo 1. Double-click the generated .reg file to import it into the registry
echo 2. Right-click on any .png, .jpg, .jpeg, or .webp file to test the option
echo.
echo Press any key to exit...
pause >nul 