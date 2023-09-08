{ config, pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    package = pkgs.unstable.kitty;
    shellIntegration.enableFishIntegration = true;

    settings = {
      window_padding_width = 5;

      copy_on_select = "clipboard";

      cursor_shape = "beam";
      cursor_blink_interval = 0;

      mouse_hide_wait = 0;

      # colorscheme
      # selection_foreground = "none";
      # selection_background = "none";

      background="#252221";
      foreground="#c9c7cd";
      color0="#27272a";  # black
      color1="#f5a191";  # red
      color2="#90b99f";  # green
      color3="#e6b99d";  # yellow
      color4="#aca1cf";  # blue
      color5="#e29eca";  # magenta
      color6="#ea83a5";  # cyan
      color7="#c1c0d4";  # white
      color10="#353539";   # color1 black
      color11="#ffae9f";   # color1 red
      color12="#9dc6ac";   # color1 green
      color13="#f0c5a9";   # color1 yellow
      color14="#b9aeda";   # color1 blue
      color15="#ecaad6";   # color1 magenta
      color16="#f591b2";   # color1 cyan
      color17="#cac9dd";   # color1 white
    };
    extraConfig = ''
      font_family          IosevkaTerm NFM Medium 
      bold_font            IosevkaTerm NFM Bold
      italic_font          IosevkaTerm NFM Medium Italic
      bold_italic_font     IosevkaTerm NFM Bold Italic 
      font_size 14.0
      disable_ligatures always
      modify_font cell_height +1px
      # modify_font cell_width 91%
    '';
  };
}
