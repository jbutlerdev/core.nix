{ ... }:
{
  system.defaults = {
    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Mission Control shortcuts
          "32".enabled = false; # Mission Control (Ctrl+Up)
          "33".enabled = false; # Mission Control (F3)
          "34".enabled = false; # Application Windows (Ctrl+Down)
          "35".enabled = false; # Application Windows (F3 with Fn modifier)
          "36".enabled = false; # Show Desktop (F11)
          "37".enabled = false; # Show Dashboard (F12) - legacy
          "62".enabled = false; # Show Dashboard as Overlay (F12)
          "73".enabled = false; # Show Dashboard as Space
          "79".enabled = false; # Move left a space (Ctrl+Left)
          "80".enabled = false; # Move right a space (Ctrl+Right)
          "81".enabled = false; # Switch to Desktop 1 (Ctrl+1)
          "82".enabled = false; # Switch to Desktop 2 (Ctrl+2)

          # Spotlight shortcuts
          "60".enabled = false; # Show Spotlight Search (Ctrl+Space)
          "61".enabled = false; # Show Finder Search (Ctrl+Opt+Space)
          "64".enabled = false; # Spotlight Menu (Cmd+Space)
        };
      };
    };
    dock = {
      autohide = true;
      mru-spaces = false;
      magnification = false;
      minimize-to-application = true;
      orientation = "bottom";
      show-recents = false;
      tilesize = 64;
      wvous-bl-corner = 4; # Show Desktop
      wvous-br-corner = 12; # Notification Centre
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      NewWindowTarget = "Home";
      ShowHardDrivesOnDesktop = false;
      ShowStatusBar = false;
      ShowPathbar = true;
      _FXSortFoldersFirst = true;
    };
    hitoolbox.AppleFnUsageType = "Change Input Source";
    loginwindow.GuestEnabled = false;
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0; # When Space Allows
    };
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      "com.apple.trackpad.forceClick" = true;
    };
    screencapture = {
      location = "~/Pictures";
      target = "clipboard";
    };
    trackpad = {
      Clicking = false; # Tap to Click
      TrackpadThreeFingerDrag = false;
    };
  };
}
