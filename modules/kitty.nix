{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = true;
    # Enable catppuccino theme
    catppuccin.enable = true;
    catppuccin.flavor = "mocha";

    settings = {
      #title = "Kitty Terminal";
      #pad = "16x20";
      confirm_os_window_close = 0;
      # Font settings
      font_family = "FiraCode Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 11;
      copy_on_select = "clipboard";

      # Shell
      shell_integration = "enabled";
      shell = "zsh";

      background_blur = 15;
      background_opacity = "0.7";
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 5;
      # Tab bar settings
      tab_bar_style = "powerline";
      tab_bar_edge = "top";
      tab_bar_font_size = 12;
      # tab_bar_background = "#1E1E2E";
      # tab_bar_foreground = "#CDD6F4";
      tab_bar_font_family = "FiraCode Nerd Font";
      tab_bar_padding = "2";
      tab_bar_align = "left";
      tab_bar_min_tabs = 0;
      tab_switch_strategy = "previous";
      tab_powerline_style = "slanted";
      # map = {
      #   "ctrl+c copy_to_clipboard";
      #   "ctrl+v paste_from_clipboard";
      # };
      

      # The basic colors - Catppuccino Mocha
      # foreground = "#CDD6F4";
      # background = "#1E1E2E";
      # selection_foreground = "#1E1E2E";
      # selection_background = "#F5E0DC";

      # Cursor colors
      # cursor = "#F5E0DC";
      # cursor_text_color = "#1E1E2E";

      # Tab bar colors
      # active_tab_foreground = "#11111B";
      # active_tab_background = "#CBA6F7";
      # inactive_tab_foreground = "#CDD6F4";
      # inactive_tab_background = "#181825";
      # tab_bar_background = "#11111B";

      # # The 16 terminal colors
      # color0 = "#45475A";   # black
      # color8 = "#585B70";
      # color1 = "#F38BA8";   # red
      # color9 = "#F38BA8";
      # # green
      # color2 = "#A6E3A1";
      # color10 = "#A6E3A1";
      # # yellow
      # color3 = "#F9E2AF";
      # color11 = "#F9E2AF";
      # # blue
      # color4 = "#89B4FA";
      # color12 = "#89B4FA";
      # # magenta
      # color5 = "#F5C2E7";
      # color13 = "#F5C2E7";
      # # cyan
      # color6 = "#94E2D5";
      # color14 = "#94E2D5";
      # # white
      # color7 = "#BAC2DE";
      # color15 = "#A6ADC8";


      
    };
  };
  
}