# Building Lucent Browser from Source

This guide walks you through building Lucent Browser on Windows, Linux, and macOS.

## System Requirements

### Hardware
- **CPU**: Multi-core processor (4+ cores recommended)
- **RAM**: 8 GB minimum, 16 GB recommended
- **Disk Space**: 30 GB free space minimum
- **GPU**: Hardware acceleration recommended

### Time Estimate
- Initial setup: 30-60 minutes
- Compilation: 1-2 hours (depending on hardware)

## Prerequisites

### Windows

1. **Visual Studio 2022** (Community Edition is free)
   - Download: https://visualstudio.microsoft.com/downloads/
   - Select "Desktop development with C++"
   - Include: Windows 10/11 SDK

2. **MozillaBuild**
   - Download: https://ftp.mozilla.org/pub/mozilla/libraries/win32/MozillaBuildSetup-Latest.exe
   - Install to `C:\mozilla-build`

3. **Rust**
   - Download: https://rustup.rs
   - Run installer and follow prompts

4. **Git**
   - Download: https://git-scm.com/download/win
   - Use Git Bash or integrate with MozillaBuild

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install build dependencies
sudo apt install build-essential python3 python3-pip git \
  mercurial rustc cargo clang libclang-dev \
  nodejs npm yasm nasm libgtk-3-dev \
  libdbus-glib-1-dev libpulse-dev

# Additional dependencies (installed via mach bootstrap)
```

### macOS

```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install python rust mercurial
```

## Build Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Geneticscrol/lucent-browser.git
cd lucent-browser
```

### 2. Run Setup Script

The setup script downloads Firefox source code and prepares the build environment:

#### Linux/macOS:
```bash
python3 build-scripts/setup.py
```

#### Windows:
Open MozillaBuild shell (`C:\mozilla-build\start-shell.bat`) and run:
```bash
python build-scripts/setup.py
```

This will:
- Check dependencies
- Download Firefox ESR source code (~2-3 GB)
- Bootstrap the build environment
- Apply Lucent-specific patches

### 3. Build the Browser

#### Linux/macOS:
```bash
python3 build-scripts/build.py
```

#### Windows:
In MozillaBuild shell:
```bash
cd firefox-source
./mach build
```

**Note**: This step takes 1-2 hours. You can minimize the window and do other work.

### 4. Run Lucent Browser

#### Linux/macOS:
```bash
python3 build-scripts/run.py
```

#### Windows:
```bash
cd firefox-source
./mach run --profile ../lucent-profile
```

## Manual Build (Advanced)

If the automated scripts don't work, you can build manually:

### 1. Download Firefox Source

Using Mercurial (recommended):
```bash
hg clone https://hg.mozilla.org/releases/mozilla-esr115 firefox-source
cd firefox-source
```

Or download tarball:
```bash
wget https://archive.mozilla.org/pub/firefox/releases/115.6.0esr/source/firefox-115.6.0esr.source.tar.xz
tar xf firefox-115.6.0esr.source.tar.xz
mv firefox-115.6.0esr firefox-source
cd firefox-source
```

### 2. Copy Configuration

```bash
cp ../configs/mozconfig ./mozconfig
```

### 3. Bootstrap Build Environment

```bash
./mach bootstrap --application-choice=browser --no-interactive
```

### 4. Build

```bash
./mach build
```

### 5. Run

```bash
./mach run --profile ../lucent-profile
```

## Troubleshooting

### Build Fails with "command not found"

Make sure all dependencies are installed:
```bash
./mach bootstrap
```

### Out of Memory During Build

Reduce parallel jobs in `mozconfig`:
```
mk_add_options MOZ_MAKE_FLAGS="-j2"
```

### Windows: "Visual Studio not found"

Make sure you have:
- Visual Studio 2022 with C++ workload
- Windows 10/11 SDK
- Using MozillaBuild shell

### Linux: Missing libraries

Install additional dependencies:
```bash
sudo apt install libxt-dev libx11-xcb-dev \
  libasound2-dev libpango1.0-dev
```

### macOS: Xcode errors

Update Xcode Command Line Tools:
```bash
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

## Incremental Builds

After the first build, subsequent builds are much faster:

```bash
# Make your changes to the code
cd firefox-source
./mach build

# Run to test
./mach run --profile ../lucent-profile
```

## Creating a Package

To create a distributable package:

```bash
./mach package
```

The package will be in `obj-lucent/dist/`.

### Windows
Creates: `lucent-*.zip` and installer `.exe`

### Linux
Creates: `.tar.bz2` archive

### macOS
Creates: `.dmg` disk image

## Updating the Source

To update to a newer Firefox version:

```bash
cd firefox-source
hg pull
hg update -r FIREFOX_115_6_0_ESR  # Replace with desired version
./mach build
```

## Build Customization

### Changing Branding

Edit `firefox-source/browser/branding/lucent/` files:
- `branding.nsi` - Windows installer branding
- `configure.sh` - App name and IDs
- `locales/en-US/brand.properties` - Localized strings

### Modifying Defaults

Edit `configs/user.js` for different default preferences.

### Custom Patches

Place `.patch` files in `patches/` directory. They will be applied during setup.

## Development Tips

### Fast Iteration

For UI changes (CSS only):
1. Edit `chrome/userChrome.css` or `chrome/userContent.css`
2. Copy to profile: `cp chrome/*.css lucent-profile/chrome/`
3. Restart browser (no rebuild needed)

### Testing Changes

Use a separate profile for testing:
```bash
./mach run --profile /path/to/test-profile
```

### Debugging

Build with debug symbols:
```bash
# Edit mozconfig
ac_add_options --enable-debug
ac_add_options --disable-optimize

# Rebuild
./mach build
```

### Code Changes

After modifying C++/Rust code:
```bash
./mach build  # Rebuilds only changed files
```

## CI/CD

### GitHub Actions

We provide CI workflows for automated builds (coming soon):
- Windows: Build with Visual Studio
- Linux: Build on Ubuntu
- macOS: Build with Xcode

### Local Testing

Test before pushing:
```bash
# Clean build
rm -rf firefox-source/obj-lucent
./mach build

# Run tests
./mach test
```

## Next Steps

After building:
1. Read [CUSTOMIZATION.md](CUSTOMIZATION.md) to customize transparency
2. Read [PRIVACY.md](PRIVACY.md) to understand privacy features
3. Report issues on GitHub

## Additional Resources

- [Mozilla Firefox Build Documentation](https://firefox-source-docs.mozilla.org/setup/)
- [Firefox Source Tree](https://searchfox.org/)
- [Mozilla Developer Network](https://developer.mozilla.org/)

---

**Questions?** Open an issue on GitHub!
