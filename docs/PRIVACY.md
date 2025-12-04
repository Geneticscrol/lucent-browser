# Privacy Features

Lucent Browser is designed with privacy as a core principle. This document details all privacy enhancements and how they protect you.

## 🛡️ Overview

Lucent Browser is based on Firefox ESR with extensive privacy hardening inspired by:
- **Arkenfox user.js** - Community-driven privacy configuration
- **LibreWolf** - Privacy-focused Firefox fork
- **Tor Browser** - Anonymity-focused browser

## 🔒 Privacy Features

### 1. Telemetry Elimination

**What is telemetry?**
Telemetry is data collected about your browsing behavior sent back to Mozilla.

**Lucent removes:**
- ✅ All Firefox telemetry pings
- ✅ Health reports
- ✅ Crash reporter data collection
- ✅ Usage statistics
- ✅ Performance metrics
- ✅ Firefox Studies (experiments)
- ✅ Normandy (remote configuration)

**Configuration:**
```javascript
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
```

### 2. Tracking Protection

**Enhanced tracking protection blocks:**
- 🚫 Cross-site trackers
- 🚫 Social media trackers
- 🚫 Tracking cookies
- 🚫 Cryptominers
- 🚫 Fingerprinting scripts

**Configuration:**
```javascript
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
```

### 3. Fingerprinting Resistance

**What is fingerprinting?**
Websites can identify you by collecting information about your browser, fonts, screen resolution, etc.

**Lucent protects against:**
- 🔐 Canvas fingerprinting
- 🔐 WebGL fingerprinting
- 🔐 Audio fingerprinting
- 🔐 Font enumeration
- 🔐 Screen resolution tracking
- 🔐 Battery status API
- 🔐 Gamepad API

**Configuration:**
```javascript
user_pref("privacy.resistFingerprinting", true);
user_pref("browser.display.use_document_fonts", 0);
user_pref("dom.battery.enabled", false);
```

### 4. First-Party Isolation

**What is FPI?**
Separates cookies and cache by website domain, preventing cross-site tracking.

**Benefits:**
- Each website has its own cookie jar
- Third-party trackers can't follow you across sites
- More effective than just blocking third-party cookies

**Configuration:**
```javascript
user_pref("privacy.firstparty.isolate", true);
user_pref("network.cookie.cookieBehavior", 5); // Total Cookie Protection
```

### 5. DNS over HTTPS (DoH)

**What is DoH?**
Encrypts DNS queries so your ISP can't see what websites you visit.

**Default provider:** Cloudflare (Mozilla's DNS)
- No logging of personally identifiable information
- GDPR compliant
- Open source

**Alternative providers:**
- Quad9: `https://dns.quad9.net/dns-query`
- NextDNS: `https://dns.nextdns.io/`

**Configuration:**
```javascript
user_pref("network.trr.mode", 3); // DoH only, no fallback
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
```

### 6. WebRTC Protection

**The problem:**
WebRTC can leak your real IP address even when using a VPN.

**Lucent's solution:**
- WebRTC disabled by default
- If enabled, uses proxy-only mode

**Configuration:**
```javascript
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
```

### 7. HTTPS-Only Mode

**What it does:**
- Automatically upgrades all HTTP connections to HTTPS
- Warns before connecting to unencrypted sites
- Prevents downgrade attacks

**Configuration:**
```javascript
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_send_http_background_request", false);
```

### 8. Cookie Management

**Strategy:**
- Total Cookie Protection (Firefox's container technology)
- Clear cookies on browser shutdown
- Block third-party tracking cookies

**Configuration:**
```javascript
user_pref("network.cookie.cookieBehavior", 5);
user_pref("privacy.clearOnShutdown.cookies", true);
```

### 9. Data Sanitization

**Cleared on shutdown:**
- ✅ Browsing history
- ✅ Download history
- ✅ Cookies
- ✅ Cache
- ✅ Active logins
- ✅ Form data

**Configuration:**
```javascript
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.history", true);
```

### 10. Safe Browsing Disabled

**Why?**
Google Safe Browsing sends hashed URLs to Google servers.

**Lucent's approach:**
- Uses local filter lists instead
- No data sent to Google
- Download protection via local checks

**Configuration:**
```javascript
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
```

### 11. Referer Control

**What are referers?**
HTTP headers that tell websites where you came from.

**Lucent's policy:**
- Only send referer to same-origin
- Trim referer to origin only for cross-origin

**Configuration:**
```javascript
user_pref("network.http.referer.XOriginPolicy", 2);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
```

### 12. Mozilla Services Disabled

**Removed:**
- ❌ Firefox Accounts & Sync
- ❌ Pocket integration
- ❌ Firefox View
- ❌ Push notifications from Mozilla
- ❌ Firefox Screenshots cloud upload
- ❌ Sponsored content

**Configuration:**
```javascript
user_pref("identity.fxaccounts.enabled", false);
user_pref("extensions.pocket.enabled", false);
```

## 🎯 Threat Model

### What Lucent Protects Against

✅ **ISP tracking** - Via DoH and HTTPS
✅ **Advertiser tracking** - Via tracking protection and FPI
✅ **Browser fingerprinting** - Via resist fingerprinting
✅ **Mozilla telemetry** - All disabled
✅ **Cookie tracking** - Total cookie protection
✅ **Cross-site tracking** - First-party isolation

### What Lucent Does NOT Protect Against

❌ **Government surveillance** - Use Tor Browser for this
❌ **Advanced fingerprinting** - Some techniques may still work
❌ **Logged-in tracking** - If you log into Google, they know it's you
❌ **Malware** - Use antivirus software
❌ **Physical access** - Encrypt your disk

## ⚖️ Privacy vs Convenience Trade-offs

### Strict Privacy Mode
- Most private configuration
- May break some websites
- Best for privacy-conscious users

### Balanced Mode (Default)
- Good privacy with reasonable compatibility
- Most websites work correctly
- Recommended for daily use

### Custom Configuration
Edit `configs/user.js` to adjust settings to your needs.

## 🔍 Privacy Comparison

| Feature | Firefox | Chrome | Brave | LibreWolf | **Lucent** |
|---------|---------|--------|-------|-----------|------------|
| Telemetry | ❌ Yes | ❌ Yes | ⚠️ Opt-out | ✅ None | ✅ None |
| Tracking Protection | ⚠️ Basic | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| Fingerprinting | ⚠️ Basic | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| DoH | ⚠️ Optional | ⚠️ Optional | ✅ Yes | ✅ Yes | ✅ Yes |
| First-Party Isolation | ❌ No | ❌ No | ⚠️ Different | ✅ Yes | ✅ Yes |
| WebRTC Protection | ❌ No | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| Pocket | ❌ Yes | N/A | N/A | ✅ None | ✅ None |

## 🧪 Testing Your Privacy

### Check DNS Leaks
1. Visit: https://dnsleaktest.com/
2. Click "Extended test"
3. Should show Cloudflare servers, not your ISP

### Check WebRTC Leaks
1. Visit: https://browserleaks.com/webrtc
2. Should show "Not supported" or no local IP

### Check Fingerprinting
1. Visit: https://coveryourtracks.eff.org/
2. Tests how unique your browser fingerprint is

### Check Tracking Protection
1. Visit: https://privacytests.org/
2. Shows which trackers are blocked

## 📚 Additional Privacy Tools

### Recommended Extensions
- **uBlock Origin** - Advanced ad/tracker blocking
- **Privacy Badger** - Automatic tracker blocking
- **Decentraleyes** - Local CDN emulation
- **ClearURLs** - Remove tracking from URLs

### VPN Recommendations
- Mullvad VPN
- ProtonVPN
- IVPN

### Search Engines
- DuckDuckGo
- Startpage
- Brave Search
- Searx

## 🔧 Customization

### Adjust Privacy Level

Edit `configs/user.js`:

**More Privacy:**
```javascript
// Disable all cookies
user_pref("network.cookie.cookieBehavior", 2);

// Disable JavaScript globally (will break sites)
user_pref("javascript.enabled", false);
```

**More Convenience:**
```javascript
// Allow some cookies
user_pref("network.cookie.lifetimePolicy", 0);

// Don't clear history on close
user_pref("privacy.sanitize.sanitizeOnShutdown", false);
```

### Per-Site Settings

Use Firefox's built-in site permissions:
1. Click the lock icon in the address bar
2. Adjust permissions for specific sites
3. Settings are saved per-site

## 📖 Learn More

### Resources
- [Arkenfox user.js Wiki](https://github.com/arkenfox/user.js/wiki)
- [Privacy Guides](https://www.privacyguides.org/)
- [EFF Privacy Tools](https://www.eff.org/pages/tools)
- [Mozilla Privacy Policy](https://www.mozilla.org/privacy/)

### Books
- "Permanent Record" by Edward Snowden
- "Data and Goliath" by Bruce Schneier

## ❓ FAQ

**Q: Is Lucent Browser completely anonymous?**
A: No. For anonymity, use Tor Browser. Lucent focuses on privacy, not anonymity.

**Q: Can I still log into websites?**
A: Yes! Privacy doesn't mean you can't use accounts.

**Q: Will this break websites?**
A: Most sites work fine. Some may need adjustments in settings.

**Q: How often should I update?**
A: Check for updates monthly. Security is important!

**Q: Can I sync between devices?**
A: Firefox Sync is disabled for privacy. Use a local bookmark sync tool instead.

---

**Your privacy matters.** 🔒
