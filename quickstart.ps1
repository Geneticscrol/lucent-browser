# Lucent Browser - Quick Start Script for Windows
# This script helps you get started with building Lucent Browser

Write-Host "`n" -NoNewline
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   Lucent Browser - Quick Start" -ForegroundColor White
Write-Host "   Translucent. Private. Open Source." -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Check if running in MozillaBuild
if (-not $env:MOZILLABUILD) {
    Write-Host "⚠️  WARNING: This should be run in MozillaBuild shell!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please:" -ForegroundColor White
    Write-Host "  1. Install MozillaBuild from:" -ForegroundColor Gray
    Write-Host "     https://ftp.mozilla.org/pub/mozilla/libraries/win32/MozillaBuildSetup-Latest.exe" -ForegroundColor Gray
    Write-Host "  2. Open MozillaBuild shell (start-shell.bat)" -ForegroundColor Gray
    Write-Host "  3. Navigate to this directory" -ForegroundColor Gray
    Write-Host "  4. Run: python build-scripts/setup.py" -ForegroundColor Gray
    Write-Host ""
    
    $continue = Read-Host "Continue anyway? (y/N)"
    if ($continue -ne "y") {
        exit
    }
}

# Check Python
Write-Host "🔍 Checking Python..." -ForegroundColor Cyan
$python = Get-Command python -ErrorAction SilentlyContinue
if ($null -eq $python) {
    Write-Host "❌ Python not found!" -ForegroundColor Red
    Write-Host "   Install Python 3.8+ from https://www.python.org" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Python found: $($python.Version)" -ForegroundColor Green

# Check Git
Write-Host "🔍 Checking Git..." -ForegroundColor Cyan
$git = Get-Command git -ErrorAction SilentlyContinue
if ($null -eq $git) {
    Write-Host "❌ Git not found!" -ForegroundColor Red
    Write-Host "   Install Git from https://git-scm.com" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Git found" -ForegroundColor Green

# Check disk space
Write-Host "🔍 Checking disk space..." -ForegroundColor Cyan
$drive = (Get-Location).Drive.Name + ":"
$freeSpace = (Get-PSDrive $drive.TrimEnd(':')).Free / 1GB
if ($freeSpace -lt 30) {
    Write-Host "⚠️  WARNING: Only $([math]::Round($freeSpace, 2)) GB free. Need 30+ GB!" -ForegroundColor Yellow
}
else {
    Write-Host "✓ Sufficient disk space: $([math]::Round($freeSpace, 2)) GB free" -ForegroundColor Green
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   What would you like to do?" -ForegroundColor White
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  1) Setup build environment (first time)" -ForegroundColor White
Write-Host "  2) Build Lucent Browser" -ForegroundColor White
Write-Host "  3) Run Lucent Browser" -ForegroundColor White
Write-Host "  4) Open documentation" -ForegroundColor White
Write-Host "  5) Open GitHub repository" -ForegroundColor White
Write-Host "  6) Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice (1-6)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "🚀 Starting setup..." -ForegroundColor Cyan
        Write-Host "   This will download Firefox source (~3 GB) and may take 30-60 minutes" -ForegroundColor Yellow
        Write-Host ""
        
        $confirm = Read-Host "Continue? (y/N)"
        if ($confirm -eq "y") {
            python build-scripts/setup.py
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "🔨 Building Lucent Browser..." -ForegroundColor Cyan
        Write-Host "   This will take 1-2 hours. You can minimize this window." -ForegroundColor Yellow
        Write-Host ""
        
        if (Test-Path "firefox-source") {
            python build-scripts/build.py
        }
        else {
            Write-Host "❌ Firefox source not found!" -ForegroundColor Red
            Write-Host "   Please run Setup (option 1) first" -ForegroundColor Yellow
        }
    }
    
    "3" {
        Write-Host ""
        Write-Host "🌟 Launching Lucent Browser..." -ForegroundColor Cyan
        Write-Host ""
        
        if (Test-Path "firefox-source/obj-lucent") {
            python build-scripts/run.py
        }
        else {
            Write-Host "❌ Built browser not found!" -ForegroundColor Red
            Write-Host "   Please build first (option 2)" -ForegroundColor Yellow
        }
    }
    
    "4" {
        Write-Host ""
        Write-Host "📚 Opening documentation..." -ForegroundColor Cyan
        
        Write-Host "  Available documentation:" -ForegroundColor White
        Write-Host "  - README.md" -ForegroundColor Gray
        Write-Host "  - docs/BUILD.md" -ForegroundColor Gray
        Write-Host "  - docs/PRIVACY.md" -ForegroundColor Gray
        Write-Host "  - docs/CUSTOMIZATION.md" -ForegroundColor Gray
        Write-Host "  - docs/FAQ.md" -ForegroundColor Gray
        Write-Host ""
        
        Start-Process "README.md"
    }
    
    "5" {
        Write-Host ""
        Write-Host "🌐 Opening GitHub repository..." -ForegroundColor Cyan
        Start-Process "https://github.com/Geneticscrol/lucent-browser"
    }
    
    "6" {
        Write-Host ""
        Write-Host "👋 Goodbye!" -ForegroundColor Cyan
        Write-Host ""
        exit
    }
    
    default {
        Write-Host ""
        Write-Host "❌ Invalid choice!" -ForegroundColor Red
        Write-Host ""
    }
}

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "   Need help?" -ForegroundColor White
Write-Host "   https://github.com/Geneticscrol/lucent-browser/issues" -ForegroundColor Gray
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
