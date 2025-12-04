# Development Guide for Lucent Browser

This guide helps you test and develop Lucent Browser features quickly without rebuilding Firefox repeatedly.

## 🚀 Quick Start for Development

### Method 1: Development Mode (Recommended for CSS/Config Changes)

**Best for:** Testing transparency styles, privacy configs, UI tweaks

**Windows:**
```powershell
.\dev-mode.ps1
```

**Linux/macOS:**
```bash
chmod +x dev-mode.sh
./dev-mode.sh
```

This launches regular Firefox with Lucent customizations. Changes to CSS files apply after browser restart (no rebuild needed!).

### Method 2: Docker Development (Full Isolation)

**Best for:** Testing the complete build, ensuring cross-platform compatibility

```bash
cd docker
docker-compose up --build
```

### Method 3: Full Build (Only When Needed)

**When to use:** Testing patches, engine modifications, branding changes

See [BUILD.md](docs/BUILD.md) for full build instructions.

## 📁 What Can Be Changed Without Rebuilding?

### ✅ No Rebuild Required

These changes apply instantly (just restart browser):

- **CSS Styling** (`chrome/userChrome.css`, `chrome/userContent.css`)
  - Transparency levels
  - Colors, blur effects
  - UI layout
  
- **Privacy Settings** (`configs/user.js`)
  - Telemetry toggles
  - Privacy preferences
  - Feature flags

- **About Pages** (if using dev-mode)
  - Custom start pages
  - Bookmark layouts

### 🔨 Rebuild Required

These changes need recompilation:

- C++ code modifications
- Rust components
- Gecko engine patches
- Custom branding (icons, logos)
- JavaScript modules
- XUL/XHTML structure

## 🎨 Development Workflow for UI Changes

### 1. Start Development Mode

```powershell
.\dev-mode.ps1
```

### 2. Edit CSS Files

Open in your favorite editor:
- `chrome/userChrome.css` - Browser UI
- `chrome/userContent.css` - Web page styling

### 3. Test Changes

1. Make your CSS edits
2. Close browser (Ctrl+Shift+Q or Ctrl+Q)
3. Rerun dev-mode script
4. See your changes instantly!

### 4. Debug CSS Issues

While browser is open:
- Press `Ctrl+Shift+Alt+I` - Opens Browser Toolbox
- Press `Ctrl+Shift+J` - Opens Browser Console
- Check for CSS syntax errors in console

### 5. Iterate Fast

The dev-mode creates symlinks (or copies) so you can:
- Edit CSS in your editor
- Restart browser
- See changes immediately
- No waiting for compilation!

## 🔧 Common Development Tasks

### Change Transparency Level

Edit `chrome/userChrome.css`:
```css
:root {
  --lucent-window-opacity: 0.85;  /* Change this value */
}
```

Restart browser to see changes.

### Test Different Color Schemes

Edit color variables in `userChrome.css`:
```css
:root {
  --lucent-bg-primary: rgba(30, 30, 35, 0.7);
  --lucent-accent: rgba(100, 150, 255, 0.8);
}
```

### Disable Transparency Temporarily

Add at top of `userChrome.css`:
```css
:root {
  --lucent-window-opacity: 1.0 !important;
}
```

### Test Privacy Settings

Edit `configs/user.js`, then copy to dev profile:
```powershell
Copy-Item configs\user.js lucent-dev-profile\user.js
```

Restart browser.

## 🐛 Debugging

### CSS Not Loading?

1. Check `about:config`
2. Search: `toolkit.legacyUserProfileCustomizations.stylesheets`
3. Must be `true`

### Changes Not Applying?

1. Hard refresh: Close browser completely
2. Clear startup cache: Delete `lucent-dev-profile/startupCache/`
3. Restart dev-mode script

### Finding CSS Selectors

1. Open Browser Toolbox: `Ctrl+Shift+Alt+I`
2. Click inspector icon (top-left)
3. Click on UI element you want to style
4. See CSS selectors in inspector

### Performance Issues?

Monitor in Browser Console (`Ctrl+Shift+J`):
- Look for CSS warnings
- Check for layout reflows
- Measure paint times

## 📊 Testing Checklist

Before committing changes:

### UI Testing
- [ ] Test on light and dark wallpapers
- [ ] Test with different screen resolutions
- [ ] Check all menus are readable
- [ ] Verify tabs are distinguishable
- [ ] Test URL bar focus states

### Privacy Testing
- [ ] Visit https://coveryourtracks.eff.org/
- [ ] Check https://dnsleaktest.com/
- [ ] Test https://browserleaks.com/webrtc
- [ ] Verify no telemetry in Network panel

### Compatibility Testing
- [ ] Test on popular websites (Google, YouTube, GitHub)
- [ ] Check login forms work
- [ ] Verify no broken layouts
- [ ] Test with extensions installed

### Performance Testing
- [ ] Open 20+ tabs - check memory usage
- [ ] Test video playback
- [ ] Monitor CPU usage with transparency
- [ ] Check for memory leaks (leave open for hours)

## 🔄 Git Workflow

### Create Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### Test Your Changes

```bash
.\dev-mode.ps1  # Test changes
```

### Commit Changes

```bash
git add chrome/userChrome.css
git commit -m "feat: improve tab transparency"
```

### Push and Create PR

```bash
git push origin feature/your-feature-name
```

## 📦 When You Need a Full Build

Only rebuild when:
1. Updating to new Firefox version
2. Applying engine patches
3. Changing branding
4. Modifying compiled code

Build process:
```bash
cd firefox-source
./mach build
./mach run --profile ../lucent-dev-profile
```

## 🎯 Tips for Efficient Development

### 1. Use Multiple Profiles

```bash
# Create test profiles for different scenarios
firefox -no-remote -profile ./test-profile-minimal
firefox -no-remote -profile ./test-profile-maximal
```

### 2. Version Control Your Profiles

```bash
# Backup working profile
cp -r lucent-dev-profile lucent-dev-profile.backup
```

### 3. Automate Testing

Create test scripts for common scenarios:
```powershell
# test-transparency.ps1
.\dev-mode.ps1
# Add automated UI tests here
```

### 4. Use CSS Variables

Define variables in `:root` for easy experimentation:
```css
:root {
  --test-opacity: 0.85;
  --test-blur: 20px;
}

#main-window {
  opacity: var(--test-opacity);
  backdrop-filter: blur(var(--test-blur));
}
```

### 5. Keep a Change Log

Document what you tested:
```markdown
## 2025-12-04
- Tested opacity at 0.7, 0.8, 0.9
- Best readability at 0.85
- Blur at 20px optimal for Windows 11
```

## 🚀 Advanced: Hot Reload Setup

For even faster development, set up file watchers:

```powershell
# Watch for CSS changes and auto-restart browser
# (requires Node.js and nodemon)
npm install -g nodemon
nodemon --watch chrome --exec ".\dev-mode.ps1"
```

## 📚 Resources

- [Firefox Browser Toolbox Docs](https://firefox-source-docs.mozilla.org/devtools-user/browser_toolbox/)
- [userChrome.css Reference](https://www.userchrome.org/)
- [CSS Debugging Guide](https://developer.mozilla.org/en-US/docs/Tools/Browser_Toolbox)

---

**Happy developing!** 🎨✨
