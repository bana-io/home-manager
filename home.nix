#inputs@{
{
  lib,
  # self,
  # nixpkgs,
  # nixpkgs-unstable,
  # home-manager,
  # nix-index-database,
  ...
}:
# let
#   #   home-manager = import <home-manager> { inherit pkgs; };
#   # nix-index-database = import <nix-index-database> { inherit pkgs; };
# in
{
  # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

  # Assuming that `./modules/` only contains `*.nix` files, the below imports them all.
  imports = lib.pipe (builtins.readDir ./modules) [
    (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name))
    builtins.attrNames
    (map (fn: ./modules/${fn}))
  ];

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

  # home.backupFileExtension = "bak-${toString builtins.currentTime}";
  home.backupFileExtension = "bak";

  home.file = {
    ".local/bin/ptyxis" = {
      source = ./bin/linux/ptyxis.sh;
      executable = true;
    };
    ".config/ghostty/config.ghostty".source = ./dotfiles/.config/ghostty/config.ghostty;
    ".config/ccache/ccache.conf".source = ./dotfiles/.config/ccache/ccache.conf;
    ".config/tio/config".source = ./dotfiles/.config/tio/config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".gdbinit".source = ./dotfiles/.gdbinit;
    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".source = ./dotfiles/.npmrc;

    # AI Tools:

    # Antigravity by Google.
    # https://antigravity.google/docs/settings/
    ".gemini/antigravity-cli/settings.json".source = ./dotfiles/.gemini/antigravity-cli/settings.json;
    # See: https://antigravity.google/docs/cli/commands/agents/#creating-custom-agents
    ".gemini/config/agents/code-reviewer.md".source = ./dotfiles/.gemini/config/agents/code-reviewer.md;
    ".gemini/config/agents/tester.md".source = ./dotfiles/.gemini/config/agents/tester.md;
  };
  home.sessionVariables = {
    EDITOR = "code --wait --new-window";
    VISUAL = "code --wait --new-window";
  };
  home.sessionPath = [
    # TODO(bana-io): Remove `ccache` blocks below.
    # "/usr/lib/ccache"
    # "/usr/lib/ccache/bin"
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

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Iosevka" ];
      # serif = [ "Libertinus Serif" ];
      sansSerif = [ "Hanken Grotesk" ];
      # emoji = [ "Noto Color Emoji" ];
    };
  };

  programs.home-manager.enable = true;
}
