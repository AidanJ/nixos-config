{ config, ...}:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      c = "clear";
    };

    shellAliases = {
      ls = "exa -ag --icons";
      ll = "exa -alg --icons";
      rm = "rm -vr";
      cp = "cp -vr";
      mv = "mv -v";
      grep = "grep --color=auto";
      ip = "ip --color";
      tree = "exa --tree --icons";
      nixc = "hx /etc/nixos";
      vimc = "vi ~/.config/nvim";
    };

    loginShellInit = ''
      set -U fish_greeting "🐟"
      function fish_command_not_found
        echo "fish: Unknown command '$argv'" >&2
      end
      '';
  };
}
