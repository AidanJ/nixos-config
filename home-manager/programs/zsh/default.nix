{ config, pkgs, inputs, ...}:
{
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    autocd = true;
    enableAutosuggestions = true;

    shellAliases = {
      c = "clear";
      ls = "exa -ag --icons";
      ll = "exa -alg --icons";
      rm = "rm -vr";
      cp = "cp -vr";
      mv = "mv -v";
      grep = "grep --color=auto";
      ip = "ip --color";
      tree = "exa --tree --icons";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      size = 5000;
      save = 5000;
    };

    plugins = [
      pkgs.zsh-fzf-tab
      pkgs.zsh-nix-shell
      pkgs.zsh-syntax-highlighting
      pkgs.zsh-completions
    ];
    
  };
}
