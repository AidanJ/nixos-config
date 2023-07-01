{ config, ... }:

{
  programs.exa = {
    enable = true;
    icons = true;
    extraOptions = [ "--group-directories-first" ];
  };
}
