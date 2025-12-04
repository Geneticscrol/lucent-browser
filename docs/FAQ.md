# Frequently Asked Questions

## General Questions

### What is Lucent Browser?

Lucent Browser is a privacy-focused, translucent browser based on Firefox ESR. It features a transparent UI and the ability to render websites with translucent backgrounds while maintaining strong privacy protections.

### Is it free?

Yes! Lucent Browser is completely free and open source under the Mozilla Public License 2.0.

### Why fork Firefox?

Firefox provides an excellent foundation with its open-source Gecko engine and strong baseline privacy. We fork it to add translucency features and enhanced privacy configurations that aren't available in standard Firefox.

### Is this affiliated with Mozilla?

No, Lucent Browser is an independent project and is not affiliated with or endorsed by Mozilla.

## Privacy & Security

### Is Lucent Browser really private?

Yes! We disable all telemetry, implement first-party isolation, enable HTTPS-only mode by default, and use DNS over HTTPS. See [PRIVACY.md](PRIVACY.md) for full details.

### Should I use Lucent or Tor Browser?

- **Lucent**: For daily browsing with strong privacy
- **Tor**: For anonymity and accessing .onion sites

Lucent focuses on privacy, not anonymity. For maximum anonymity, use Tor Browser.

### Does Lucent collect any data?

No. All telemetry and data reporting is completely disabled.

### Can websites still track me?

Lucent blocks most tracking, but:
- ✅ Blocks: Cookies, trackers, fingerprinting
- ❌ Can't block: Tracking via login (if you log into Google, they know it's you)

### Is it safe for banking/shopping?

Yes! HTTPS-only mode ensures secure connections. However, the visual transparency doesn't affect security.

## Translucency Features

### How does the translucency work?

Lucent uses native OS transparency APIs and CSS modifications to make both the browser window and webpage backgrounds translucent.

### Can I adjust the transparency level?

Yes! Edit `userChrome.css` and `userContent.css` in your profile directory. See [CUSTOMIZATION.md](CUSTOMIZATION.md).

### Does transparency affect performance?

There's a small overhead (~5-10% CPU) for compositing, but it's minimal on modern hardware with GPU acceleration.

### Can I disable transparency?

Yes! Set opacity to `1.0` in the CSS files or use standard Firefox if you don't want transparency.

### Does it work on all operating systems?

Yes, but the effect varies:
- **Windows 11**: Best support with Acrylic/Mica effects
- **Windows 10**: Good support
- **macOS**: Excellent with Vibrancy effects
- **Linux**: Works with compositors (X11/Wayland)

## Compatibility

### Will my Firefox extensions work?

Most extensions work fine! However:
- ✅ Compatible: uBlock Origin, Privacy Badger, Bitwarden, etc.
- ⚠️ May have issues: Extensions that modify UI heavily
- ❌ Won't work: Extensions requiring Mozilla services (Sync)

### Can I sync with Firefox?

No, Firefox Sync is disabled for privacy. Use:
- Local bookmark exports
- Third-party sync tools (Syncthing, etc.)
- Manual backup

### Do websites display correctly?

Most websites work perfectly. Occasionally you may need to adjust transparency for specific sites. See customization guide.

### Does it support Firefox profiles?

Yes! Lucent uses Firefox's profile system. You can have multiple profiles with different settings.

## Building & Installation

### How long does it take to build?

- Initial setup: 30-60 minutes
- Compilation: 1-2 hours (varies by hardware)

### What are the system requirements to build?

- 8 GB RAM minimum (16 GB recommended)
- 30 GB free disk space
- Multi-core CPU
- Good internet connection

### Are pre-built binaries available?

Not yet, but coming soon! Check the [Releases](https://github.com/Geneticscrol/lucent-browser/releases) page.

### Can I build on Raspberry Pi?

Theoretically yes, but it will take many hours (8-12+). Not recommended.

### Do I need to rebuild after every update?

Yes, to get Firefox security updates, you need to rebuild. We recommend monthly builds.

## Usage

### How do I import bookmarks from Chrome/Firefox?

1. Export bookmarks from your current browser
2. In Lucent, go to Bookmarks > Manage Bookmarks
3. Import > HTML file

### Can I use Chrome extensions?

No, only Firefox extensions are compatible.

### How do I set as default browser?

Settings > General > Make Default Browser

Note: On first run, the OS may not recognize "Lucent" yet. You may need to set it manually in OS settings.

### Where are my bookmarks stored?

In the profile directory:
- Windows: `%APPDATA%\Lucent\Profiles\xxx.default\`
- Linux: `~/.lucent/xxx.default/`
- macOS: `~/Library/Application Support/Lucent/Profiles/xxx.default/`

### Can I have multiple profiles?

Yes! Run: `lucent --ProfileManager` to create/manage profiles.

## Troubleshooting

### Transparency isn't working

1. Check `about:config` for `toolkit.legacyUserProfileCustomizations.stylesheets` = `true`
2. Verify CSS files exist in profile's `chrome/` directory
3. Restart browser
4. On Linux, ensure compositor is running

### Browser crashes on startup

Try:
1. Start in safe mode: `lucent --safe-mode`
2. Create new profile: `lucent --ProfileManager`
3. Check graphics drivers are updated
4. Disable hardware acceleration in Settings

### Websites look broken

1. Adjust transparency in `userContent.css`
2. Add site-specific overrides
3. Temporarily disable content transparency

### Performance is slow

1. Reduce blur strength in CSS
2. Enable hardware acceleration
3. Close unused tabs
4. Increase RAM if system has < 8 GB

### Text is hard to read

1. Increase opacity values in CSS
2. Use darker backgrounds
3. Enable high contrast mode in OS

### Can't compile / build fails

See [BUILD.md](BUILD.md) troubleshooting section. Common issues:
- Missing dependencies
- Insufficient disk space
- Wrong compiler version

## Contributing

### How can I contribute?

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Reporting bugs
- Suggesting features
- Submitting pull requests
- Improving documentation

### I found a security issue!

Please report security vulnerabilities privately by emailing: [create a security contact]

Do not open public issues for security vulnerabilities.

### Can I donate?

Not currently accepting donations, but contributions via code, documentation, and testing are appreciated!

## Updates & Maintenance

### How often is Lucent updated?

We aim to track Firefox ESR releases (every ~6-8 weeks for security updates, yearly for major versions).

### How do I update Lucent?

Currently, rebuild from source. Future versions will have auto-update.

### What Firefox version is Lucent based on?

Currently based on Firefox ESR 115. Check README for latest version.

### Will Lucent stay updated?

Yes! Security updates from Firefox ESR will be integrated regularly.

## Comparison

### Lucent vs LibreWolf?

| Feature | Lucent | LibreWolf |
|---------|--------|-----------|
| Translucency | ✅ Yes | ❌ No |
| Privacy | ✅✅ Excellent | ✅✅ Excellent |
| Pre-built | ⏳ Soon | ✅ Yes |
| Customization | ✅✅ High | ✅ Good |

### Lucent vs Brave?

| Feature | Lucent | Brave |
|---------|--------|-------|
| Engine | Gecko (Firefox) | Chromium |
| Translucency | ✅ Yes | ❌ No |
| Privacy | ✅✅ Excellent | ✅ Good |
| Crypto/Ads | ❌ No | ⚠️ Has BAT |

### Lucent vs Firefox?

Lucent = Firefox + Privacy hardening + Translucency

## Getting Help

### Where can I get help?

1. Check this FAQ
2. Read documentation in `docs/`
3. Search [GitHub Issues](https://github.com/Geneticscrol/lucent-browser/issues)
4. Create a new issue
5. Join discussions

### How do I report a bug?

Open an issue on GitHub with:
- Clear description
- Steps to reproduce
- System information
- Screenshots if applicable

### Feature requests?

Open an issue with the "feature request" label and describe your idea!

---

**Still have questions?** Open an issue on GitHub!
