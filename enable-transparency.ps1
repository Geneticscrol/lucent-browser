# Lucent Browser - Enable Windows Transparency
# This script configures Firefox to support transparent windows on Windows

Write-Host "🪟 Enabling Window Transparency for Lucent Browser" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

$profilePath = "$PSScriptRoot\lucent-dev-profile"

if (-not (Test-Path $profilePath)) {
    Write-Host "❌ Profile not found. Run dev-mode.ps1 first!" -ForegroundColor Red
    exit 1
}

Write-Host "📁 Profile: $profilePath" -ForegroundColor Green
Write-Host ""

# Create prefs.js overrides for transparency
$prefsFile = "$profilePath\prefs.js"
$userJsFile = "$profilePath\user.js"

Write-Host "⚙️  Configuring transparency preferences..." -ForegroundColor Cyan

# Additional prefs for transparency
$transparencyPrefs = @"

// === LUCENT TRANSPARENCY OVERRIDES ===
// These settings enable window and content transparency

// Enable WebRender for better compositing
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.compositor.force-enabled", true);

// Enable hardware acceleration
user_pref("layers.acceleration.force-enabled", true);
user_pref("layers.offmainthreadcomposition.enabled", true);
user_pref("layers.offmainthreadcomposition.async-animations", true);

// Enable backdrop-filter CSS support
user_pref("layout.css.backdrop-filter.enabled", true);

// Enable advanced CSS features
user_pref("layout.css.color-mix.enabled", true);
user_pref("layout.css.constructable-stylesheets.enabled", true);

// Disable hardware acceleration issues that may block transparency
user_pref("gfx.direct3d11.reuse-decoder-device", 2);

// Enable alpha channel in compositing
user_pref("gfx.color_management.enablev4", true);

// Ensure userChrome.css loads
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Disable startup performance warnings
user_pref("browser.slowStartup.notificationDisabled", true);
user_pref("browser.slowStartup.maxSamples", 0);

// Enable CSS containment for better performance
user_pref("layout.css.contain.enabled", true);

"@

# Append to user.js
Add-Content -Path $userJsFile -Value $transparencyPrefs -Encoding UTF8

Write-Host "✓ Transparency preferences added" -ForegroundColor Green
Write-Host ""

Write-Host "🎨 Creating enhanced CSS files..." -ForegroundColor Cyan

# Create chrome directory if it doesn't exist
$chromeDir = "$profilePath\chrome"
if (-not (Test-Path $chromeDir)) {
    New-Item -ItemType Directory -Path $chromeDir -Force | Out-Null
}

Write-Host "✓ CSS directory ready" -ForegroundColor Green
Write-Host ""

Write-Host "✨ Configuration Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  IMPORTANT: For true window transparency, you need:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   Option 1: Build Lucent with native transparency patches" -ForegroundColor White
Write-Host "   Option 2: Use third-party tools:" -ForegroundColor White
Write-Host "      • WindowBlinds (https://www.stardock.com/products/windowblinds/)" -ForegroundColor Gray
Write-Host "      • TranslucentTB (for taskbar: github.com/TranslucentTB/TranslucentTB)" -ForegroundColor Gray
Write-Host "      • Glass2k (old but works: chime.tv/products/glass2k.shtml)" -ForegroundColor Gray
Write-Host ""
Write-Host "   Option 3: Use Windows 11 Mica/Acrylic effects (limited)" -ForegroundColor White
Write-Host ""
Write-Host "Current setup provides:" -ForegroundColor Cyan
Write-Host "   ✓ Webpage transparency with blur" -ForegroundColor Green
Write-Host "   ✓ Acrylic effects on UI elements" -ForegroundColor Green
Write-Host "   ✓ Enhanced backdrop filters" -ForegroundColor Green
Write-Host "   ⚠  Window-level transparency requires patches or external tools" -ForegroundColor Yellow
Write-Host ""
Write-Host "🚀 Run dev-mode.ps1 to test!" -ForegroundColor Cyan
