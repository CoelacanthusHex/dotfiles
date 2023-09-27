/*
 * Set Date and Time format to RFC3339
 * https://support.mozilla.org/en-US/kb/customize-date-time-formats-thunderbird
 */
user_pref("intl.date_time.pattern_override.date_short", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_medium", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_long", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.date_full", "yyyy-MM-dd");
user_pref("intl.date_time.pattern_override.time_short", "HH:mm");
user_pref("intl.date_time.pattern_override.time_medium", "HH:mm");
user_pref("intl.date_time.pattern_override.time_long", "HH:mm");
user_pref("intl.date_time.pattern_override.time_full", "HH:mm:ss");
user_pref("intl.date_time.pattern_override.connector_short", "{1} {0}");
/* A week start on Monday */
user_pref("calendar.week.start", 1);
/* Use GNUPG instead builtin implementation */
user_pref("mail.openpgp.allow_external_gnupg", true);
/* Maximum number of font substitutions allowed when querying fonts from fontconfig Default: 3 Max: 127 */
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 64);
/* Use XDG Desktop Portal handle file picker */
/* WARNING: Need xdg-desktop-portal{,-kde} */
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);
user_pref("widget.use-xdg-desktop-portal.mime-handler", 1);
/* Always use system defined logical resolution for CSS DPI detection. */
user_pref("layout.css.dpi", 0);
/* Allow max 16 connections per server */
user_pref("network.http.max-persistent-connections-per-server", 16);
/* Enable syntax highlight for viewsource */
user_perf("view_source.syntax_highlight", true);
/* use Mozilla geolocation service instead of Google if permission is granted */
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
/* DNS via proxy */
user_pref("network.proxy.socks_remote_dns", true);
/* Use Maildir */
user_pref("mail.serverDefaultStoreContractID", "@mozilla.org/msgstore/maildirstore;1");

/* Prepare for plaintext mail to mail list */
user_perf("mailnews.send_plaintext_flowed", false);
user_perf("mailnews.wraplength", 0);
/*
 * Don't wrap long line when reading plaintext mail
 * https://superuser.com/a/1742126/1377216
 */
user_perf("plain_text.wrap_long_lines", false);
