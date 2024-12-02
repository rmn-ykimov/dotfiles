{
  description = "Ubuntu system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    
    commonPackages = with pkgs; [
      neovim
      ffmpeg
      git
      git-lfs
      stow
      starship
      tmux
      rar
      ripgrep
      python313
      scons
      cmake
      tree
      wget
      curl
      htop
    ];
  in
  {
    packages.${system}.default = pkgs.buildEnv {
      name = "ubuntu-environment";
      paths = commonPackages;
    };

    nixosConfigurations.ubuntu = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          environment.systemPackages = commonPackages;

          system.stateVersion = "23.11";

          users.users.your-username = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            shell = pkgs.bash;
          };
        })
      ];
    };
  };
}
