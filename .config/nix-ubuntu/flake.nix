{
  description = "Ubuntu system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs@{ self, nixpkgs }: {
    nixosConfigurations.ubuntu = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;

          # Необходимо для использования flakes
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          environment.systemPackages = with pkgs; [
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
            python312
            tree

            # Базовые Linux-утилиты
            gcc
            gdb
            gnumake
            wget
            curl
            htop
          ];

          # Настройка пользователя
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
