{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-cpu-intel

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ../shared-configuration.nix
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [ "mem_sleep_default=deep" ];

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
    lldb aspell acpi
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        vulkan-tools
        libvdpau-va-gl
      ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  services = {
    acpid.enable = true;
    upower.enable = true;
    thermald.enable = true;
  };

  networking = {
    # quad9 dns
    nameservers = [ "9.9.9.9" "149.112.112.112"];
    dhcpcd.enable = true;
    # prevent from overridng specified nameserver
    dhcpcd.extraConfig = "nohook resolv.conf";
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };
}
