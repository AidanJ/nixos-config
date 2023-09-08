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
      {
        name = "completions";
      	src = inputs.zsh-completions;
      }
      {
        name = "fzf-tab";
      	src = inputs.fzf-tab;
      }
      {
        name = "syntax-highlighting";
      	src = inputs.zsh-syntax-highlighting;
      	file = "zsh-syntax-highlighting.zsh";
      }
    ];

    initExtra = ''
      FZF_TAB_COMMAND=(
            ${pkgs.fzf}/bin/fzf
            --ansi
            --expect='$continuous_trigger' # For continuous completion
            --nth=2,3 --delimiter='\x00'  # Don't search prefix
            --layout=reverse --height="''${FZF_TMUX_HEIGHT:=50%}"
            --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
            '--query=$query'   # $query will be expanded to query string at runtime.
            '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
            )
        zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
        zstyle ':completion:complete:*:options' sort false
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
    '';
  };
}
