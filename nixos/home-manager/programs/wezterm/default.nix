{ config, ...}:
{
  programs.wezterm = {
    enable = true;
    colorSchemes = {
      dark = {
        ansi = [
          "#27272a" "#f5a191" "#90b99f" "#e6b99d"
          "#aca1cf" "#e29eca" "#ea83a5" "#c1c0d4"
        ];
        brights = [
          "#353539" "#ffae9f" "#9dc6ac" "#f0c5a9"
          "#b9aeda" "#ecaad6" "#f591b2" "#cac9dd"
        ];
        background="#252221";
        foreground="#c9c7cd";
      };
    };
    extraConfig = ''
      local wezterm = require 'wezterm'
      return {
        font = wezterm.font { family = 'Iosevka Term Nerd Font', stretch = 'Condensed' },
        font_rules = {
            {
              intensity = 'Bold',
              italic = true,
              font = wezterm.font_with_fallback {
                weight = 'ExtraBold',
                italic = true,
              },
            },
            {
              intensity = 'Bold',
              italic = false,
              font = wezterm.font_with_fallback {
                weight = 'ExtraBold',
                italic = false,
              },
            },

            {
              intensity = 'Normal',
              italic = true,
              font = wezterm.font_with_fallback {
                weight = 'DemiBold',
                italic = true,
              },
            },
            {
              intensity = 'Normal',
              italic = false,
              font = wezterm.font_with_fallback {
                weight = 'DemiBold',
              },
            },
        },
        font_size = 14.0,
        color_scheme = "dark"
      }
    '';
  };
}
