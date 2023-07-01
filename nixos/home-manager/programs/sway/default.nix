{ config, lib, pkgs, ...}:
let
 menu = "tofi-drun | xargs swaymsg exec --";
 term = "footclient";
in
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      startup = [
	{ command = "foot -s"; }
        { command = "wlsunset -o HDMI-A-1 -g 0.8 -s 23:30"; }
	{ command = "waybar"; }
        # exec gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'
        # exec gsettings set org.gnome.desktop.interface cursor-size 24
      ];
      # overriding some of the default keybindings
      keybindings = 
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${term}";
          "${modifier}+w" = "kill";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Shift+c" = "reload";

          "Mod1+m" = "exec playerctl --player=spotify play-pause";
          "Mod1+n" = "exec playerctl --player=spotify next";
          "Mod1+p" = "exec playerctl --player=spotify previous";

          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";

          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";
        };

      input = {
        "type:keyboard" = {
          xkb_layout = "us,il";
          xkb_options = "grp:win_space_toggle";
          repeat_rate = "70";
          repeat_delay = "200";
        };
        "type:pointer" = {
          accel_profile = "flat";
          dwt = "enabled";
          pointer_accel = "0";
          scroll_factor = "1";
        };
      };

      output = {
        HDMI-A-1 = {
          resolution = "1920x1080@144Hz";
          position = "0,0";
          subpixel = "rgb";
          background = "~/Wallpapers/wallhaven-p2e113.jpg fit";
        };
        DP-3 = {
          resolution = "2560x1440@165Hz";
          position = "1920,0";
          subpixel = "rgb";
          adaptive_sync = "on";
          background = "~/Wallpapers/waves.jpg fill";
        };
      };
      
      menu = "${menu}";
      terminal = "${term}";
      modifier = "Mod4";
      bars = [];

      gaps = {
        inner = 8;
        outer = 8;
      };

      window.commands = [
        {  command = "move workspace 3"; criteria = { class = "Spotify"; }; }
      ];

    };
    extraConfig = ''
      seat * hide_cursor when-typing enable
      default_border pixel 1
      client.focused #000000 #C0CAF5 #FFFFFF
      client.focused_inactive #000000 #414868 #FFFFFF
      client.unfocused #414868 #414868 #FFFFFF
    '';
    # seat seat0 xcursor_theme Bibata-Modern-Classic 24

    wrapperFeatures.gtk = true;
  };

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.systemd}/bin/loginctl lock-session"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f -c 000000"; }
    ];
  };
}
