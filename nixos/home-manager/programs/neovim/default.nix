{ config, pkgs, ...}:
let
  nordic-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nordic.nvim";
    version = "2023-8-12";
    src = pkgs.fetchFromGitHub {
      owner = "AlexvZyl";
      repo = "nordic.nvim";
      rev = "78d7664d42033fd69c6bc61135115481c9aa56bf";
      sha256 = "sha256-+FDI4viWoeoBkxrM932zX3VrgEB/3GGHzoBf9IIlmBU=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;

    plugins = with pkgs.unstable.vimPlugins; [
      # Theming
      gruvbox-nvim
      nightfox-nvim
      oxocarbon-nvim
      nordic-nvim

      # Common
      plenary-nvim

      # Utility/Helpers
      mini-nvim
      nvim-autopairs
      comment-nvim
      hardtime-nvim

      # Version Control
      gitsigns-nvim
      neogit

      # Note taking
      neorg

      # LSP
      lsp-zero-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      lspkind-nvim

      clangd_extensions-nvim

      telescope-nvim
      telescope-fzf-native-nvim
      

      (nvim-treesitter.withPlugins (prev:  with prev; [
         c cpp lua nix fish json latex meson markdown
         make ninja rust vim yaml comment
         diff git_config git_rebase gitcommit gitignore
      ]))
    ];

    extraPackages = with pkgs; [ ripgrep fd lua-language-server];
  };
  
}
