## Direnv

Direnv can be used to automatically set up project specific environmental variables and packages when you open a directory.

1. Ensure direnv is enabled using home-manager.
2. Copy flake.nix from samples folder to root directory of the project, 
3. Modify packages section as needed.
4. Run the nix-shell environment using ```nix develop```
- This opens in bash by default
- Change to zsh using ```nix develop -c zsh```
5. To switch to this development environment automatically, create a .envrc file with ```use flake``` as content
- Run this command to do this ```echo "use flakes" >> .envrc```
- To prevent direnv from asking permission constantly, add the directory to a whitelist
```toml
# ~/.config/direnv/direnv.toml
[whitelist]
prefix = [ "/path/to/your/project"]
```

Now when you cd in to this directory, you will have access to the packages specified in the flake.nix

To install a specific version of a package you need for a project:
1. Go to https://www.nixhub.io/
2. Seach for the package and obtain the package name and reference
3. Modify the flake.nix - 
```nix
# Add the package and reference to input in the following format:
    [package-name].url = "github:nixos/nixpkgs/[reference]";
#eg:
    nodejs_22.url = "github:nixos/nixpkgs/56fc115880db6498245adecda277ccdb33025bc2";   
```
4. Now this package can be added to pkgs list with:
```nix
# Format: inputs.[input_name].legacyPackages.${system}.[package_name] eg:
 ... other code
        pkgs.mkShell
                {
                    nativeBuildInputs = with pkgs; [
                        typescript
                        inputs.nodejs_22.legacyPackages.${system}.nodejs_22
                };
```
Using this method, while other packages can me implicitly updated, node would be locked to the specified version. 
This can be used to search for older versions of node, python etc and add them to a project, and keep them locked to that version. 