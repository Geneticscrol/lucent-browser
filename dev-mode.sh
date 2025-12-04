#!/bin/bash
# Lucent Browser - Development Mode (Linux/macOS)
# Test CSS changes instantly without rebuilding!

echo -e "\e[96m🚀 Lucent Browser - Development Mode\e[0m"
echo "============================================================"
echo ""

# Find Firefox
if command -v firefox &> /dev/null; then
    FIREFOX_EXE="firefox"
elif [ -f "/Applications/Firefox.app/Contents/MacOS/firefox" ]; then
    FIREFOX_EXE="/Applications/Firefox.app/Contents/MacOS/firefox"
else
    echo -e "\e[91m❌ Firefox not found!\e[0m"
    echo -e "\e[93m📥 Please install Firefox first\e[0m"
    exit 1
fi

echo -e "\e[92m✓ Found Firefox: $FIREFOX_EXE\e[0m"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEV_PROFILE="$SCRIPT_DIR/lucent-dev-profile"

# Create dev profile
if [ ! -d "$DEV_PROFILE" ]; then
    echo -e "\e[96m📁 Creating development profile...\e[0m"
    mkdir -p "$DEV_PROFILE/chrome"
fi

# Copy user.js
echo -e "\e[96m⚙️  Copying privacy configuration...\e[0m"
cp "$SCRIPT_DIR/configs/user.js" "$DEV_PROFILE/user.js"

# Create symlinks for live editing
echo -e "\e[96m🎨 Setting up CSS files for live editing...\e[0m"
ln -sf "$SCRIPT_DIR/chrome/userChrome.css" "$DEV_PROFILE/chrome/userChrome.css"
ln -sf "$SCRIPT_DIR/chrome/userContent.css" "$DEV_PROFILE/chrome/userContent.css"

echo -e "\e[92m✓ Created symlinks - CSS changes will apply instantly!\e[0m"
echo ""

echo -e "\e[92m🎯 Development Mode Active!\e[0m"
echo ""
echo -e "\e[96m📝 To modify styles:\e[0m"
echo -e "   - Edit: chrome/userChrome.css (browser UI)"
echo -e "   - Edit: chrome/userContent.css (web pages)"
echo -e "   - Changes apply after browser restart (Ctrl+Q then rerun)"
echo ""

echo -e "\e[96m🔧 Useful shortcuts while testing:\e[0m"
echo -e "   - Ctrl+Shift+Alt+I : Browser Toolbox (inspect UI)"
echo -e "   - Ctrl+Shift+J     : Browser Console (see CSS errors)"
echo -e "   - Ctrl+Q           : Quit browser"
echo -e "   - about:config     : Advanced settings"
echo ""

echo -e "\e[96m🚀 Launching Lucent Browser in development mode...\e[0m"
echo ""

# Launch Firefox with dev profile
$FIREFOX_EXE -no-remote -profile "$DEV_PROFILE"

echo ""
echo -e "\e[92m✨ Browser closed. Run this script again to test changes!\e[0m"
