{ pkgs, config, ... }: 

{
  fonts.fontconfig.enable = true;             # Enables font installation
  home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ 
        "FiraCode" 
        "Meslo" 
        "JetBrainsMono" 
        
      ]; })
  ];

}