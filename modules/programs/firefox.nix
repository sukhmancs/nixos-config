#
# Firefox with custom policies. Visit this Url for more info: https://mozilla.github.io/policy-templates/#blockaboutconfig
# Some options:
#   "Locked" means that the user can not change that value using FireFox UI. 
#

{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      Cookies = {                                       # Disable Cookies 
        Allow = [
          "https://chat.openai.com/"
          "https://github.com/"
          "https://feedly.com/"
          "https://huggingface.co/"
          "https://login.microsoftonline.com/"
          "https://mymohawk.mohawkcollege.ca/"
          "https://mycanvas.mohawkcollege.ca/"
        ];
        Default = false;
        AcceptThirdParty = "never";
        RejectTracker = true;
        Locked = true;
        Behavior = "reject";
        BehaviorPrivateBrowsing = "reject";
      };
      OfferToSaveLoginsDefault = false;                 # Disable save Logins
      PictureInPicture = {                              # Disable picture in picture
        Enabled = false;
        Locked = true;
      };
      FirefoxHome = {                                   # Custom FireFox Home
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      Handlers = {                                      # What application or url should be opened based on MIME TYPE
        mimeTypes = {
          "application/msword" = {
            action = "useSystemDefault";
            ask = true;
          };
        };
        schemes = {
          mailto = {
            action = "useHelperApp";
            ask = true;
            handlers = [{
              name = "Gmail";
              uriTemplate = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
            }];
          };
        };
      };
      ManualAppUpdateOnly = true;                                   # Don't pop up "Update Firefox" message
      PasswordManagerEnabled = false;
      Preferences = {
        "accessibility.force_disabled" = {
          Value = 1;
          Status = "default";
          Type = "number";
        };
        "browser.tabs.warnOnClose" = {
          Value = false;
          Status = "locked";
        };
        "ui.key.menuAccessKeyFocuses" = {
          Value = false;
          Status = "locked";
        };
      };
      SanitizeOnShutdown = {                                        # Delete data on quit
        Cache = true;
        Cookies = true;
        Downloads = false;
        FormData = true;
        History = false;
        Sessions = false;
        SiteSettings = false;
        OfflineApps = true;
        Locked = true;
      };
      SearchEngines = {                                             # Prevent installing custom search engines
        PreventInstalls = true;
      };
      UserMessaging = {                                             # Disable FireFox from showing messages
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = false;
      };
      BlockAboutConfig = true;                                      # Disable access to about:config page
    };
  };
}
