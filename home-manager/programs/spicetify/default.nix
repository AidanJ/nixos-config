{ config, inputs, ...}:
{
  programs.spicetify = 
    let spicePkgs = inputs.spicetify-nix.packages.default;
    in {
      enable = true;
    };
}