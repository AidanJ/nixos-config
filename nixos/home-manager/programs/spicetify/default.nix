{ config, inputs, pkgs, ...}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    enable = true;
    colorScheme = "flamingo";

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
  };
}
