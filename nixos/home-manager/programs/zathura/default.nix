{ config, ...}:
{
  programs.zathura = {
    enable = true;
    options = {
      default-bg = "#161616";
      selection-clipboard = "primary";
      adjust-open = "best-fit";
      scroll-page-aware = "true";
      font = "Inter 14";
      recolor-lightcolor = "#161616";
      recolor = "true";
      #  recolor-darkcolor "#E0E0E0"
      recolor-reverse-video = "true";
      recolor-keephue = "true";
      sandbox = "strict";
      scroll-step = 50;

    };
  };
}
