# Lucent Browser - Development Mode
# Test CSS changes instantly without rebuilding!

Write-Host "🚀 Lucent Browser - Development Mode" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Check if Firefox is installed
$firefoxPaths = @(
    "$env:ProgramFiles\Mozilla Firefox\firefox.exe",
    "${env:ProgramFiles(x86)}\Mozilla Firefox\firefox.exe",
    "$env:LOCALAPPDATA\Mozilla Firefox\firefox.exe"
)

$firefoxExe = $null
foreach ($path in $firefoxPaths) {
    if (Test-Path $path) {
        $firefoxExe = $path
        break
    }
}

if (-not $firefoxExe) {
    Write-Host "❌ Firefox not found!" -ForegroundColor Red
    Write-Host "📥 Please install Firefox first: https://www.mozilla.org/firefox/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Or specify path manually:" -ForegroundColor Yellow
    $customPath = Read-Host "Enter Firefox executable path (or press Enter to exit)"
    if ($customPath -and (Test-Path $customPath)) {
        $firefoxExe = $customPath
    } else {
        exit 1
    }
}

Write-Host "✓ Found Firefox at: $firefoxExe" -ForegroundColor Green
Write-Host ""

# Create dev profile
$devProfile = "$PSScriptRoot\lucent-dev-profile"
if (-not (Test-Path $devProfile)) {
    Write-Host "📁 Creating development profile..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $devProfile -Force | Out-Null
    New-Item -ItemType Directory -Path "$devProfile\chrome" -Force | Out-Null
}

# Copy user.js
Write-Host "⚙️  Copying privacy configuration..." -ForegroundColor Cyan
Copy-Item "$PSScriptRoot\configs\user.js" "$devProfile\user.js" -Force

# Create symlinks for live CSS editing (or copy if symlinks fail)
Write-Host "🎨 Setting up CSS files for live editing..." -ForegroundColor Cyan

$chromeDir = "$devProfile\chrome"
$userChromeSource = "$PSScriptRoot\chrome\userChrome.css"
$userContentSource = "$PSScriptRoot\chrome\userContent.css"
$userChromeTarget = "$chromeDir\userChrome.css"
$userContentTarget = "$chromeDir\userContent.css"

try {
    # Try to create symlinks (requires admin on Windows)
    if (Test-Path $userChromeTarget) { Remove-Item $userChromeTarget -Force }
    if (Test-Path $userContentTarget) { Remove-Item $userContentTarget -Force }
    
    New-Item -ItemType SymbolicLink -Path $userChromeTarget -Target $userChromeSource -Force -ErrorAction Stop | Out-Null
    New-Item -ItemType SymbolicLink -Path $userContentTarget -Target $userContentSource -Force -ErrorAction Stop | Out-Null
    
    Write-Host "✓ Created symlinks - CSS changes will apply instantly!" -ForegroundColor Green
    $liveEdit = $true
} catch {
    # Fallback to copying
    Copy-Item $userChromeSource $userChromeTarget -Force
    Copy-Item $userContentSource $userContentTarget -Force
    
    Write-Host "⚠️  Using file copies (edit files in lucent-dev-profile/chrome/)" -ForegroundColor Yellow
    $liveEdit = $false
}

Write-Host ""
Write-Host "🎯 Development Mode Active!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 To modify styles:" -ForegroundColor Cyan
if ($liveEdit) {
    Write-Host "   - Edit: chrome\userChrome.css (browser UI)" -ForegroundColor White
    Write-Host "   - Edit: chrome\userContent.css (web pages)" -ForegroundColor White
    Write-Host "   - Changes apply after browser restart (Ctrl+Shift+Q then rerun)" -ForegroundColor White
} else {
    Write-Host "   - Edit: lucent-dev-profile\chrome\userChrome.css (browser UI)" -ForegroundColor White
    Write-Host "   - Edit: lucent-dev-profile\chrome\userContent.css (web pages)" -ForegroundColor White
    Write-Host "   - Restart browser to see changes (Ctrl+Shift+Q then rerun)" -ForegroundColor White
}

Write-Host ""
Write-Host "🔧 Useful shortcuts while testing:" -ForegroundColor Cyan
Write-Host "   - Ctrl+Shift+Alt+I : Browser Toolbox (inspect UI)" -ForegroundColor White
Write-Host "   - Ctrl+Shift+J     : Browser Console (see CSS errors)" -ForegroundColor White
Write-Host "   - Ctrl+Shift+Q     : Quit browser" -ForegroundColor White
Write-Host "   - about:config     : Advanced settings" -ForegroundColor White

Write-Host ""
Write-Host "🚀 Launching Lucent Browser in development mode..." -ForegroundColor Cyan
Write-Host ""

# Launch Firefox with dev profile
& $firefoxExe -no-remote -profile $devProfile

Write-Host ""
Write-Host "✨ Browser closed. Run this script again to test changes!" -ForegroundColor Green
