{ config, ... }:
{
  programs.starship = {
    # integrates with bash, zsh and fish by default
    enable = true;
    settings = {
      format = "$character";
      right-format = "$all";
      add_newline = false;
      scan_timeout = 5;

      character = {
        error_symbol = "[λ](bold red)";
        success_symbol = "[λ](bold green)";
        vicmd_symbol = "[λ](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };

      time = {
        disabled = false;
        time_format = "%H:%M";
        format = "$time ($style)";
      };

      username = {
        disabled = false;
        show_always = true;
      };

      hostname = {
        disabled = false;
        ssh_only = true;
        format = "[$hostname](bold blue) ";
      };

      sudo.disabled = false;
    };
  };
}
