/* Use a blank page for the home page */
user_pref("browser.startup.homepage", "about:blank");
/* Use a blank page for the new tab page */
user_pref("browser.newtabpage.enabled", false);
/* Disable default browser checking */
user_pref("browser.shell.checkDefaultBrowser", false);

/* Don't disable our bundled extensions in the application directory. */
user_pref("extensions.autoDisableScopes", 11);
user_pref("extensions.shownSelectionUI", true);
/* Open the about:config page without warning */
user_pref("browser.aboutConfig.showWarning", false);
/* Remove the recommended page from the about:addons page */
user_pref("extensions.getAddons.showPane", false);
/* Remove the recommendation list at the bottom of the about:addons page */
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
/* Remove Pocket */
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
/* Remove Firefox Relay */
user_pref("signon.firefoxRelay.feature", "disabled");
/* Use system emoji */
/* Disable for COLR font */
//user_pref("font.name-list.emoji", "emoji");
/* Enable Compact mode support */
user_pref("browser.compactmode.show", true);
/* Show full URL in address bar */
user_pref("browser.urlbar.trimURLs", false);
/* Maximum number of font substitutions allowed when querying fonts from fontconfig Default: 3 Max: 127 */
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 64);
/* Use sans serif fonts as default of lang=x-western */
user_pref("font.default.x-western", "sans-serif");
/* Use XDG Desktop Portal handle file picker */
/* WARNING: Need xdg-desktop-portal{,-kde} */
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);
/* Enable Wayland fractional scale */
//user_perf("widget.wayland.fractional-scale.enabled", true);
/* Enable userChrome.css support */
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
/* Always use system defined logical resolution for CSS DPI detection. */
user_pref("layout.css.dpi", 0);
/* Use native GTK menus */
//user_pref("widget.gtk.native-context-menus", true);
/* Disable reader mode */
user_pref("reader.parse-on-load.enabled", false);
/* Disable quick action */
user_pref("browser.urlbar.shortcuts.quickactions", false);
user_pref("browser.urlbar.suggest.quickactions", false);
/* Enable calcalutor and unit convert in urlbar */
user_pref("browser.urlbar.suggest.calculator", true);
user_pref("browser.urlbar.unitConversion.enabled", true);
/* Enable unified extensions toolbar button*/
user_pref("extensions.unifiedExtensions.enabled", true);
/* Disable unload page on low memory */
user_pref("browser.tabs.unloadOnLowMemory", false);
/* Allow max 16 connections per server */
user_pref("network.http.max-persistent-connections-per-server", 16);
/*
 * preferred color scheme for websites
 * By default, color scheme matches the theme of your browser toolbar (3).
 * Set this pref to choose Dark on sites that support it (0) or Light (1).
 * Before FF95, the pref was System (2), which determined site color based on OS theme.
 * Dark (0), Light (1), System (2), Browser (3) (default [FF95+])
 * https://www.reddit.com/r/firefox/comments/rfj6yc/how_to_stop_firefoxs_dark_theme_from_overriding/hoe82i5/?context=3
 */
user_pref("layout.css.prefers-color-scheme.content-override", 2);
/* Enable full mode color management */
user_pref("gfx.color_management.mode", 1);

/* Enable DoH */
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://doh.service.coelacanthus.moe/dns-query");
user_pref("network.trr.custom_uri", "https://doh.service.coelacanthus.moe/dns-query");
/* Enable DNS ECS for DoH */
user_pref("network.trr.disable-ECS", false);

/*
 * Enable -moz-context-properties for TST because of [1] & [2]
 * Should be removed after [3] fixed
 * [1]: https://bugzilla.mozilla.org/show_bug.cgi?id=1421329
 * [2]: https://bugzilla.mozilla.org/show_bug.cgi?id=1388193
 * [3]: https://bugzilla.mozilla.org/show_bug.cgi?id=1812163
 */
user_pref("svg.context-properties.content.enabled", true);

/* Disable Password Manager */
user_pref("signon.autofillForms", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("signon.showAutoCompleteFooter", false);
user_pref("signon.management.page.breach-alerts.enabled", false);

/* Disable (targeted) sponsored contents */
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false);

/*==== Hardware acceleration ====*/
/* Use VA-API */
//user_pref("media.ffmpeg.vaapi.enabled", true);
//user_pref("widget.dmabuf.force-enabled", true);

/*==== Security ====*/
/* https://github.com/arkenfox/user.js/blob/master/user.js#L465 */

/*** [SECTION 1200]: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
   Your cipher and other settings can be used in server side fingerprinting
   [TEST] https://www.ssllabs.com/ssltest/viewMyClient.html
   [TEST] https://browserleaks.com/ssl
   [TEST] https://ja3er.com/
   [1] https://www.securityartwork.es/2017/02/02/tls-client-fingerprinting-with-bro/
***/

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
/* 7004: control TLS versions
 * [WHY] Passive fingerprinting. Downgrades are still possible: behind user interaction ***/
   // user_pref("security.tls.version.min", 3); // [DEFAULT: 3] 3 is TLS1.2
   // user_pref("security.tls.version.max", 4)
