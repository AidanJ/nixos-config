{ config, pkgs-unstable, ...}:
# let
#   # TODO: move to global inputs list in flake.nix
#   tmux-nova = pkgs-unstable.tmuxPlugins.mkTmuxPlugin {
#     pluginName = "tmux-nova";
#     version = "unstable-2023-02-17";
#     src = pkgs-unstable.fetchFromGitHub {
#       owner = "o0th";
#       repo = "tmux-nova";
#       rev = "7103fd78fec47c74e9a431c50e9543d0486d5201";
#       sha256 = "sha256-1A7pnMMOwp1K7+WAAKbTqrMpm/wcorui6TQDHm8Xzd8=";
#     };
#   };
# in
{
  programs.tmux = {
    enable = true;

    prefix = "M-e";
    keyMode = "vi";
    mouse = true;
    terminal = "foot";
    baseIndex = 1;
    escapeTime = 0;

    plugins = with pkgs-unstable; [
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.cpu
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      set -g status-interval 10
      set -g focus-events on
      set -g display-time 4000

      set -g @yank_selection 'primary'
      set -g @yank_selection_mouse 'secondary'

      # catppuccin statusbar configuration
      set -g @catppuccin_user on

      # applying vim-tmux-navigator bindings

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

    '';
  };
}
