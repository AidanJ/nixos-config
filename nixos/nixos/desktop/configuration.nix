{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ../shared-configuration.nix
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      systemd-boot = {
        enable = true;
        editor = true;
        # Resolution
        consoleMode = "keep";
      };

      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 7;
    };
  };

  environment.systemPackages = with pkgs; [
    jq exa imv wl-clipboard foot
    lldb aspell
  ];

  hardware = {
    # cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        amdvlk
        vaapiVdpau
      ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  networking = {
    # quad9 dns
    nameservers = [ "9.9.9.9" "149.112.112.112"];
    dhcpcd.enable = true;
    # prevent from overridng specified nameserver
    dhcpcd.extraConfig = "nohook resolv.conf";
  };

}
