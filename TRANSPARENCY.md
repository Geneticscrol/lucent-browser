# 🪟 Window Transparency Guide

This guide explains how to enable **true window-level transparency** for Lucent Browser.

## 🎨 What You Get

### Currently Active (No Installation Needed):
- ✅ **Acrylic blur on tabs** - Frosted glass effect
- ✅ **Translucent webpage backgrounds** - See through websites
- ✅ **Blurred UI elements** - All toolbars and menus
- ✅ **Backdrop filters** - Windows 11 Acrylic style

### With Window Transparency Module:
- ✅ **Transparent window frame** - True see-through browser
- ✅ **Adjustable opacity** - Control transparency level
- ✅ **Desktop visibility** - See your wallpaper through browser

## 🚀 Quick Start (Automatic)

### Step 1: Install Node.js
Download and install from: https://nodejs.org/

### Step 2: Install Transparency Module
```powershell
.\install-transparency.ps1
```

### Step 3: Run Browser with Transparency
```powershell
.\dev-mode.ps1
```

The script will automatically apply window transparency!

## 🔧 Manual Method

If automatic doesn't work:

### 1. Start Browser
```powershell
.\dev-mode.ps1
```

### 2. Apply Transparency (in another terminal)
```powershell
.\apply-transparency.ps1
```

## ⚙️ How It Works

### CSS-Based (Already Active):
- `userChrome.css` - Makes tabs and UI translucent
- `userContent.css` - Makes website backgrounds see-through
- Uses `backdrop-filter: blur()` for acrylic effect

### Windows API (Requires Node.js):
- Uses Windows `SetLayeredWindowAttributes` API
- Applies `WS_EX_LAYERED` window style
- Enables DWM blur-behind effects
- Works on Windows 10/11

## 📊 Transparency Levels

Edit `transparency-module.js` line 61 to adjust:

```javascript
enableTransparency(hwnd, 217); // 85% opacity
```

Values:
- `255` = Fully opaque (no transparency)
- `217` = 85% opacity (default, recommended)
- `191` = 75% opacity (more transparent)
- `128` = 50% opacity (very transparent)
- `64` = 25% opacity (extreme transparency)

## 🎨 Customizing Blur Effects

### Tab Blur
Edit `chrome/userChrome.css` line 52:
```css
backdrop-filter: blur(30px) saturate(180%) brightness(110%) !important;
```

### Website Blur
Edit `chrome/userContent.css` line 12:
```css
--lucent-blur-web: blur(25px) saturate(180%) brightness(110%) !important;
```

Adjust:
- `blur(Xpx)` - Higher = more blur
- `saturate(X%)` - Higher = more vibrant colors
- `brightness(X%)` - Higher = lighter appearance

## 🐛 Troubleshooting

### "Node.js not installed"
Install from: https://nodejs.org/
Restart PowerShell after installation.

### "Transparency module not installed"
Run: `.\install-transparency.ps1`

### "Firefox not found"
The script will show an error. Make sure Firefox is running.

### "Dependencies failed to install"
Some Windows systems need Visual Studio Build Tools:
```powershell
npm install --global windows-build-tools
```

Then retry: `.\install-transparency.ps1`

### Transparency Not Visible
1. Make sure you have a **visible wallpaper** behind Firefox
2. Close all other windows
3. Try increasing transparency (lower opacity value)
4. Check if Firefox window is maximized (transparency shows better in windowed mode)

### Performance Issues
If blur effects cause lag:

1. **Reduce blur strength** in CSS:
   ```css
   backdrop-filter: blur(15px) !important;
   ```

2. **Disable hardware acceleration** in `about:config`:
   - Set `gfx.webrender.all` to `false`

3. **Use simpler transparency** (just opacity, no blur):
   ```javascript
   enableTransparency(hwnd, 200); // No blur, just opacity
   ```

## 🔄 Auto-Start Transparency

### Option 1: Task Scheduler (Recommended)

Create a scheduled task that runs on login:

1. Open Task Scheduler
2. Create Task → Name: "Lucent Transparency"
3. Trigger: At log on
4. Action: Start Program
   - Program: `powershell.exe`
   - Arguments: `-File "C:\Users\YourName\Development\lucent\apply-transparency.ps1"`
5. Conditions: Uncheck "Start only if on AC power"

### Option 2: Startup Script

1. Create shortcut to `apply-transparency.ps1`
2. Place in: `shell:startup` (Win+R, type this)
3. Edit shortcut properties:
   - Target: `powershell.exe -WindowStyle Hidden -File "C:\path\to\apply-transparency.ps1"`

### Option 3: Watch Script (Advanced)

Create `watch-transparency.ps1`:
```powershell
while ($true) {
    $firefox = Get-Process firefox -ErrorAction SilentlyContinue
    if ($firefox) {
        & node .\transparency-module\transparency-module.js
        Start-Sleep -Seconds 60
    } else {
        Start-Sleep -Seconds 5
    }
}
```

Run in background: `Start-Process powershell -ArgumentList "-File watch-transparency.ps1" -WindowStyle Hidden`

## 🎯 Alternative Methods

If the Node.js module doesn't work:

### Method 1: AutoHotkey Script
```ahk
#Persistent
SetTimer, MakeTransparent, 1000
return

MakeTransparent:
WinGet, id, ID, A
WinSet, Transparent, 217, ahk_id %id%
return
```

### Method 2: Third-Party Tools
- **Glass2k** - Simple transparency tool (free)
- **WindowBlinds** - Advanced window customization ($)
- **TranslucentTB** - For Windows 11 acrylic effects (free)

### Method 3: PowerShell Only
```powershell
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
    [DllImport("user32.dll")]
    public static extern int SetLayeredWindowAttributes(IntPtr hwnd, int crKey, byte bAlpha, int dwFlags);
    [DllImport("user32.dll")]
    public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
    [DllImport("user32.dll")]
    public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
}
"@

$hwnd = [Win32]::FindWindow($null, "Mozilla Firefox")
$style = [Win32]::GetWindowLong($hwnd, -20)
[Win32]::SetWindowLong($hwnd, -20, $style -bor 0x80000)
[Win32]::SetLayeredWindowAttributes($hwnd, 0, 217, 2)
```

Save as `quick-transparency.ps1` and run when Firefox is open.

## 📈 Performance Impact

- **CSS Blur Effects**: ~5-10% CPU overhead
- **Window Transparency**: Minimal (<1%)
- **Combined**: ~10-15% CPU overhead

Impact varies by:
- GPU capabilities
- Number of open tabs
- Website complexity
- Screen resolution

## 🎨 Gallery

### Before:
Standard Firefox - Opaque windows

### After with CSS Only:
- Tabs have blur effect
- Websites semi-transparent
- UI elements frosted glass

### After with Window Module:
- Complete transparency
- See desktop through browser
- True acrylic effect

## 📚 Technical Details

### Windows API Used:
- `SetWindowLongA` - Modify window style
- `SetLayeredWindowAttributes` - Set transparency
- `DwmSetWindowAttribute` - Enable Mica/Acrylic (Win11)
- `DwmEnableBlurBehindWindow` - Enable blur-behind

### CSS Properties:
- `backdrop-filter` - Blur effect
- `background: transparent` - Remove backgrounds
- `-webkit-backdrop-filter` - WebKit support

### Firefox Prefs:
- `gfx.webrender.all` - Enable WebRender
- `layout.css.backdrop-filter.enabled` - Enable CSS filters
- `toolkit.legacyUserProfileCustomizations.stylesheets` - Enable userChrome

## 🆘 Support

Issues? Check:
1. Is Node.js installed? `node --version`
2. Is Firefox running? Check Task Manager
3. Are CSS files loaded? Check Browser Console (Ctrl+Shift+J)
4. Is wallpaper visible behind Firefox?

Still stuck? Open an issue on GitHub!

---

**Enjoy your translucent browsing experience!** ✨🪟
