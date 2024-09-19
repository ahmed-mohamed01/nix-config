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
      #copy_on_select = "clipboard";

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
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";

      # SSH settings
      remote_kitty = "if-needed";
      share_connections = "yes";
      
    };
    extraConfig = ''
      mouse_map right press grabbed,ungrabbed paste_from_selection
      map ctrl+c copy_and_clear_or_interrupt
      map ctrl+v paste_from_clipboard
      '';
  };
  
}