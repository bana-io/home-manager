inputs@{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nix-index-database,
  ...
}:
let
  #   home-manager = import <home-manager> { inherit pkgs; };
  # nix-index-database = import <nix-index-database> { inherit pkgs; };
in
{
  # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  # Assuming that `./modules/` only contains `*.nix` files, the below imports them all.
  imports = map (fn: ./modules/${fn}) (builtins.attrNames (builtins.readDir ./modules));

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.11";

  home.backupFileExtension = "bak-${toString builtins.currentTime}";

  home.file = {
    "bin/ptyxis".source = ./bin/linux/ptyxis.sh;
    ".config/ghostty/config.ghostty".source = ./dotfiles/.config/ghostty/config.ghostty;
    ".config/ccache/ccache.conf".source = ./dotfiles/.config/ccache/ccache.conf;
    ".config/tio/config".source = ./dotfiles/.config/tio/config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".gdbinit".source = ./dotfiles/.gdbinit;
    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".source = ./dotfiles/.npmrc;
  };
  home.sessionVariables = {
    EDITOR = "code --wait --new-window";
    VISUAL = "code --wait --new-window";
  };
  home.sessionPath = [
    "/usr/lib/ccache"
    "/usr/lib/ccache/bin"
    "$HOME/bin"
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.npm-global/bin"
  ];

  targets.genericLinux.enable = true;
  xdg = {
    enable = true;
    mime.enable = true;
  };
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
