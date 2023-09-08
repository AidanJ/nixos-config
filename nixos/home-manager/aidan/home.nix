# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, pkgs-unstable, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    (import ../programs/exa { inherit config; })
    (import ../programs/bat { inherit config; })
    (import ../programs/tmux { inherit config pkgs-unstable; })
    (import ../programs/starship { inherit config; })
    (import ../programs/zsh { inherit config pkgs inputs; })
    (import ../programs/direnv { inherit config; })
    (import ../programs/fish { inherit config; })
    (import ../programs/foot { inherit config; })
    (import ../programs/kitty { inherit config pkgs; })
    (import ../programs/wezterm { inherit config; })
    (import ../programs/helix { inherit config; })
    # (import ../programs/emacs { inherit config pkgs inputs; })
    (import ../programs/neovim { inherit config pkgs; })
    (import ../programs/zathura { inherit config; })
    # TODO migrate to swayfx
    (import ../programs/sway { inherit config lib pkgs pkgs-unstable; })
    (import ../programs/waybar { inherit config; })
    # (import ../programs/vscodium { inherit config pkgs pkgs-unstable inputs; })
    (import ../programs/firefox { 
      inherit config inputs;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        firefox-color
      ];
    })
    (import ../programs/spicetify { inherit config inputs pkgs; })

    (import ../services/mako { inherit config; })
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nur.overlay

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.inter;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home = {
    username = "aidan";
    homeDirectory = "/home/aidan";

    packages = with pkgs; [
      # apps
      playerctl
      anki-bin
      pkgs-unstable.logseq
      pulsemixer
      ripgrep
      btop
      pkgs-unstable.zellij
      pkgs-unstable.wlsunset
      swaylock
      tofi
      fzf
      nnn
      swayidle
      pkgs-unstable.vscodium
      sway-contrib.grimshot
      speechd
      chromium

      # dev
      # clang
      # clang-tools
      # bear
      # lldb
      # ninja
      # valgrind
      nil
      rust-analyzer
      nixpkgs-fmt
      rustfmt
      clippy
      rustc
      cargo
      # meson
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
      gtk.enable = true;
      x11.enable = true;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";

    sessionVariables = {
      # Prefer wayland over Xwayland when possible
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;

    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/Documents";
      pictures = "${config.home.homeDirectory}/Pictures";
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

}
