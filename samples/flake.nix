# flake.nix

{
  description = "Sample flake for installing nodejs, pnpm in a devshell";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      #--------------------------------- Add more inputs here ---------------------------------#
      # Use https://www.nixhub.io/ to search for nix packages, copy the reference and package name
      # This can be added as an input in the following format:
      # [package-name].url = "github:nixos/nixpkgs/[reference]";
      #eg:
      #nodejs_22.url = "github:nixos/nixpkgs/56fc115880db6498245adecda277ccdb33025bc2";   
  
    };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-linux.default =
         #-------- Modify this section to install packages --------#
              nodejs   # This installs noejs from nixpkgs-unstable
              # inputs.nodejs_22.legacyPackages.${system}.nodejs_22  #--- use this to install a specific 
                                                                     # version of nodejs --------------#
            ];
          };
        # shellHook = ''        #-------- Modify this section to run commands on entering the sell ----#
        #   echo "weclome"
        #   source ./something.sh
        #   echo "to my shell!" | ${pkgs.lolcat}/bin/lolcat 
        # '';

        # COLOR = "blue"; #--------set environmental variables in this shell --------------------------#
        # PASSWORD = import ./password.nix; #-------- import a file and set a variable ----------------#
    };
}