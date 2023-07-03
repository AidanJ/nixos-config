{ config, inputs, extensions, ... }:

let 
  firefoxProfile = "main";
in
{
  home.file.".mozilla/firefox/${firefoxProfile}/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
  programs.firefox = {
    enable = true;

    profiles.main = {
      inherit extensions;
      id = 0;

      settings = {
        "general.smoothScroll" = true;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 500;
        "general.smoothScroll.mouseWheel.durationMinMS" = 200;

        # For firefox-gnome-theme
        "svg.context-properties.content.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';

      # https://ffprofile.com
      extraConfig = ''
        user_pref("browser.urlbar.trimURLs", false);
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("full-screen-api.ignore-widgets", true);
        user_pref("media.ffmpeg.vaapi.enabled", true);
        user_pref("extensions.pocket.enabled", false);
        user_pref("toolkit.telemetry.archive.enabled", false);
        user_pref("toolkit.telemetry.bhrPing.enabled", false);
        user_pref("toolkit.telemetry.cachedClientID", "");
        user_pref("toolkit.telemetry.enabled", false);
        user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
        user_pref("toolkit.telemetry.hybridContent.enabled", false);
        user_pref("toolkit.telemetry.newProfilePing.enabled", false);
        user_pref("toolkit.telemetry.prompted", 2);
        user_pref("toolkit.telemetry.rejected", true);
        user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
        user_pref("toolkit.telemetry.server", "");
        user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
        user_pref("toolkit.telemetry.unified", false);
        user_pref("toolkit.telemetry.unifiedIsOptIn", false);
        user_pref("toolkit.telemetry.updatePing.enabled", false);
        user_pref("device.sensors.enabled", false);
        user_pref("device.sensors.motion.enabled", false);
        user_pref("device.sensors.orientation.enabled", false);
        user_pref("device.sensors.proximity.enabled", false);
        user_pref("datareporting.healthreport.service.enabled", false);
        user_pref("datareporting.healthreport.uploadEnabled", false);
        user_pref("datareporting.policy.dataSubmissionEnabled", false);
        user_pref("app.shield.optoutstudies.enabled", false);
        user_pref("beacon.enabled", false);
        user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
        user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
        user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
        user_pref("browser.tabs.crashReporting.sendReport", false);
        user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
        user_pref("browser.send_pings", false);
        user_pref("browser.shell.checkDefaultBrowser", false);
        user_pref("experiments.activeExperiment", false);
        user_pref("experiments.enabled", false);
        user_pref("experiments.manifest.uri", "");
        user_pref("experiments.supported", false);
        user_pref("network.allow-experiments", false);
        user_pref("extensions.pocket.enabled", false);
        user_pref("network.cookie.cookieBehavior", 1);
      '';
    };
  };
}