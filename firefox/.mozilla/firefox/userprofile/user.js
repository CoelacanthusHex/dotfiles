/* 启动后恢复上次会话 */
// user_pref("browser.startup.page", 3);
/* 主页使用空白页 */
user_pref("browser.startup.homepage", "about:blank");
/* 新标签页使用空白页 */
user_pref("browser.newtabpage.enabled", false);
/* 所有情况下都启用跟踪保护 */
// user_pref("privacy.trackingprotection.enabled", true);
/* 阻止重定向形式的跟踪(效果有限) */
// user_pref("privacy.purge_trackers.enabled",  true);

/* Don't disable our bundled extensions in the application directory. */
user_pref("extensions.autoDisableScopes", 11);
user_pref("extensions.shownSelectionUI", true);
/* 打开about:config页面不警告 */
user_pref("browser.aboutConfig.showWarning", false);
/* 去除about:addons页面中的推荐页 */
user_pref("extensions.getAddons.showPane", false);
/* 去除about:addons页面中底部的推荐列表 */
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
/* 去除Pocket服务 */
user_pref("extensions.pocket.enabled", false);
/* 使用系统 emoji */
// Disable for SVG font
//user_pref("font.name-list.emoji", "emoji");
/* 显示紧凑模式 */
user_pref("browser.compactmode.show", true);
/* 在地址栏显示完整的 URL */
user_pref("browser.urlbar.trimURLs", false);
/* 从fontconfig查询字体时允许的最大字体替换次数 Default: 3 */
// https://wiki.archlinux.org/title/Firefox#Font_troubleshooting
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 64);
/* 使用系统文件对话框 */
/* WARNING: 必须安装 xdg-desktop-portal{,-kde} */
/* SideEffect: 火狐一直认为自己不是默认浏览器 */
user_pref("widget.use-xdg-desktop-portal", true);

/* Always use system defined logical resolution for CSS DPI detection. */
user_pref("layout.css.dpi", 0);
/* Use native GTK menus */
//user_pref("widget.gtk.native-context-menus", true);
/* Disable reader mode */
user_pref("reader.parse-on-load.enabled", false);
/* Disable quick action */
user_pref("browser.urlbar.shortcuts.quickactions", false);
user_pref("browser.urlbar.suggest.quickactions", false);
/* Enable unified extensions toolbar button*/
user_pref("extensions.unifiedExtensions.enabled", true);
/* Enable COLRv1 font */
user_pref("gfx.font_rendering.colr_v1.enabled", true);

/* 禁止投机性预连接 */
// user_pref("network.http.speculative-parallel-limit", 0);
/* 禁止链接预读取 */
// user_pref("network.prefetch-next", false);
/* 禁止DNS预读取 */
// user_pref("network.dns.disablePrefetch", true);
/* 禁止超链接审计
 * 无需设置: 默认设置已禁止, 而且uBlock Origin也提供禁止选项 */
// user_pref("browser.send_pings", false);
/* 禁止sendBeacon API
 * 无需设置: 使用uBlock Origin过滤
 * https://bugzilla.mozilla.org/show_bug.cgi?id=1454252#c6
 * https://github.com/gorhill/uBlock/issues/1884#issuecomment-253813062 */
// user_pref("beacon.enabled", false);

/*==== 可能破坏网页 ====*/
/* RFP: 阻止多种收集浏览器指纹的行为 */
// user_pref("privacy.resistFingerprinting", true);
/* 禁止WebGL
 * 开启RFP即可减少WebGL信息熵 */
// user_pref("webgl.disabled", true);
/* 禁止Web Audio API */
// user_pref("dom.webaudio.enabled", false);
/* 禁止WebRTC */
// user_pref("media.peerconnection.enabled", false);
/* 禁止获取媒体设备列表API
 * 注意: 需要同时禁止WebRTC */
// user_pref("media.navigator.enabled", false);

/*==== 硬件视频加速 ====*/
/* 使用VA-API */
user_pref("media.ffmpeg.vaapi.enabled", true);

/*==== 连接安全 ====*/
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
