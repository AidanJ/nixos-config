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
    };

    loginShellInit = ''
      set -U fish_greeting "🐟" '';
  };
}
