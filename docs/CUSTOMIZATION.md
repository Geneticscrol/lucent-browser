# Customizing Lucent Browser

This guide shows you how to customize the translucency and appearance of Lucent Browser.

## Adjusting Window Transparency

### Method 1: Edit userChrome.css

1. Navigate to your profile directory:
   - Windows: `%APPDATA%\Lucent\Profiles\xxx.default\chrome\`
   - Linux: `~/.lucent/xxx.default/chrome/`
   - macOS: `~/Library/Application Support/Lucent/Profiles/xxx.default/chrome/`

2. Open `userChrome.css` in a text editor

3. Find the root variables section (near the top):

```css
:root {
  --lucent-window-opacity: 0.85;    /* Window transparency */
  --lucent-toolbar-opacity: 0.75;   /* Toolbar transparency */
  --lucent-sidebar-opacity: 0.80;   /* Sidebar transparency */
  --lucent-menu-opacity: 0.90;      /* Menu transparency */
  --lucent-blur-strength: 20px;     /* Backdrop blur */
}
```

4. Adjust the values:
   - `0.0` = Fully transparent
   - `1.0` = Fully opaque
   - Recommended range: `0.7` to `0.95`

5. Restart Lucent Browser to see changes

### Example Configurations

**Maximum Transparency (may affect readability):**
```css
:root {
  --lucent-window-opacity: 0.70;
  --lucent-toolbar-opacity: 0.60;
  --lucent-blur-strength: 30px;
}
```

**Subtle Transparency (recommended for daily use):**
```css
:root {
  --lucent-window-opacity: 0.90;
  --lucent-toolbar-opacity: 0.85;
  --lucent-blur-strength: 15px;
}
```

**Glass Effect (Windows 11 style):**
```css
:root {
  --lucent-window-opacity: 0.80;
  --lucent-blur-strength: 25px;
}

@media (-moz-platform: windows) {
  #main-window {
    backdrop-filter: blur(30px) saturate(1.8);
  }
}
```

## Adjusting Webpage Transparency

### Edit userContent.css

1. Open `userContent.css` in the same `chrome/` directory

2. Find the root variables:

```css
:root {
  --lucent-content-opacity: 0.90;
  --lucent-bg-override: rgba(255, 255, 255, 0.05);
}
```

3. Adjust transparency:
   - Lower `--lucent-content-opacity` for more transparency
   - Adjust `--lucent-bg-override` alpha value (last number)

### Per-Site Customization

Add site-specific rules to `userContent.css`:

```css
/* Make GitHub more transparent */
@-moz-document domain(github.com) {
  body {
    background: rgba(13, 17, 23, 0.5) !important;
  }
  
  .Header {
    background: rgba(36, 41, 47, 0.6) !important;
  }
}

/* Make YouTube darker */
@-moz-document domain(youtube.com) {
  ytd-app {
    background: rgba(15, 15, 15, 0.7) !important;
  }
}
```

## Color Schemes

### Dark Theme (Default)

Already configured in `userChrome.css`. Uses dark colors optimized for transparency.

### Light Theme

Add to `userChrome.css`:

```css
@media (prefers-color-scheme: light) {
  :root {
    --lucent-bg-primary: rgba(240, 240, 245, 0.7);
    --lucent-bg-secondary: rgba(250, 250, 255, 0.6);
    --lucent-text: rgba(0, 0, 0, 0.95);
  }
}
```

### Custom Colors

```css
:root {
  /* Purple theme */
  --lucent-accent: rgba(138, 43, 226, 0.8);
  --lucent-bg-primary: rgba(30, 20, 40, 0.7);
  
  /* Blue theme */
  /* --lucent-accent: rgba(0, 122, 255, 0.8); */
  /* --lucent-bg-primary: rgba(20, 30, 50, 0.7); */
}
```

## Blur Effects

### Adjust Blur Strength

```css
:root {
  /* Subtle blur */
  --lucent-blur-strength: 10px;
  
  /* Strong blur */
  --lucent-blur-strength: 40px;
  
  /* No blur (not recommended) */
  --lucent-blur-strength: 0px;
}
```

### Platform-Specific Blur

```css
/* Windows - Acrylic effect */
@media (-moz-platform: windows) {
  #main-window {
    backdrop-filter: blur(30px) saturate(1.5) brightness(1.1);
  }
}

/* macOS - Vibrancy effect */
@media (-moz-platform: macos) {
  #main-window {
    backdrop-filter: blur(40px) saturate(1.8);
  }
}

/* Linux - Simple blur */
@media (-moz-platform: linux) {
  #main-window {
    backdrop-filter: blur(20px);
  }
}
```

## Advanced Customizations

### Tab Transparency

```css
.tabbrowser-tab {
  background: rgba(30, 30, 35, 0.5) !important;
}

.tabbrowser-tab[selected="true"] {
  background: rgba(50, 50, 55, 0.8) !important;
  border-bottom: 3px solid var(--lucent-accent) !important;
}
```

### URL Bar Styling

```css
#urlbar {
  background: rgba(40, 40, 45, 0.7) !important;
  border: 2px solid rgba(100, 150, 255, 0.3) !important;
  border-radius: 12px !important;
}

#urlbar[focused="true"] {
  background: rgba(50, 50, 55, 0.9) !important;
  box-shadow: 0 0 20px rgba(100, 150, 255, 0.4) !important;
}
```

### Sidebar Transparency

```css
#sidebar-box {
  background: rgba(25, 25, 30, 0.8) !important;
  backdrop-filter: blur(25px);
  border-right: 1px solid rgba(255, 255, 255, 0.15) !important;
}
```

## Disable Transparency (Temporarily)

If transparency affects readability on certain screens:

### Quick Disable

Add to top of `userChrome.css`:

```css
:root {
  --lucent-window-opacity: 1.0 !important;
  --lucent-toolbar-opacity: 1.0 !important;
  --lucent-blur-strength: 0px !important;
}

#main-window {
  background: #1a1a1a !important;
  backdrop-filter: none !important;
}
```

### Per-Website Disable

Add to `userContent.css`:

```css
/* Disable transparency on specific sites */
@-moz-document domain(example.com) {
  body {
    background: white !important;
    opacity: 1 !important;
  }
}
```

## Performance Optimization

If transparency causes performance issues:

```css
/* Reduce blur for better performance */
:root {
  --lucent-blur-strength: 10px;
}

/* Disable animations */
* {
  transition: none !important;
  animation: none !important;
}

/* Simplify transparency */
#main-window {
  backdrop-filter: none !important;
}
```

## Troubleshooting

### Transparency Not Working

1. Check if `toolkit.legacyUserProfileCustomizations.stylesheets` is `true` in `about:config`
2. Verify CSS files are in correct location
3. Restart browser after changes
4. Check for CSS syntax errors

### Text Hard to Read

1. Increase opacity values
2. Increase blur strength
3. Use darker background colors
4. Enable high contrast mode

### Performance Issues

1. Reduce blur strength
2. Increase opacity (less compositing)
3. Disable hardware acceleration if glitchy
4. Use simpler color scheme

## Backup Your Customizations

Always backup your custom CSS files:

```bash
# Backup
cp ~/.lucent/xxx.default/chrome/userChrome.css ~/userChrome.css.backup

# Restore
cp ~/userChrome.css.backup ~/.lucent/xxx.default/chrome/userChrome.css
```

## Share Your Theme

Created an awesome theme? Share it!

1. Export your CSS files
2. Take screenshots
3. Create a GitHub Gist or discussion
4. Share with the community

## Resources

- [CSS Reference](https://developer.mozilla.org/en-US/docs/Web/CSS)
- [Firefox CSS Tweaks](https://www.userchrome.org/)
- [Color Picker](https://htmlcolorcodes.com/)

---

**Have fun customizing!** 🎨
