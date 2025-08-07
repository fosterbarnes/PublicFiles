# Upload to Imgbb Registry Setup

This package provides multiple ways to set up the "Upload to Imgbb" context menu option for image files.

## Files Included

1. **`Upload to Imgbb.reg`** - Original registry file with hardcoded paths
2. **`Setup-UploadToImgbb.bat`** - User-friendly batch file for easy setup
3. **`README-UploadToImgbb.md`** - This documentation file

## Setup Options

### Option 1: Automated Setup (Recommended)

1. Download the `imgbbIcon.ico` file and place it in a folder of your choice
2. Double-click `Setup-UploadToImgbb.bat`
3. Follow the prompts to enter your icon and script paths
4. The script will generate a custom registry file for you
5. Double-click the generated `.reg` file to import into registry

### Option 2: Manual Setup (For advanced users)

1. Download the `imgbbIcon.ico` file and place it in a folder of your choice
2. Open `Upload to Imgbb.reg` in a text editor
3. Replace all instances of `"D:\\Users\\Foster\\Pictures\\imgbbIcon.ico"` with your icon path
4. Replace all instances of `"C:\\Users\\Foster\\Documents\\Batch Files\\complete\\UploadToImgbb.ps1"` with your script path
5. Save the file and double-click to import into registry

**Note:** Use double backslashes (`\\`) in paths for the registry file.

## Path Examples

### Icon Path Examples:
- `C:\Users\YourName\Pictures\imgbbIcon.ico`
- `D:\Icons\imgbbIcon.ico`
- `C:\Program Files\MyApp\imgbbIcon.ico`

### Script Path Examples:
- `C:\Users\YourName\Documents\UploadToImgbb.ps1`
- `D:\Scripts\UploadToImgbb.ps1`
- `C:\Program Files\MyApp\UploadToImgbb.ps1`

## Requirements

- Windows 10/11
- `imgbbIcon.ico` file
- `UploadToImgbb.ps1` script

## Troubleshooting

### Common Issues:

1. **"File not found" errors**
   - Double-check the file paths you're entering
   - Ensure the files actually exist at the specified locations
   - Use full paths (e.g., `C:\Users\YourName\...`)

2. **Registry import fails**
   - Run the batch file as Administrator
   - Ensure the generated `.reg` file is not corrupted
   - Check that the paths in the registry file use double backslashes

3. **Context menu doesn't appear**
   - Restart File Explorer: `taskkill /f /im explorer.exe && start explorer.exe`
   - Check that the registry keys were imported successfully
   - Verify the file extensions are supported (.png, .jpg, .jpeg, .webp)

## File Structure

```
📁 Upload to Imgbb Setup/
├── 📄 Upload to Imgbb.reg                    # Original registry file
├── 📄 Setup-UploadToImgbb.bat                # User-friendly setup script
├── 📄 README-UploadToImgbb.md                # This documentation
└── 📄 imgbbIcon.ico                          # Icon file (download separately)
```

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all file paths are correct
3. Ensure you have administrator privileges when importing registry files
4. Test with a simple path first (e.g., `C:\temp\imgbbIcon.ico`) 