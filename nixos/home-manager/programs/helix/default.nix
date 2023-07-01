{ config, ...}:
{
  programs.helix = {
    enable = true;
    
    settings = {
      theme = "darcula-solid";

      editor = {
        color-modes = true;
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";
        idle-timeout = 0;
      # lsp.display-inlay-hints = true
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };

        whitespace.render = "all";

        statusline = {
          left = ["mode" "version-control" "spinner"];
          center = ["file-name" "file-modification-indicator"];
          right = ["diagnostics" "position" "position-percentage" "file-line-ending" "file-type"];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
          
        };

        indent-guides = {
          render = true;
          skip-levels = 1;
        } ;
      };

      keys.normal = {
        X = "extend_line_above";
        "0" = "goto_line_start";
        "^" = "goto_first_nonwhitespace";
      };
    };
  };
}
