# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
  ];

  environment = {
    shells = with pkgs; [ zsh fish ];
    systemPackages = with pkgs; [
      curl gcc git coreutils less glib gnutls man-pages
      man-pages-posix unzip neovim zip
    ];

    variables = {
      # EDITOR = "${pkgs.neovim}/bin/nvim";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      inter
      iosevka
      dejavu_fonts
      noto-fonts-emoji-blob-bin
      liberation_ttf
      (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "RobotoMono" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" ];
        sansSerif = [ "Liberation Sans" ];
        monospace = [ "Iosevka Term" ];
        emoji = [ "Blobmoji" ];
      };

      hinting = {
        enable = true;
        style = "hintslight";
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };

      antialias = true;
    };
  };

  i18n = {
    # supportedLocales = [  ];
    defaultLocale = "en_US.UTF-8";
  };

  programs = {
    zsh.enable = true;
    fish.enable = true;
    dconf.enable = true;
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

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
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  networking.hostName = "nixuwus";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users = {
    defaultUserShell = pkgs.fish;
    users.aidan = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "12";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "wheel" "audio" "video" "input" ];
    };
  };

  time = {
    timeZone = "Asia/Jerusalem";
    hardwareClockInLocalTime = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services = {
    dbus.enable = true;

    pipewire = {
      enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
  };

  security = {
    pam.services.swaylock.text = "auth include login";
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "aidan" ];
        persist = true;
      }];
    };
  };
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
