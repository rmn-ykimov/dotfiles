{ config, pkgs, ... }:

let
  # myuser = builtins.getEnv "USER";
  # myhome = builtins.getEnv "HOME";
  myuser = "stuart-warren";
  myhome = "/home/${myuser}";
in {
  home.username = "${myuser}";
  home.homeDirectory = "${myhome}";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    neofetch
    neovim
    git
    curl
    wget
    font-awesome_5
    nerdfonts
  ];
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  programs = {
    home-manager.enable = true;
    fzf.enable = true;
    jq.enable = true;
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    git = {
      enable = true;
      userName = "stuart-warren";
      userEmail = "stuartwarren83@gmail.com";
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "catppuccin";
    };
    gnome-terminal = {
      enable = true;
      profile."b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
        font = "Monospace 8";
        default = true;
        visibleName = "Terminal";
      };
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      history = {
        extended = true;
        ignoreSpace = true;
        share = false;
      };
      profileExtra = "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi";
    };
  };

  services = {
    ssh-agent.enable = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-xsession.windowMan>
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        focus = {
          followMouse = true;
          mouseWarping = true;
        };
        modifier = "Mod4";
        terminal = "gnome-terminal";
        window.titlebar = false;
      };
    };
  };
}
