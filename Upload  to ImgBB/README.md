# Upload to Imgbb Registry Setup

This package provides an automated setup for the "Upload to Imgbb" context menu option for image files. The setup script automatically handles file placement, API key configuration, and registry file generation.

## Files Included in [Upload to ImgBB.zip](https://github.com/fosterbarnes/PublicFiles/blob/main/Upload%20%20to%20ImgBB/Upload%20%20to%20ImgBB.zip")

1. **`Setup-UploadToImgbb.bat`** - Automated setup script 
2. **`UploadToImgbb.ps1`** - PowerShell script for uploading images to ImgBB
3. **`imgbbIcon.ico`** - Icon file for the context menu

## Prerequisites

Before running the setup, you'll need:

1. **ImgBB API Key** - Get your free API key from [https://api.imgbb.com/](https://api.imgbb.com/)
2. **Windows 10/11** - The script is designed for modern Windows systems
3. **Administrator privileges** - Required for registry modifications (Editing the registry is how we add items to the right-click context menu)

## Quick Setup

### Step 1: Prepare Files
Download [Upload to ImgBB.zip](https://raw.githubusercontent.com/fosterbarnes/PublicFiles/main/Upload%20%20to%20ImgBB/Upload%20%20to%20ImgBB.zip) and unzip

### Step 2: Run the Setup
1. **Right-click** on `Setup-UploadToImgbb.bat` and select **"Run as administrator"**
2. **Enter your ImgBB API key** when prompted
3. **Wait for the setup to complete** - the script will automatically:
   - Copy the PowerShell script to `Documents\Batch Files\`
   - Copy the icon to your `Pictures` folder
   - Update the script with your API key
   - Generate the registry file

### Step 3: Import Registry
1. **Double-click** the generated `.Upload_to_Imgbb.reg` file
2. **Click "Yes"** when prompted to import the registry settings

### Step 4: Test the Setup
1. **Right-click** on any image file (.png, .jpg, .jpeg, .webp)
2. **Select "Upload to Imgbb"** from the context menu
3. **Check your clipboard** - the image URL should be automatically copied

## What the Setup Script Does

The automated setup script performs the following actions:

### File Management
- **Creates** `Documents\Batch Files\` directory (if it doesn't exist)
- **Copies** `UploadToImgbb.ps1` to `Documents\Batch Files\`
- **Copies** `imgbbIcon.ico` to your `Pictures` folder
- **Updates** the PowerShell script with your API key

### Registry Configuration
- **Generates** a custom registry file (`.Upload_to_Imgbb.reg`)
- **Configures** context menu entries for:
  - `.png` files
  - `.jpg` files
  - `.jpeg` files
  - `.webp` files
- **Sets up** proper icon and script paths

## File Locations After Setup

After running the setup script, files will be placed in these locations:

```
📁 User Profile/
├── 📁 Documents/
│   └── 📁 Batch Files/
│       └── 📄 UploadToImgbb.ps1          # PowerShell script with API key
├── 📁 Pictures/
│   └── 📄 imgbbIcon.ico                  # Context menu icon
└── 📁 [Setup Folder]/
    └── 📄 .Upload_to_Imgbb.reg           # Generated registry file
```

## Troubleshooting

### Common Issues and Solutions

#### 1. "API key cannot be empty" Error
- **Solution**: Get your API key from [https://api.imgbb.com/](https://api.imgbb.com/)
- **Note**: The API key is required for the script to function

#### 2. "File not found" Errors
- **Solution**: Ensure all required files are in the same folder as the batch script
- **Required files**:
  - `Setup-UploadToImgbb.bat`
  - `UploadToImgbb.ps1`
  - `imgbbIcon.ico`

#### 3. "Failed to create Batch Files directory" Error
- **Solution**: Run the script as administrator
- **Alternative**: Manually create `Documents\Batch Files\` folder

#### 4. "Failed to copy" Errors
- **Solution**: Check that you have write permissions to Documents and Pictures folders
- **Alternative**: Run the script as administrator

#### 5. Context Menu Doesn't Appear
- **Solution 1**: Restart File Explorer
  ```
  taskkill /f /im explorer.exe && start explorer.exe
  ```
- **Solution 2**: Verify registry import was successful
- **Solution 3**: Check that the registry file was generated correctly

#### 6. "Upload failed" When Using the Context Menu
- **Solution 1**: Verify your API key is correct
- **Solution 2**: Check your internet connection
- **Solution 3**: Ensure the image file is not corrupted

## Support

If you encounter issues not covered in the troubleshooting section:

1. **Check file permissions** - Ensure you have write access to Documents and Pictures folders
2. **Verify API key** - Test your API key on the ImgBB website
3. **Run as administrator** - Some operations require elevated privileges
4. **Check Windows version** - Ensure you're running Windows 10 or later

## File Structure

```
📁 Upload to Imgbb Setup/
├── 📄 Setup-UploadToImgbb.bat              # Automated setup script
├── 📄 UploadToImgbb.ps1                    # PowerShell upload script
├── 📄 imgbbIcon.ico                        # Context menu icon
├── 📄 README-UploadToImgbb.md              # This documentation
└── 📄 .Upload_to_Imgbb.reg                 # Generated registry file (after setup)
```