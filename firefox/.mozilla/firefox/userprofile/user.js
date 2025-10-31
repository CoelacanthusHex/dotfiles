/*==== UI Tweak ====*/

// Use a blank page for the home page
user_pref("browser.startup.homepage", "about:blank");
// Use a blank page for the new tab page
user_pref("browser.newtabpage.enabled", false);
// Use system emoji
//user_pref("font.name-list.emoji", "emoji");
// Enable Compact mode support
user_pref("browser.compactmode.show", true);
// Show full URL in address bar
user_pref("browser.urlbar.trimURLs", false);
// Maximum number of font substitutions allowed when querying fonts from fontconfig Default: 3 Max: uint32_t
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 4096);
// Allow fallback unassigned chars
user_pref("gfx.font_rendering.fallback.unassigned_chars", true);
// Use sans serif fonts as default of lang=x-western
user_pref("font.default.x-western", "sans-serif");
// Use XDG Desktop Portal handle file picker
// WARNING: Need xdg-desktop-portal{,-kde}
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);
user_pref("widget.use-xdg-desktop-portal.settings", 1);
user_pref("widget.use-xdg-desktop-portal.location", 1);
user_pref("widget.use-xdg-desktop-portal.open-uri", 1);
// Enable Wayland fractional scale
user_pref("widget.wayland.fractional-scale.enabled", true);
// Always use system defined logical resolution for CSS DPI detection.
user_pref("layout.css.dpi", 0);
// Enable calcalutor and unit convert in urlbar
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);
// Enable unified extensions toolbar button
user_pref("extensions.unifiedExtensions.enabled", true);
// Allow total 1800 connections
user_pref("network.http.max-connections", 1800); // default=900
// Allow max 16 connections per server
user_pref("network.http.max-persistent-connections-per-server", 16); // default = 6
// Allow max 64 connections per proxy
user_pref("network.http.max-persistent-connections-per-proxy", 64); // default=32
/*
 * preferred color scheme for websites
 * By default, color scheme matches the theme of your browser toolbar (3).
 * Set this pref to choose Dark on sites that support it (0) or Light (1).
 * Before FF95, the pref was System (2), which determined site color based on OS theme.
 * Dark (0), Light (1), System (2), Browser (3) (default [FF95+])
 * https://www.reddit.com/r/firefox/comments/rfj6yc/how_to_stop_firefoxs_dark_theme_from_overriding/hoe82i5/?context=3
 */
user_pref("layout.css.prefers-color-scheme.content-override", 2);
// Enable full mode color management
user_pref("gfx.color_management.mode", 1);
// Enable HDR
// https://bugzilla.mozilla.org/show_bug.cgi?id=1642854
//user_pref("gfx.wayland.hdr", true);
// Prefer Concrete Math, New Computer Modern Math and STIX Two Math as math fonts.
// Remove normal serif from fallback list to use default serif fonts as fallback.
// Remove STIXGeneral since it's obsolete and doesn't use MATH table, see https://bugzilla.mozilla.org/show_bug.cgi?id=1336058
// see https://bugzilla.mozilla.org/show_bug.cgi?id=1788937
// FIXME: Remove font.name.serif.x-math = "math" in user.js and about:config
// when Firefox set font.name-list.serif.x-math to "math, ..." or remove it.
user_pref("font.name.serif.x-math", "math");
/*
 * Enable WebRender Compositor 
 * In class FeatureState implementation, runtime failure > user force-enabled > environment > user > default.
 * Since there is no runtime failure (only caused by no zwp_linux_dmabuf_v1 or wp_viewporter), but environment test will
 * failed on all Linux, we need to force enable.
 * https://bugzilla.mozilla.org/show_bug.cgi?id=1978540
 * https://github.com/mozilla-firefox/firefox/commit/e21260214b32
 * gfx/config/gfxFeature.cpp
 * widget/gtk/GfxInfo.cpp#L1008
 */ 
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.compositor.force-enabled", true);

/*==== Network ====*/

/*
 * Disable DoH completely.
 * It was implemented in local dns resolver.
 */
user_pref("network.trr.mode", 5);
/*
 * Stop excluding suffix domains of hostname from TRR.
 * error massage: xxx Is Excluded From TRR via DNSSuffix domains
 */
user_pref("network.trr.split_horizon_mitigations", false);
// Enable HTTPS-Only mode
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);
// Enable sideber
user_pref("sidebar.revamp", true);
// But disable vertical tabbar, because TST is better
user_pref("sidebar.verticalTabs", false);

/*==== Extensions ====*/

// Enable userChrome.css support
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// Don't disable our bundled extensions in the application directory.
user_pref("extensions.autoDisableScopes", 11);
user_pref("extensions.shownSelectionUI", true);
/*
 * Enable -moz-context-properties for TST because of [1] & [2]
 * Should be removed after [3] fixed
 * [1]: https://bugzilla.mozilla.org/show_bug.cgi?id=1421329
 * [2]: https://bugzilla.mozilla.org/show_bug.cgi?id=1388193
 * [3]: https://bugzilla.mozilla.org/show_bug.cgi?id=1812163
 */
user_pref("svg.context-properties.content.enabled", true);
// Disable unload page on low memory
user_pref("browser.tabs.unloadOnLowMemory", false);

/*==== Annoying Things ====*/

// Disable default browser checking
user_pref("browser.shell.checkDefaultBrowser", false);
// Open the about:config page without warning
user_pref("browser.aboutConfig.showWarning", false);
// Remove the recommended page from the about:addons page
user_pref("extensions.getAddons.showPane", false);
// Remove the recommendation list at the bottom of the about:addons page
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
// Remove Pocket
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
// Remove Firefox Relay
user_pref("signon.firefoxRelay.feature", "disabled");
// Disable reader mode
user_pref("reader.parse-on-load.enabled", false);
// Disable quick action
user_pref("browser.urlbar.shortcuts.quickactions", false);
user_pref("browser.urlbar.suggest.quickactions", false);
// Disable Password Manager
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("signon.showAutoCompleteFooter", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
// Disable (targeted) sponsored contents
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false);
// Disable Firefox buitlin ads tracking
user_pref("dom.private-attribution.submission.enabled", false);
// Disable useless AI
user_pref("browser.ml.chat.enabled", false);

/*==== Security ====*/
// https://github.com/arkenfox/user.js/blob/master/user.js#L465

/** SSL (Secure Sockets Layer) / TLS (Transport Layer Security) ***/
/* 1201: require safe negotiation
 * Blocks connections (SSL_ERROR_UNSAFE_NEGOTIATION) to servers that don't support RFC 5746 [2]
 * as they're potentially vulnerable to a MiTM attack [3]. A server without RFC 5746 can be
 * safe from the attack if it disables renegotiations but the problem is that the browser can't
 * know that. Setting this pref to true is the only way for the browser to ensure there will be
 * no unsafe renegotiations on the channel between the browser and the server.
 * [STATS] SSL Labs (July 2021) reports over 99% of sites have secure renegotiation [4]
 * [1] https://wiki.mozilla.org/Security:Renegotiation
 * [2] https://tools.ietf.org/html/rfc5746
 * [3] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-3555
 * [4] https://www.ssllabs.com/ssl-pulse/ ***/
//user_pref("security.ssl.require_safe_negotiation", true);
/* 1270: display warning on the padlock for "broken security" (if 1201 is false)
 * Bug: warning padlock not indicated for subresources on a secure page! [2]
 * [1] https://wiki.mozilla.org/Security:Renegotiation
 * [2] https://bugzilla.mozilla.org/1353705 ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
/* 1203: reset TLS 1.0 and 1.1 downgrades i.e. session only ***/
user_pref("security.tls.version.enable-deprecated", false); // [DEFAULT: false]

/** CERTS / HPKP (HTTP Public Key Pinning) ***/
/* 1220: disable or limit SHA-1 certificates
 * 0 = allow all
 * 1 = block all
 * 3 = only allow locally-added roots (e.g. anti-virus) (default)
 * 4 = only allow locally-added roots or for certs in 2015 and earlier
 * [SETUP-CHROME] If you have problems, update your software: SHA-1 is obsolete
 * [1] https://blog.mozilla.org/security/2016/10/18/phasing-out-sha-1-on-the-public-web/ ***/
user_pref("security.pki.sha1_enforcement_level", 1);

/* 1272: display advanced information on Insecure Connection warning pages
 * only works when it's possible to add an exception
 * i.e. it doesn't work for HSTS discrepancies (https://subdomain.preloaded-hsts.badssl.com/)
 * [TEST] https://expired.badssl.com/ ***/
user_pref("browser.xul.error_pages.expert_bad_cert", true);

/* 7003: disable non-modern cipher suites [1]
 * [WHY] Passive fingerprinting. Minimal/non-existent threat of downgrade attacks
 * [TEST] https://browserleaks.com/ssl ***/
user_pref("security.ssl3.ecdhe_ecdsa_aes_256_sha", false); // no AEAD
user_pref("security.ssl3.ecdhe_ecdsa_aes_128_sha", false); // no AEAD
user_pref("security.ssl3.ecdhe_rsa_aes_128_sha", false); // no AEAD
user_pref("security.ssl3.ecdhe_rsa_aes_256_sha", false); // no AEAD
user_pref("security.ssl3.rsa_aes_128_gcm_sha256", false); // no PFS
user_pref("security.ssl3.rsa_aes_256_gcm_sha384", false); // no PFS
user_pref("security.ssl3.rsa_aes_128_sha", false); // no PFS and AEAD
user_pref("security.ssl3.rsa_aes_256_sha", false); // no PFS and AEAD
