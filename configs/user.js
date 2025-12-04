/**
 * Lucent Browser - Privacy-Hardened Configuration
 * Based on Arkenfox user.js with additional privacy enhancements
 * 
 * This configuration file disables telemetry, tracking, and enhances privacy
 * while maintaining reasonable functionality for daily browsing.
 */

/******************************************************************************
 * SECTION: STARTUP & SHUTDOWN                                               *
******************************************************************************/
// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Set startup page to blank
user_pref("browser.startup.page", 0);
user_pref("browser.startup.homepage", "about:blank");

// Disable Activity Stream (New Tab Page)
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");

/******************************************************************************
 * SECTION: GEOLOCATION & SENSORS                                            *
******************************************************************************/
// Disable geolocation
user_pref("geo.enabled", false);
user_pref("geo.provider.network.url", "");

// Disable sensor API
user_pref("device.sensors.enabled", false);
user_pref("camera.control.face_detection.enabled", false);

/******************************************************************************
 * SECTION: LANGUAGE & LOCALE                                                *
******************************************************************************/
// Spoof locale to en-US to prevent fingerprinting
user_pref("javascript.use_us_english_locale", true);
user_pref("intl.accept_languages", "en-US, en");

/******************************************************************************
 * SECTION: RECOMMENDATIONS & TELEMETRY                                      *
******************************************************************************/
// Disable all telemetry
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");

// Disable Firefox Studies
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// Disable crash reports
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

// Disable Captive Portal detection
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false);

// Disable network connectivity checks
user_pref("network.connectivity-service.enabled", false);

/******************************************************************************
 * SECTION: SAFE BROWSING (GOOGLE PHISHING PROTECTION)                      *
******************************************************************************/
// Disable safe browsing (sends data to Google)
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);

/******************************************************************************
 * SECTION: NETWORK & DNS                                                    *
******************************************************************************/
// Enable DNS over HTTPS (Cloudflare)
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
user_pref("network.trr.custom_uri", "https://mozilla.cloudflare-dns.com/dns-query");

// Disable IPv6 (prevents leaks)
user_pref("network.dns.disableIPv6", true);

// Disable prefetching
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.prefetch-next", false);

// Disable link prefetching
user_pref("network.http.speculative-parallel-limit", 0);

// Disable preconnecting
user_pref("network.preload", false);

/******************************************************************************
 * SECTION: WEBRTC                                                           *
******************************************************************************/
// Disable WebRTC (prevents IP leaks)
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);

/******************************************************************************
 * SECTION: LOCATION BAR & SEARCH                                            *
******************************************************************************/
// Disable location bar suggestions
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

// Disable search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.engines", false);

/******************************************************************************
 * SECTION: PASSWORDS & AUTOFILL                                             *
******************************************************************************/
// Disable password manager (use external password manager)
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("signon.formlessCapture.enabled", false);

// Disable form autofill
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

/******************************************************************************
 * SECTION: DISK CACHE & MEDIA CACHE                                         *
******************************************************************************/
// Minimize disk cache
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 524288); // 512 MB

// Disable media cache
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);

/******************************************************************************
 * SECTION: HTTPS & MIXED CONTENT                                            *
******************************************************************************/
// HTTPS-Only Mode
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_send_http_background_request", false);

// Disable insecure passive content
user_pref("security.mixed_content.block_display_content", true);

// Enable stricter TLS settings
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.tls.enable_0rtt_data", false);

/******************************************************************************
 * SECTION: FONTS & FINGERPRINTING                                           *
******************************************************************************/
// Limit font fingerprinting
user_pref("browser.display.use_document_fonts", 0);

// Disable font visibility
user_pref("layout.css.font-visibility.level", 1);

/******************************************************************************
 * SECTION: HEADERS & REFERERS                                               *
******************************************************************************/
// Control referer
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
user_pref("network.http.referer.XOriginPolicy", 2);

// Disable user-agent updates
user_pref("general.useragent.updates.enabled", false);

/******************************************************************************
 * SECTION: CONTAINERS & ISOLATION                                           *
******************************************************************************/
// Enable first party isolation
user_pref("privacy.firstparty.isolate", true);

// Enable resist fingerprinting
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);

// Enable tracking protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);

/******************************************************************************
 * SECTION: COOKIES & STORAGE                                                *
******************************************************************************/
// Enhanced cookie protection
user_pref("network.cookie.cookieBehavior", 5); // Total Cookie Protection
user_pref("network.cookie.lifetimePolicy", 2);

// Clear on shutdown
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", true);

/******************************************************************************
 * SECTION: MOZILLA SERVICES                                                 *
******************************************************************************/
// Disable Pocket
user_pref("extensions.pocket.enabled", false);

// Disable Firefox Accounts & Sync
user_pref("identity.fxaccounts.enabled", false);

// Disable Firefox View
user_pref("browser.tabs.firefox-view", false);

// Disable Screenshots
user_pref("extensions.screenshots.disabled", true);

// Disable Web Compatibility Reporter
user_pref("extensions.webcompat-reporter.enabled", false);

/******************************************************************************
 * SECTION: PERMISSIONS & FEATURES                                           *
******************************************************************************/
// Disable notifications
user_pref("permissions.default.desktop-notification", 2);

// Disable autoplay
user_pref("media.autoplay.default", 5);

// Disable clipboard events
user_pref("dom.event.clipboardevents.enabled", false);

// Disable battery API
user_pref("dom.battery.enabled", false);

// Disable gamepad API
user_pref("dom.gamepad.enabled", false);

// Disable vibrator API
user_pref("dom.vibrator.enabled", false);

// Disable virtual reality
user_pref("dom.vr.enabled", false);

// Disable beacon API
user_pref("beacon.enabled", false);

/******************************************************************************
 * SECTION: DOWNLOADS                                                        *
******************************************************************************/
// Always ask where to save files
user_pref("browser.download.useDownloadDir", false);

// Disable adding downloads to system's recent documents
user_pref("browser.download.manager.addToRecentDocs", false);

/******************************************************************************
 * SECTION: PDF VIEWER                                                       *
******************************************************************************/
// Enable PDF.js viewer
user_pref("pdfjs.enableScripting", false);

/******************************************************************************
 * SECTION: UI ENHANCEMENTS                                                  *
******************************************************************************/
// Enable userChrome.css and userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Compact UI density
user_pref("browser.uidensity", 1);

// Disable fullscreen warning
user_pref("full-screen-api.warning.timeout", 0);

/******************************************************************************
 * SECTION: PERFORMANCE                                                      *
******************************************************************************/
// Hardware acceleration (enable for better performance)
user_pref("layers.acceleration.force-enabled", true);
user_pref("gfx.webrender.all", true);

// Multi-process settings
user_pref("dom.ipc.processCount", 8);

/******************************************************************************
 * SECTION: LUCENT BROWSER SPECIFIC                                          *
******************************************************************************/
// Enable transparency features
user_pref("lucent.transparency.enabled", true);
user_pref("lucent.transparency.window_opacity", 0.85);
user_pref("lucent.transparency.content_opacity", 0.90);

// Lucent branding
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");

/******************************************************************************
 * END OF CONFIGURATION                                                      *
******************************************************************************/
