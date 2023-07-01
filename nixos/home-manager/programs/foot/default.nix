{ config, ...}:
{
  programs.foot = {
    enable = true;
    # enables systemd user service, no need to execute from wm startup
    # server.enable = true;

    settings = {
      main = {
        font = "Iosevka Term Nerd Font:size=14:weight=Bold";
        font-bold= "Iosevka Term Nerd Font:size=14:weight=Heavy";
        font-italic= "Iosevka Term Nerd Font:size=14:weight=Bold:slant=italic";
        font-bold-italic= "Iosevka Term Nerd Font:size=14:weight=Heavy:slant=italic";

        letter-spacing = "-0.4";
        underline-offset = 1;
        box-drawings-uses-font-glyphs = "no";
        dpi-aware = "no";
        pad = "7x7 center";
      };
      
      scrollback.indicator-format = "line";

      cursor = {
        style = "beam";
        blink = "no";
        beam-thickness = "0.7";
      };

      # TODO switch to nix-colors
      colors = {
        background="252221";
        foreground="c9c7cd";
        regular0="27272a";  # black
        regular1="f5a191";  # red
        regular2="90b99f";  # green
        regular3="e6b99d";  # yellow
        regular4="aca1cf";  # blue
        regular5="e29eca";  # magenta
        regular6="ea83a5";  # cyan
        regular7="c1c0d4";  # white
        bright0="353539";   # bright black
        bright1="ffae9f";   # bright red
        bright2="9dc6ac";   # bright green
        bright3="f0c5a9";   # bright yellow
        bright4="b9aeda";   # bright blue
        bright5="ecaad6";   # bright magenta
        bright6="f591b2";   # bright cyan
        bright7="cac9dd";   # bright white
      };
    };
  };
}
