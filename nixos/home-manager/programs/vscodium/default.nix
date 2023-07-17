{ config, pkgs, pkgs-unstable, inputs, ...}:
let
  # nixpkgs only supports a fraction of the actual amount of vscode extensions
  marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    gregoire.dance
    sainnhe.everforest
  ];
in
{
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;

    extensions = with pkgs.vscode-extensions; [
      b4dm4n.vscode-nixpkgs-fmt
      esbenp.prettier-vscode
      rust-lang.rust-analyzer
      jnoortheen.nix-ide
    ] ++ marketplace-extensions;

    mutableExtensionsDir = false;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = {
      editor = {
        cursorBlinking = "smooth";
        fontFamily = "'Iosevka Term Nerd Font'";
        fontSize = 18;
        letterSpacing = "-0.4";
        fontWeight = "600";
        formatOnSave = true;
        lineNumbers = "on";
        minimap.enabled = false;
        smoothScrolling = true;
        indentSize = "tabSize";
        cursorStyle = "block";
        tabSize = 4;

        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };
      };

      nix.serverPath = "${pkgs.nil}/bin/nil";
      "[nix]".editor.defaultFormatter = "B4dM4n.nixpkgs-fmt";
      "[nix]".editor.tabSize = 2;

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
      };

      workbench.colorTheme= "Everforest Dark";

      everforest = {
        darkContrast = "hard";
      };
    };
  };
}
