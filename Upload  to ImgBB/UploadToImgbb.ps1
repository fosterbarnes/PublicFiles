# === CONFIGURATION ===
$apiKey = "YOUR_API_KEY_HERE"

# === CHECK FOR COMMAND LINE ARGUMENTS ===
if ($args.Count -eq 0) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <image_path>"
    Write-Host "This script is designed to be used with Windows right-click context menu."
    exit 1
}

$imagePath = $args[0]

# === VALIDATE FILE EXISTS ===
if (-not (Test-Path $imagePath)) {
    Write-Host "Error: File not found - $imagePath"
    exit 1
}

# === VALIDATE FILE IS AN IMAGE ===
$imageExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.webp')
$fileExtension = [System.IO.Path]::GetExtension($imagePath).ToLower()
if ($imageExtensions -notcontains $fileExtension) {
    Write-Host "Error: Unsupported file type. Supported formats: $($imageExtensions -join ', ')"
    exit 1
}

try {
    # === READ & ENCODE IMAGE ===
    $imageBytes = [System.IO.File]::ReadAllBytes($imagePath)
    $imageBase64 = [Convert]::ToBase64String($imageBytes)

    # === PREPARE POST DATA ===
    $body = @{
        key   = $apiKey
        image = $imageBase64
    }

    # === SEND POST REQUEST ===
    $response = Invoke-RestMethod -Uri "https://api.imgbb.com/1/upload" -Method Post -Body $body

    # === PROCESS RESULT ===
    if ($response.success) {
        $directLink = $response.data.image.url
        
        # Copy direct link to clipboard
        Set-Clipboard -Value $directLink
        
        # Script runs silently - no notification popup
    } else {
        Write-Host "❌ Upload failed:"
        $response
        exit 1
    }
} catch {
    Write-Host "❌ Error occurred: $($_.Exception.Message)"
    exit 1
}
