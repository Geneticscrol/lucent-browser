# 🌟 Lucent Browser

A translucent, privacy-focused browser fork of Firefox - see the world through your browser.

![Status](https://img.shields.io/badge/status-alpha-orange)
![Privacy](https://img.shields.io/badge/privacy-focused-green)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)

## ✨ Features

### 🪟 Translucent UI
- **True window transparency** - The browser window itself is translucent
- **Translucent web content** - Websites render with semi-transparent backgrounds
- **Customizable opacity levels** - Adjust transparency to your preference
- **Blur effects** - Optional backdrop blur for better readability

### 🔒 Privacy-First
- **No telemetry** - All Firefox telemetry disabled by default
- **Enhanced tracking protection** - Blocks trackers, cookies, and fingerprinting
- **Hardened configurations** - Based on Arkenfox user.js project
- **No sponsored content** - Removes all Mozilla pocket, ads, and recommendations
- **DNS over HTTPS** - Encrypted DNS queries by default

### 🎨 Visual Features
- Acrylic/Mica-like effects on Windows 11
- Smooth animations and transitions
- Custom theme optimized for translucency
- Minimal, distraction-free interface

## 🏗️ Architecture

Lucent Browser is built on top of Mozilla Firefox ESR with the following modifications:

1. **UI Layer** - Custom `userChrome.css` and `userContent.css` for translucency
2. **Rendering Engine** - Patches to Gecko to support transparent webpage backgrounds
3. **Privacy Layer** - Hardened `user.js` configuration
4. **Build System** - Custom `mozconfig` for compilation

## 🚀 Quick Start

### Prerequisites
- **Windows**: Windows 10/11 with Visual Studio 2022
- **Linux**: GCC/Clang, Python 3, Rust
- **macOS**: Xcode Command Line Tools
- At least 30GB of free disk space
- 8GB RAM minimum (16GB recommended)

### Building from Source

```bash
# Clone the repository
git clone https://github.com/Geneticscrol/lucent-browser.git
cd lucent-browser

# Initialize Firefox source
python build-scripts/setup.py

# Build the browser
python build-scripts/build.py

# Run Lucent Browser
python build-scripts/run.py
```

### Pre-built Binaries

Coming soon! Check the [Releases](https://github.com/Geneticscrol/lucent-browser/releases) page.

## 📁 Project Structure

```
lucent-browser/
├── build-scripts/          # Build automation scripts
│   ├── setup.py           # Downloads and sets up Firefox source
│   ├── build.py           # Compiles the browser
│   └── run.py             # Launches the built browser
├── configs/               # Configuration files
│   ├── mozconfig          # Firefox build configuration
│   ├── user.js            # Privacy-hardened preferences
│   └── policies.json      # Enterprise policies
├── chrome/                # UI customization
│   ├── userChrome.css     # Browser UI transparency
│   └── userContent.css    # Webpage content transparency
├── patches/               # Source code patches
│   ├── translucent-window.patch
│   └── transparent-content.patch
├── branding/              # Custom branding assets
│   ├── logo.svg
│   └── icons/
└── docs/                  # Documentation
    ├── BUILD.md           # Detailed build instructions
    ├── PRIVACY.md         # Privacy features documentation
    └── CUSTOMIZATION.md   # How to customize transparency
```

## 🎨 Customization

### Adjusting Transparency

Edit `chrome/userChrome.css` and modify the opacity values:

```css
:root {
  --lucent-window-opacity: 0.85;    /* Window transparency (0.0 - 1.0) */
  --lucent-content-opacity: 0.90;   /* Content transparency */
  --lucent-blur-strength: 20px;     /* Backdrop blur amount */
}
```

### Privacy Settings

All privacy settings are in `configs/user.js`. Key preferences:

- Telemetry completely disabled
- WebRTC leak protection
- Fingerprinting resistance
- Cookie isolation
- DNS over HTTPS (Cloudflare by default)

## 🔧 Technical Details

### Translucency Implementation

The translucent effect is achieved through:

1. **Window-level transparency** - Native OS APIs for transparent windows
   - Windows: DWM composition with `WS_EX_LAYERED`
   - Linux: Compositor support via X11/Wayland
   - macOS: `NSWindow` transparency

2. **Content-level transparency** - CSS modifications
   - Injected stylesheets for all web content
   - Background color overrides with alpha channel
   - Preservation of images and media

3. **Rendering pipeline** - Gecko patches
   - Modified compositor to handle alpha blending
   - Background layer transparency support

### Performance Impact

- **CPU**: ~5-10% overhead for transparency compositing
- **GPU**: Minimal impact with hardware acceleration
- **Memory**: Same as standard Firefox

## 🛡️ Privacy Features

Lucent Browser includes these privacy enhancements:

- ✅ All telemetry removed
- ✅ No Google Safe Browsing (uses local lists)
- ✅ WebRTC disabled by default
- ✅ Fingerprinting protection
- ✅ First-party isolation
- ✅ HTTPS-only mode
- ✅ DoH with Cloudflare/Quad9
- ✅ No Mozilla account sync
- ✅ No Pocket integration
- ✅ No sponsored shortcuts

## 📖 Documentation

- [Building from Source](docs/BUILD.md)
- [Privacy Features](docs/PRIVACY.md)
- [Customization Guide](docs/CUSTOMIZATION.md)
- [FAQ](docs/FAQ.md)

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

### Development Setup

```bash
# Fork the repo and clone your fork
git clone https://github.com/YOUR_USERNAME/lucent-browser.git

# Create a feature branch
git checkout -b feature/your-feature

# Make your changes and commit
git commit -am "Add your feature"

# Push and create a PR
git push origin feature/your-feature
```

## 📜 License

This project is licensed under the Mozilla Public License 2.0 - see [LICENSE](LICENSE) for details.

Firefox source code is licensed under MPL 2.0 by Mozilla Foundation.

## ⚠️ Disclaimer

This is an independent project and is not affiliated with Mozilla or the Firefox project. Firefox and the Firefox logo are trademarks of the Mozilla Foundation.

## 🙏 Acknowledgments

- **Mozilla Firefox** - The foundation of this browser
- **Arkenfox** - Privacy configuration inspiration
- **LibreWolf** - Privacy-focused fork reference
- All contributors to the Firefox project

## 📬 Contact

- GitHub Issues: [Report bugs or request features](https://github.com/Geneticscrol/lucent-browser/issues)
- Project Maintainer: [@Geneticscrol](https://github.com/Geneticscrol)

---

**Made with transparency and privacy in mind** 🌟🔒
