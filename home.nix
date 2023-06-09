{ config, pkgs, ... }:

{
  home = {
    username = "jack";
    homeDirectory = "/home/jack";

    stateVersion = "22.11";

    packages = with pkgs; [
      ripgrep
      fzf
      jq
      tree
      tmux
      bazelisk
      meld
      starship
      neovim
      tmux
      zoxide
    ];

    file = {
      ".aliases".source = dotfiles/aliases;
      ".zshrc".source = dotfiles/zshrc;
      ".config/starship.toml".source = dotfiles/starship.toml;
      ".config/nvim/init.lua".source = dotfiles/init.lua;
      ".config/alacritty/alacritty.yml".source = dotfiles/alacritty.yml;
      ".tmux.conf".source = dotfiles/tmux.conf;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Github";
        italic-text = "always";
      };
    };

    gh = {
      enable = true;
      settings = {
        aliases = {
          web = "repo view --web";
        };
        git_protocol = "ssh";
        pager = "cat";
        editor = "nvim";
      };
    };

    git = {
      enable = true;
      userName = "Jack Greenberg";
      userEmail = "j@jackgreenberg.co";
      aliases = {
        lg = "log --decorate --graph --oneline";
        lag = "log --branches --decorate --graph --oneline";
      };
      extraConfig = {
        core = {
          editor = "/usr/bin/nvim";
          pager = "less -F -X";
        };
        pager = {
          branch = false;
          grep = false;
          stash = false;
          log = true;
        };
        init = {
          defaultBranch = "main";
        };
        merge = {
          tool = "meld";
        };
      };
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
      };
    };

    home-manager.enable = true;
  };
}
