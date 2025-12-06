# Lucent Browser - Apply Transparency
# Applies window-level transparency to running Firefox instance

Write-Host "🪟 Applying Window Transparency..." -ForegroundColor Cyan
Write-Host ""

# Check if transparency module is installed
$moduleDir = "$PSScriptRoot\transparency-module"
if (-not (Test-Path "$moduleDir\node_modules")) {
    Write-Host "❌ Transparency module not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Run: .\install-transparency.ps1" -ForegroundColor Yellow
    exit 1
}

# Check if Firefox is running
$firefox = Get-Process firefox -ErrorAction SilentlyContinue
if (-not $firefox) {
    Write-Host "❌ Firefox is not running!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Start Firefox first with: .\dev-mode.ps1" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Firefox is running" -ForegroundColor Green
Write-Host ""

# Apply transparency
Write-Host "Applying transparency..." -ForegroundColor Cyan
node "$moduleDir\transparency-module.js"

Write-Host ""
Write-Host "💡 Tip: Add this to startup if you want automatic transparency" -ForegroundColor Cyan
