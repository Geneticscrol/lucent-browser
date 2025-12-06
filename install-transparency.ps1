# Lucent Browser - Transparency Enabler
# Automatically applies window transparency when Firefox launches

Write-Host "🚀 Installing Transparency Module..." -ForegroundColor Cyan
Write-Host ""

$moduleDir = "$PSScriptRoot\transparency-module"

# Check if Node.js is installed
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    Write-Host "After installation, run this script again." -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Node.js found" -ForegroundColor Green

# Install npm dependencies
Write-Host ""
Write-Host "📦 Installing dependencies..." -ForegroundColor Cyan
Push-Location $moduleDir

try {
    npm install --silent
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
} catch {
    Write-Host "⚠ Warning: Some dependencies may have failed to install" -ForegroundColor Yellow
}

Pop-Location

Write-Host ""
Write-Host "✨ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To enable transparency:" -ForegroundColor Cyan
Write-Host "  1. Start Firefox with: .\dev-mode.ps1" -ForegroundColor White
Write-Host "  2. Run: .\apply-transparency.ps1" -ForegroundColor White
Write-Host ""
