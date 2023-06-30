{ config, ... }:

{
  programs.exa = {
    enable = true;
    icons = true;
    enableAliases = true;
    extraOptions = [ "--group-directories-first" ];
  };
}
