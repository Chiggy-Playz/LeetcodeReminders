# Define paths
$frontendPath = "$PSScriptRoot\frontend"
$backendPath = "$PSScriptRoot\backend"
$buildPath = "$frontendPath\build\web"
$destinationPath = "$backendPath\web"

# Navigate to frontend and build Flutter web
Write-Host "Building Flutter web app..."
Set-Location -Path $frontendPath
fvm flutter build web

# Check if the build was successful
if (Test-Path $buildPath) {
    Write-Host "Build successful. Copying files..."
    
    # Remove existing web folder in backend (if exists)
    if (Test-Path $destinationPath) {
        Remove-Item -Recurse -Force $destinationPath
    }

    # Copy build output to backend
    Copy-Item -Recurse -Path $buildPath -Destination $destinationPath

    Write-Host "Web build copied successfully to backend."
} else {
    Write-Host "Build failed. No output found in $buildPath"
}

# Restore original location
Set-Location -Path $PSScriptRoot