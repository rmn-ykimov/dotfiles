{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
          pkgs.ffmpeg
          pkgs.git
          pkgs.git-lfs
          pkgs.stow
          pkgs.starship
          pkgs.postgresql
          pkgs.obsidian
          pkgs.zotero
          pkgs.utm
            #pkgs.godot_4 #no packages
          pkgs.lmstudio
            #pkgs.insomnia #no packages
          pkgs.docker
          pkgs.docker-compose
          pkgs.dbeaver-bin
          pkgs.darktable
            #pkgs.blender #no packages
            #pkgs.anki #no packages
          pkgs.google-chrome
          pkgs.tmux
          pkgs.rar
          pkgs.ripgrep
          pkgs.python313
          pkgs.python312
          pkgs.djvu2pdf
          pkgs.scons
          pkgs.cmake
          pkgs.vulkan-tools
          pkgs.tree
        ];

        homebrew = {
          enable = true;
          casks = [
            #"blender"
            "vlc"
            "godot"
          ];
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.defaults = {
        dock.autohide = true;
        };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Romans-MacBook-Air
    darwinConfigurations."Romans-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ 
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "roman";
            };
          }
        ];
    };
  };
}